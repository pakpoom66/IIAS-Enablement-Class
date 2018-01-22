#!/bin/bash

# Make appropriate changes to the following variables.  NOTE: given the size of this class only use 1 thread
threads="1"
loader="extTab"
cksum=yes
tout=1800
sdb=bdiXX      # change XX to your assigned team number
tdb=BLUDB
shost=9.30.106.112
suser="teamXX" # change XX to your assigned team number
tuser=teamXX   # change XX to your assigned team number
spw="Sailfish@2017"
tpw="Sailfish@2017"
sschema=bdinsights
tschema="bdiXX"  # change XX to your assigned team number


echo "------------------------------------------------------------------"
echo "db_migration started @ `date`"
echo "------------------------------------------------------------------"

#for host in node0101 node0102 node0103 node0104 node0105 node0106 node0107
#do
#   ssh ${host} nmon -fT -s 5 -c 720 -m /scratch/migrate/
#done

start=`date '+%s'`

dbmig="db_migrate -cksum ${cksum} -loader ${loader} -threads ${threads} -timeout ${tout} -sDB ${sdb} -tDB ${tdb} -sHost ${shost} -sUser ${suser} -tUser ${tuser} -sPassword ${spw} -tPassword ${tpw} -sschema ${sschema} -tschema ${tschema} -CreateTargetTable yes -TruncateTargetTable yes"
echo "Executing the following command:"
echo "  ${dbmig}"
${dbmig}

end=`date '+%s'`
elapsed=`expr $end - $start`
echo "------------------------------------------------------------------"
echo "db_migration started @ `date`"  Total elapsed time: ${elapsed} seconds.
echo "------------------------------------------------------------------"
