#!/bin/sh
#set -x

# This script is not supported by IBM.
# This script calls several scripts in the /nz/support/bin directory.
# These scripts each have their own license agreement.

while [ $# -ne 0 ]; do
  if [[ "$1" = "-"*[[:upper:]]* ]];
  then OPTION=`echo $1 | tr '[:upper:]' '[:lower:]'`
  else OPTION=$1
  fi

  case $OPTION in
        "-?"|"--?"|"-h"|"--h"|"-help"|"--help")
        shift
          DISPLAY_HELP=TRUE
          ;;
        esac
      done

#####################################################################################
if [ $DISPLAY_HELP ];
then cat << end-of-help; fi

#####################################################################################
Usage:    gather_nz_info

Purpose:  Gathers information on system settings such as multiple schema support, appliance
                stats, database sizes and database DDL.

                NOTE: This script if run by the ADMIN user can put a significant load
                on the system.  Please use a admin like account that is under WLM
                control to run this script.

Inputs:   None

Output:   A tar file is created at /tmp/nz/gather_nz_info.gz
                This file needs to be sent to the IBM representative who requested the script to be run.
#####################################################################################
end-of-help

if [ $DISPLAY_HELP ]; then
    exit
fi

####################################################################################
# Initial Set Up
#####################################################################################
rm -r /tmp/nz/gather_nz_info
rm /tmp/nz/gather_nz_info.gz
mkdir -p /tmp/nz/gather_nz_info
SDIR1=`pwd`
SDIR2=/nz/support/bin
##################################################################
# Check for INZA
##################################################################
nzcm --inza > /tmp/nz/gather_nz_info/is_inza_installed.txt
nzcm --registered >> /tmp/nz/gather_nz_info/is_inza_installed.txt
nzsql inza -c "select * from product" >> /tmp/nz/gather_nz_info/is_inza_installed.txt
##################################################################
# Check for Fluid Query and Multiple Schema Support
##################################################################
ls -al /nz/export/ae/products > /tmp/nz/gather_nz_info/is_fluidqry_installed.txt
ls -al /opt/nz/licenses >> /tmp/nz/gather_nz_info/is_fluidqry_installed.txt
cat /nz/data/postgresql.conf | grep -i schema > /tmp/nz/gather_nz_info/is_multiple_schema_on.txt
##################################################################
# Gather Netezza Global Information
##################################################################
cd /nz/support/bin
${SDIR2}/nz_stats > /tmp/nz/gather_nz_info/nz_stats.txt
${SDIR2}/nz_db_size -gb -tb > /tmp/nz/gather_nz_info/nz_db_size.txt
${SDIR2}/nz_ddl_group > /tmp/nz/gather_nz_info/nz_ddl_group.txt
${SDIR2}/nz_ddl_user > /tmp/nz/gather_nz_info/nz_ddl_user.txt
${SDIR2}/nz_ddl_grant_group > /tmp/nz/gather_nz_info/nz_ddl_grant_group.txt
${SDIR2}/nz_ddl_grant_user > /tmp/nz/gather_nz_info/nz_ddl_grant_user.txt
##################################################################
# Check Netezza WLM
##################################################################
nzsqa schedQueues | grep " OID=" > /tmp/nz/gather_nz_info/resource_groups.txt
nzsqa schedRules > /tmp/nz/gather_nz_info/scheduler_rules.txt
##################################################################
# Gather DDL Information
##################################################################
# NOTE:
# To run the nzdumpschema for a limited number of databases,
# create a file named nz_get_database_names.input(one database name per line)
# in the directory where you are running this script, then comment out
# Line #91 and uncomment Line #92.
##################################################################
${SDIR2}/nz_get_database_names | egrep -v "INZA|NZA|NZM|NZR|NZMSG|NZRC|NZVERIFY|SYSTEM" > /tmp/nz/gather_nz_info/nz_get_database_names.input
#Line92#cp ${SDIR1}/nz_get_database_names.input /tmp/nz/gather_nz_info
for i in `cat /tmp/nz/gather_nz_info/nz_get_database_names.input`
do
echo "Started Gathering Information for Database $i on `date`"
nzdumpschema -R $i > /tmp/nz/gather_nz_info/dumpschema.$i.txt
/nz/support/bin/nz_ddl $i > /tmp/nz/gather_nz_info/extracted.$i.ddl
echo "Completed gathering information for Database $i on `date`"
echo "***==================================================***"
done
##################################################################
# Tarball the Netezza Information gathered
##################################################################

tar -czvf /tmp/nz/gather_nz_info.gz /tmp/nz/gather_nz_info/*

echo "======================================================================"
echo "Please send the file /tmp/nz/gather_nz_info.gz to the IBM representative"
echo "======================================================================"
