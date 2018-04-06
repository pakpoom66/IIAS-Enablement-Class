#!/bin/bash

user=$USER
password=Sailfish@2017
dbname=BLUDB
tbschema=$user
hostnm=9.30.106.50

echo "----------------------------------------------"

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
  rows=`dbsql -t -d ${dbname} -h ${hostnm} -u ${user} -pw ${password} -schema ${tbschema} -c "select count(*) from ${tbname}"`
  rows_load=`dbsql -t -d ${dbname} -h ${hostnm} -u ${user} -pw ${password} -schema ${tbschema} -c "select count(*) from ${tbname}_LOAD"`
  rows_cur=`dbsql -t -d ${dbname} -h ${hostnm} -u ${user} -pw ${password} -schema ${tbschema} -c "select count(*) from ${tbname}_LOADCUR"`
  echo "${tbname}           : ${rows}"
  echo "${tbname}_LOAD      : ${rows_load}"
  echo "${tbname}_LOADCUR   : ${rows_cur}"
  echo "----------------------------------------------"
done
