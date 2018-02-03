#!/bin/bash

user=$USER
password=Sailfish@2018
dbname=BLUDB
tbschema=$user
#tbname="CALL_CENTER"
tbname="CATALOG_RETURNS"
hostnm=9.30.106.XXX
datdir=/scratch/home/poc/IBM/data
outdir=/scratch/home/${user}/load/log

mkdir -p $outdir

echo "==================================="
echo "Loading ${tbname} ..."
echo "==================================="

echo "Truncating table ${tbschema}.${tbname}..."
db2 -v connect to bludb user ${user} using ${password}
db2 -tv "truncate table ${tbschema}.${tbname}_LOAD immediate"

start=`date '+%s'`

file=${datdir}/${tbname}.del
echo $file
if [ -f ${file} ]
then
    echo "Loading ${file} into ${tbschema}.${tbname}_LOAD"
    db2 "LOAD FROM ${file} of del MODIFIED BY coldel, MESSAGES ${outdir}/${tbschema}.${tbname}.msg replace into ${tbschema}.${tbname}_LOAD"
else
    echo "File doesn't exist"
fi

db2 -v connect reset
db2 -v terminate

end=`date '+%s'`
elapsed=`expr $end - $start`
rows=`dbsql -t -d ${dbname} -h ${hostnm} -u ${user} -pw ${password} -schema ${tbschema} -c "select count(*) from ${tbname}_LOAD"`
echo "Load statistics"
echo "${tbname} loaded in $elapsed seconds "
echo "SQL count : ${rows}"
echo
