# Load / Data Movement Lab  

The typical scenario in a POC is that the customer will provide you data (files) to be loaded.  Prior to having the customer dump the entire dataset, request sample rows (1,000-10,000) for all the tables that you will load in the POC.  This will allow you to indentify any potential issues with the generated load files.

The data files have been prepared for you and are located in `/scratch/home/poc/data`.  The data files used in this lab do not include the schema in the file name.  This was done for this lab to allow all teams to load the same data files.  In a customer POC it is recommended that data files names include the schema. Example: `BDI00.CALL_CENTER.del`.  This will make scripting easier.

We will perform `dbload`, `Db2 LOAD`, `Db2 LOAD FROM CURSOR` and `CREATE TABLE AS SELECT...` (CTAS).  You are likely to use these load options during a POC depending on your goal for the data loading.  Also, you during a POC is is common to copy the data within the cluster or outside the cluster via `LOAD FROM CURSOR`.

* `dbload` (BEST PERFORMANCE)
* `Db2 LOAD` (BEST COMPRESSION)
* `Db2 LOAD FROM CURSOR` (BEST COMPRESSION for Copying data within the cluster and outside the cluster)
* `CREATE TABLE AS SELECT...` (Netezza compatibility)
* Federation (Fluid Query)

## Data file Information
| schema | table | file name | records | size |
|---|---|---|---:|---:|
|  BDIXX  |  CALL_CENTER  |  CALL_CENTER.del  |  15  |  6.7K  |
|  BDIXX  |  CATALOG_PAGE  |  CATALOG_PAGE.del  |  11,844  |  1.7M  |
|  BDIXX  |  CATALOG_RETURNS  |  CATALOG_RETURNS.del  |  720,174  |  126M  |
|  BDIXX  |  CATALOG_SALES  |  CATALOG_SALES.del  |  71,99,490  |  1.7G  |
|  BDIXX  |  CHAR_TEST  |  CHAR_TEST.del  |  258  |  8.3K  |
|  BDIXX  |  CUSTOMER  |  CUSTOMER.del  |  277,001  |  53M  |
|  BDIXX  |  CUSTOMER_ADDRESS  |  CUSTOMER_ADDRESS.del  |  138,001  |  23M  |
|  BDIXX  |  CUSTOMER_DEMOGRAPHICS  |  CUSTOMER_DEMOGRAPHICS.del  |  1,920,801  |  115M  |
|  BDIXX  |  DATE_DIM  |  DATE_DIM.del  |  73,050  |  12M  |
|  BDIXX  |  HOUSEHOLD_DEMOGRAPHICS  |  HOUSEHOLD_DEMOGRAPHICS.del  |  7,201  |  208K  |
|  BDIXX  |  INCOME_BAND  |  INCOME_BAND.del  |  21  |  314  |
|  BDIXX  |  INVENTORY  |  INVENTORY.del  |  49,329,000  |  920M  |
|  BDIXX  |  ITEM  |  ITEM.del  |  54,001  |  22M  |
|  BDIXX  |  PROMOTION  |  PROMOTION.del  |  389  |  82K  |
|  BDIXX  |  REASON  |  REASON.del  |  40  |  4.9K  |
|  BDIXX  |  SHIP_MODE  |  SHIP_MODE.del  |  21  |  2.4K  |
|  BDIXX  |  STORE  |  STORE.del  |  53  |  18K  |
|  BDIXX  |  STORE_RETURNS  |  STORE_RETURNS.del  |  1,437,911  |  203M  |
|  BDIXX  |  STORE_SALES  |  STORE_SALES.del  |  14,400,052  |  2.4G  |
|  BDIXX  |  TIME_DIM  |  TIME_DIM.del  |  86,401  |  9.4M  |
|  BDIXX  |  UTF8_TEST  |  UTF8_TEST.del  |  13  |  1.7K  |
|  BDIXX  |  WAREHOUSE  |  WAREHOUSE.del  |  8  |  1.4K  |
|  BDIXX  |  WEB_PAGE  |  WEB_PAGE.del  |  122  |  18K  |
|  BDIXX  |  WEB_RETURNS  |  WEB_RETURNS.del  |  359,991  |  60M  |
|  BDIXX  |  WEB_SALES  |  WEB_SALES.del  |  3,599,503  |  864M  |
|  BDIXX  |  WEB_SITE  |  WEB_SITE.del  |  35  |  14K  |

> Note: Replace XX with your assigned team number.

## Lab Exercise

Please see your assignments by team for the database that you are to migrate.  Since the Db2 Warehouse environment only supports a single database you are migrate the database using the database as part of the schema name.

For this lab you can ssh to the IIAS container or use your Db2 Client container.

### ssh to IIAS Db2 Warehouse container

`ssh teamXX@9.30.106.50 -p 50022`  # Replace XX with your assigned team number.

## Team assignments

  | Team/User | Database  | Schema  |
  |---|---|---|
  | team01  | bludb  | bdi01  |
  | team02  | bludb  | bdi02  |
  | team03  | bludb  | bdi03  |
  | team04  | bludb  | bdi04  |
  | team05  | bludb  | bdi05  |
  | team06  | bludb  | bdi06  |
  | team07  | bludb  | bdi07  |
  | team08  | bludb  | bdi08  |
  | team09  | bludb  | bdi09  |
  | team10  | bludb  | bdi10  |

  * User ID : teamXX
  * Password: Sailfish@2017
    > Replace XX with your assigned team number  
    
