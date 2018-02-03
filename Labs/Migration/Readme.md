# Migration Lab

The following details the Migration Lab.  This lab is a similation of a simple  IBM Integrated Analytics System (IIAS) Migration POC pulling data and queries from an existing Netezza system (see [Lab Narrative](/Labs/Migration/LabNarrative.md)).  You will migrate an existing database on a Netezza system to IIAS running Db2 Warehouse.  Both of these system are in the SVL POC Lab connected by a single 10Gb network cable.

Each of the assigned groups (team01 - team10) will migrate their assigned database on Netezza to a schema on Db2 Warehouse inside the IIAS system.  See `Database migration` below.

## Lab Narrative

Read the [Lab Narrative](/Labs/Migration/LabNarrative.md) to understand the background of the Lab/POC.

## Lab Exercise

Please see your assignments by team for the database that you are to migrate.  Since the Db2 Warehouse environment only supports a single database you are migrate the database using the database as part of the schema name.

For this lab you can ssh to the IIAS container or use your Db2 Client container.

### Direct ssh to IIAS Db2 Warehouse container

#### team01-team06  
   `ssh teamXX@9.30.106.50 -p 50022`  # where XX is your assigned team number  

#### team07-team12  
   `ssh teamXX@9.30.106.115 -p 50022`  # where XX is your assigned team number

## Database migration assignments by team

   ### Database migration

  | Team/User | Source Host  | Target Host  | Source Database  | Target Database  | Source Schema  | Target Schema  |
  |:---:|:---:|:---:|:---:|:---:|:---:|:---:|
  | team01  | 9.30.106.112  | 9.30.106.50  | bdi01 | bludb  | BDINSIGHTS  | bdi01  |
  | team02  | 9.30.106.112  | 9.30.106.50  | bdi02 | bludb  | BDINSIGHTS  | bdi02  |
  | team03  | 9.30.106.112  | 9.30.106.50  | bdi03 | bludb  | BDINSIGHTS  | bdi03  |
  | team04  | 9.30.106.112  | 9.30.106.50  | bdi04 | bludb  | BDINSIGHTS  | bdi04  |
  | team05  | 9.30.106.112  | 9.30.106.50  | bdi05 | bludb  | BDINSIGHTS  | bdi05  |
  | team06  | 9.30.106.112  | 9.30.106.50  | bdi06 | bludb  | BDINSIGHTS  | bdi06  |
  | team07  | 9.30.106.112  | 9.30.106.115  | bdi07 | bludb  | BDINSIGHTS  | bdi07  |
  | team08  | 9.30.106.112  | 9.30.106.115  | bdi08 | bludb  | BDINSIGHTS  | bdi08  |
  | team09  | 9.30.106.112  | 9.30.106.115  | bdi09 | bludb  | BDINSIGHTS  | bdi09  |
  | team10  | 9.30.106.112  | 9.30.106.115  | bdi10 | bludb  | BDINSIGHTS  | bdi10  |
  | team11  | 9.30.106.112  | 9.30.106.115  | bdi10 | bludb  | BDINSIGHTS  | bdi10  |
  | team12  | 9.30.106.112  | 9.30.106.115  | bdi10 | bludb  | BDINSIGHTS  | bdi10  |

  
## Phase 1 of POC
Phase 1 of the POC will be to migrate all 26 tables from the Netezza system to IIAS.  Utilize the `db_migrate` script available in the Db2 Warehouse client container or in the Db2 Warehouse server container.

Please migrate your assigned database to your assigned target schema, see assignments above.

You can access help by typing `db_migrate -h`.

* NZ User ID : teamXX
* NZ Password: Sailfish@2018
  > Where XX is your assigned team number

Verify that your migrated rows match the rows in the source system.
[NZ Table counts](/Labs/Migration/BDI_rowcounts.md )

Compare the table sizes between the Netezza and IIAS.  On IIAS use the `db_size` script to get tables size information.
[NZ Table sizes](/Labs/Migration/BDI_DBSize.md)

[Sample migration script](/Labs/Migration/migrate.sh)
 
Report any issues found during initial migration and correct all errors.

Did you have any tables fail during the db_migration?  
How many tables failed? Why?  
How did you fix the failed tables?  

Single table migration [script](/Labs/Migration/migrate-table.sh) example. 

### Extra Credit: Migrate Netezza tables using IBM Database Harmony Profiler

1. Drop all tables migrated above.  
   
   #### Using Db2 CLP  
      * Inside the Db2 Warehouse Server container  
        `db2 connect to bludb`  
   
      * From your Db2 Warehouse Client container  
        `db2 connect to <your-remote-DB> user <your-team-ID> using Sailfish@2018`  
        
      `db2 -x "list tables for schema bdiXX_bdi" |awk '{print "drop table " $2 "."  $1 ";"}' |db2`  
      * Where XX is your assigned team number.  

1. Use [IBM Data Harmony Profiler](https://www.ibm.com/developerworks/community/blogs/05901c97-75b2-47a1-9c32-25f748855913/entry/Introducing_DCW_Lite?lang=en) to create tables prior to running db_migrate.
> Note: Db2 Harmony Profiler Tool download link available in IIAS Console.  

   * [Netezza Source DDL](/Labs/Migration/NZQueries/nzbdinsights.ddl)

1. Run the converted DDL.  Make sure that your schema is teamXX, where XX is your assigned team number.

1. Run db_migrate without `-RecreateTargetTable yes -CreateTargetTable yes`

   Did you have any failed tables?

## Phase 2 of POC

Phase 2 convert and run the following Netezza queries:

* Run as-is and see what error you receive.  Then convert the SQL to run on Db2 Warehouse.

> Note: set your schema before running these queries.
`set current schema bdiXX`
* Where XX is your assigned team number.

### SQL1
```
SELECT CC_REC_START_DATE + 10 from CALL_CENTER LIMIT ALL;
```

### SQL2
```
SELECT CC_REC_START_DATE + interval '10 days' from CALL_CENTER;
```

### SQL3
```
insert into UTF8_TEST values ("abcd", "abcd", 4); --SAMPLE_STRING
```

### SQL4
```
INSERT INTO UTF8_TEST(BASE_LANGUAGE, SAMPLE_STRING, DISTRIBUTION_COLUMN) values( 'abcd' , 'euro euro', 4);
```

### SQL5
```
INSERT INTO UTF8_TEST(BASE_LANGUAGE, SAMPLE_STRING, DISTRIBUTION_COLUMN) values( 'abcd' , 'euro euro', 4);
```

### SQL6
```
INSERT INTO WEB_PAGE values ( 10,cast('id' as varchar(10)), now() , CURRENT_DATE ,10,10,'y',10,'y', substr('wearehere', 4), 10,10,10,10);
```

### SQL7
```
SET FACTREL_SIZE_THRESHOLD = 25000000;
SELECT NUMERIC(WR_RETURN_AMT) FROM WEB_RETURNS;
```

### SQL8
```
SELECT NUMERIC(WR_RETURN_AMT,7,2) FROM WEB_RETURNS;
```

### SQL9
```
SELECT (WR_RETURN_AMT)::NUMERIC(7,2) FROM WEB_RETURNS;
```

* [Netezza Source DML](/Labs/Migration/NZQueries/nzbdinsights.sql)

