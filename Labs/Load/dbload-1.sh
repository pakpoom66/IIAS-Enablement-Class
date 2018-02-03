#!/bin/bash

user=$USER
password=Sailfish@2018
dbname=BLUDB
tbschema=$user
tbname=CATALOG_RETURNS
hostnm=9.30.106.XXX
datdir=/scratch/home/poc/IBM/data/
outdir=/scratch/home/${user}/load/log

mkdir -p ${outdir}

cd ${datdir}

echo "==================================="
echo "Loading ${tbname} ..."
echo "==================================="

echo "Truncating table ${tbschema}.${tbname}..."
db2 -v connect to bludb user ${user} using ${password}
db2 -tv "truncate table ${tbschema}.${tbname} immediate"
db2 -v connect reset
db2 -v terminate

start=`date '+%s'`

file=${datdir}/${tbname}.del
if [ -f ${file} ]
then
    echo "Loading ${file} into ${tbschema}.${tbname}"
    dbload \
               -host ${hostnm} \
               -u ${user} \
               -pw ${password} \
               -db ${dbname} \
               -schema ${tbschema} \
               -t ${tbname} \
               -delim ',' \
               -quotedValue DOUBLE \
               -dateStyle ymd \
               -dateDelim '' \
               -df ${file} \
               -outputDir ${outdir} \
               -maxErrors 1000 \
               -boolStyle TRUE_FALSE \
               -lf ${tbschema}.${tbname}.dblog \
               -bf ${tbschema}.${tbname}.dbbad
else
     echo "File doesn't exist"
fi

end=`date '+%s'`
elapsed=`expr $end - $start`
rows=`dbsql -t -d ${dbname} -h ${hostnm} -u ${user} -pw ${password} -schema ${tbschema} -c "select count(*) from ${tbname}"`
echo "Load statistics"
echo
grep "number of" ${outdir}/${tbschema}.${tbname}.dblog
echo
echo "${tbname} loaded in $elapsed seconds "
echo "SQL count : ${rows}"
echo