## Load the data files using `dbload`  
Load all existing tables from the files provided into your set of tables created in the migration lab.  Utilize the `db_load` script available in the Db2 Warehouse client container or in the Db2 Warehouse server container.

Data file directory: `/scratch/home/poc/data`  

You can access help by typing `dbload -h`.

Verify that the loaded rows match the records in the data files.  
[NZ Table counts](/SailfishClassOct2017/Labs/Migration/BDI_rowcounts.md)

[Sample `dbload` script for all tables](/SailfishClassOct2017/Labs/Load/dbload-all.sh).

[Sample `dbload` script for a single table](/SailfishClassOct2017/Labs/Load/dbload-1.sh). 

### Check compression after the load

```sql
select * 
from ( SELECT substr(tabschema,1,18) as tabschema
, substr(tabname,1,33) as tabname
, tableorg
, card
, npages
, pctpagessaved
, decimal(1/(1-float(pctpagessaved)/100),5,2) as compr_ratio 
FROM SYSCAT.TABLES 
WHERE tableorg='C' 
  and tabschema='<your-schema>' 
--and tabname='<your-table>' 
and card > 0 with ur )
order by tabname
;
```

## Load the data files using Db2 `LOAD`

Load a new set of BDI tables (26) from the files provided.  Utilize the Db2 `LOAD` utility available in the Db2 Warehouse client container (use `LOAD CLIENT` in the script) or in the Db2 Warehouse server container.

[Use the following DDL to create a new set of tables](/SailfishClassOct2017/Labs/Load/bdi_LOAD.ddl).

Data file directory: `/scratch/home/poc/data`  

You can access help by typing `db2 load ?`.

Verify that the loaded rows match the records in the data files.  
[NZ Table counts](/SailfishClassOct2017/Labs/Migration/BDI_rowcounts.md )

[Sample Db2 `LOAD` script for all tables](/SailfishClassOct2017/Labs/Load/db2load-all.sh).

[Sample Db2 `LOAD` script for a single table](/SailfishClassOct2017/Labs/Load/db2load-1.sh). 

### Check compression after the load

```sql
select * 
from ( SELECT substr(tabschema,1,18) as tabschema
, substr(tabname,1,33) as tabname
, tableorg
, card
, npages
, pctpagessaved
, decimal(1/(1-float(pctpagessaved)/100),5,2) as compr_ratio 
FROM SYSCAT.TABLES 
WHERE tableorg='C' 
  and tabschema='<your-schema>' 
--and tabname='<your-table>' 
and card > 0 with ur )
order by tabname
;
```

## Load the data files using Db2 `LOAD FROM CURSOR`  

Copy data from the base tables into new BDI tables (26).   Utilize the Db2 `LOAD FROM CURSOR` utility available in the Db2 Warehouse client container (use `LOAD CLIENT` in the script) or in the Db2 Warehouse server container.  This is an in-place copy method.

[Use the following DDL to create a new set of tables](/SailfishClassOct2017/Labs/Load/bdi_LOADCUR.ddl).

You can access help by typing `db2 load ?`.

Verify that the loaded rows match the records in the data files.  
[NZ Table counts](/SailfishClassOct2017/Labs/Migration/BDI_rowcounts.md )

[Sample Db2 `LOAD FROM CURSOR` script for all tables](/SailfishClassOct2017/Labs/Load/db2loadcur-all.sh).

[Sample Db2 `LOAD FROM CURSOR` script for a single table](/SailfishClassOct2017/Labs/Load/db2loadcur-1.sh). 

### Check compression after the load

```sql
select * 
from ( SELECT substr(tabschema,1,18) as tabschema
, substr(tabname,1,33) as tabname
, tableorg
, card
, npages
, pctpagessaved
, decimal(1/(1-float(pctpagessaved)/100),5,2) as compr_ratio 
FROM SYSCAT.TABLES 
WHERE tableorg='C' 
  and tabschema='<your-schema>' 
--and tabname='<your-table>' 
and card > 0 with ur )
order by tabname
;
```

## Copy a table using `CREATE TABLE AS` (CTAS)

Copy data from the base tables into new BDI tables (26).  Utilize the `CREATE TABLE AS` SQL statment from the Db2 Warehouse client container or in the Db2 Warehouse server container.  This is an in-place copy method.

[Use the following CTAS DDL](/SailfishClassOct2017/Labs/Load/bdi_CTAS.ddl).

[CTAS information](https://www.ibm.com/support/knowledgecenter/en/SS6NHC/com.ibm.swg.im.dashdb.apdv.porting.doc/doc/r_sql_compat_ctas.html).

Verify that the loaded rows match the records in the data files.  
[NZ Table counts](/SailfishClassOct2017/Labs/Migration/BDI_rowcounts.md )

### Check compression after the load

```sql
select * 
from ( SELECT substr(tabschema,1,18) as tabschema
, substr(tabname,1,33) as tabname
, tableorg
, card
, npages
, pctpagessaved
, decimal(1/(1-float(pctpagessaved)/100),5,2) as compr_ratio 
FROM SYSCAT.TABLES 
WHERE tableorg='C' 
  and tabschema='<your-schema>' 
--and tabname='<your-table>' 
and card > 0 with ur )
order by tabname
;
```

## Load using Federation

> Note: Sorry ran out of time!!!  Thanks for getting to the end.  On the roadmap :).


