#!/bin/bash

user=$USER
password=Sailfish@2017
dbname=BLUDB
tbschema=$user
hostnm=9.30.106.50
datdir=/scratch/home/poc/data
outdir=/scratch/home/${user}/load/log

mkdir -p ${outdir} 

begin=`date '+%s'`

cd ${datdir}
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
done
final=`date '+%s'`
elapsed=`expr $final - $begin`
echo "Total load $elapsed seconds "
