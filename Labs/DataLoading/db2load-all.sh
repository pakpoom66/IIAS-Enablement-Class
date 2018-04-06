#!/bin/bash

user="$USER"
password="<password-provided>"
dbname="BLUDB"
tbschema=$user"
hostnm="9.30.106.XXX"
datdir="/scratch/home/poc/IBM/data"
outdir="/scratch/home/${user}/load/log"

mkdir -p $outdir

db2 -v connect to bludb user ${user} using ${password}

begin=`date '+%s'`

for tbname in \
       CALL_CENTER \
       CATALOG_PAGE \
       CATALOG_RETURNS \
       CATALOG_SALES \
       CHAR_TEST \
       CUSTOMER \
       CUSTOMER_ADDRESS \
       CUSTOMER_DEMOGRAPHICS \
       DATE_DIM \
       HOUSEHOLD_DEMOGRAPHICS \
       INCOME_BAND \
       INVENTORY \
       ITEM \
       PROMOTION \
       REASON \
       SHIP_MODE \
       STORE \
       STORE_RETURNS \
       STORE_SALES \
       TIME_DIM \
       UTF8_TEST \
       WAREHOUSE \
       WEB_PAGE \
       WEB_RETURNS \
       WEB_SALES \
       WEB_SITE
do

   echo "==================================="
   echo "Loading ${tbname} ..."
   echo "==================================="

   start=`date '+%s'`

   file=${datdir}/${tbname}.del
   echo $file
   if [ -f ${file} ]
   then
       echo "Truncating table ${tbschema}.${tbname}..."
       db2 -tv "truncate table ${tbschema}.${tbname}_LOAD immediate"
       echo "Loading ${file} into ${tbschema}.${tbname}_LOAD"
       db2 "LOAD FROM ${file} of del MODIFIED BY coldel, MESSAGES ${outdir}/${tbschema}.${tbname}.msg replace into ${tbschema}.${tbname}_LOAD"
   else
       echo "File doesn't exist"
   fi

   end=`date '+%s'`
   elapsed=`expr $end - $start`
   rows=`dbsql -t -d ${dbname} -h ${hostnm} -u ${user} -pw ${password} -schema ${tbschema} -c "select count(*) from ${tbname}_LOAD"`
   echo "Load statistics"
   echo "${tbname} loaded in $elapsed seconds "
   echo "SQL count : ${rows}"
   echo
done

db2 -v connect reset
db2 -v terminate

final=`date '+%s'`
elapsed=`expr $final - $begin`
echo "Total load $elapsed seconds "
