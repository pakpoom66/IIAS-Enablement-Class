# Lab Exercise

 If you were on an IIAS system, you would ssh to the IIAS container or use your Db2 Client container.  On this system, you will use the desktop launcher `Login as bluadmin to Db2wh`  This will open up a terminal and `su - bluadmin`



# Creating database objects

  * If running from a remote machine (i.e. Db2 Warehouse Client Container)
     > Db2 CLP commands.

     > `db2 connect to bludb user bluadmin using bluadmin`  
     > `db2 "CREATE..."`  
     > `db2 connect reset`  

     > DB Client commands:
     > `dbsql -h localhost -u bluadmin -pw bluadmin -c "\<sql command\>"`  

    You can set the following variables to simplify the `dbsql` command.  

    ```
    export DB_HOST=localhost
    export DB_USER=bluadmin
    export DB_PASSWORD=bluadmin
    export DB_DATABASE=bludb
    ```  

    > Note: replace BDI with your team ID in the examples below.
    > Note: add the export commands to your .bashrc file.  

## Partition Groups

A database partition group is a named set of one or more database partitions (Data Slices / Multiple Logical Nodes(MLNs)) that belong to a database.

A database partition group that contains more than one database partition is known as a multiple partition database partition group. Multiple partition database partition groups can only be defined with database partitions that belong to the same instance.

### Default database partition groups (data slices / MLN)

Three database partition groups are defined automatically at database creation time:

* `IBMCATGROUP` for the `SYSCATSPACE` table space, holding system catalog tables - database partition 0
* `IBMDEFAULTGROUP` for the `USERSPACE1` table space, holding user tables and indexes. A user temporary table space for a declared temporary table or a created temporary table can be created in IBMDEFAULTGROUP or any user-created database partition group, but not in IBMTEMPGROUP.

IIAS database partition groups
`DSMDBPG` for Data Server Manager only
`DSMGROUP` for Data Server Manager only
`SPLDBPG` single partition group on database partition 0 (MLN 0)

> Note: Keep the database partition groups as-is.  You do not need to create additional database partition groups in IIAS.  Table spaces map to a database partition group, this is how table spaces are defined to data slice(s).

> Note:

1. Explore the database partition groups associated with the `BLUDB`.  

   `dbsql -c "select * from SYSCAT.DBPARTITIONGROUPDEF order by 1, 2;"`  

   * db2clp example only:  
   `db2 LIST DATABASE PARTITION GROUPS;`  
   `db2 LIST DATABASE PARTITION GROUPS SHOW DETAIL;`  

## Table spaces

A table space is a storage structure containing tables, indexes, large objects, and long data. They are used to organize data in a database into logical storage groupings that relate to where data is stored on a system. Table spaces are stored in database partition groups.
Using table spaces to organize storage offers a number of benefits:

* Recoverability
    Putting objects that must be backed up or restored together into the same table space makes backup and restore operations more convenient, since you can backup or restore all the objects in table spaces with a single command. If you have partitioned tables and indexes that are distributed across table spaces, you can backup or restore only the data and index partitions that reside in a given table space.
* More tables
    There are limits to the number of tables that can be stored in any one table space; if you have a need for more tables than can be contained in a table space, you need only to create additional table spaces for them.
* Automatic storage management
    With automatic storage table spaces table spaces, storage is managed automatically. The database manager creates and extends containers as needed.

> RECOMMENDATION: CREATE table spaces for each application grouping / subject area / fact table / dimensional tables (all).

1. Create a table space for your fact table and dim tables

   * Create table space in partition group

      `dbsql -c "CREATE TABLESPACE BDI_TSFACT IN IBMDEFAULTGROUP"`  
      `dbsql -c "CREATE TABLESPACE BDI_TSDIM IN IBMDEFAULTGROUP"`  

   > NOTE: It is recommended that the table spaces used for small tables be put in IBMDEFAULTGROUP.  Both fact tables and dimension tables should be create in a table space that spans IBMDEFAULTGROUP (database partition 1 - X).

## Create SCHEMA

* Create a schema as follows

   `dbsql -c "create schema bdi_lab;"`  


## Create Tables in a table space

[Details on partitioned tables](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.admin.partition.doc/doc/c0021560.html)

* Create a dimension table.  Copy/past the DDL below into a file (vi).  


   ```sql
   SET CURRENT SCHEMA BDI_LAB;  

   CREATE TABLE time_dim
   (
   time_code     INT,
   order_date    DATE,
   month_code    SMALLINT,
   month_name    CHAR(10),
   quarter_code  SMALLINT,
   quarter_name  CHAR(10),
   year INTEGER
   )
   distribute by random
   in BDI_TSDIM
   ;
   ```  

   `dbsql -f <your-filename>`

   You can used the file named [dimension.sql](Labs/CreateDBObjects/dimension.sql) located in `~/labs/create` in the Db2wh container.

* Create a fact table.  Copy/past the DDL below into a file.  


   ```sql
   CREATE TABLE sales_fact
   (
   customer_code  INTEGER,
   district_code  SMALLINT,
   time_code      INTEGER,
   product_code   INTEGER,
   units_sold     SMALLINT,
   revenue        DECIMAL(8,2),
   cost           DECIMAL(8,2),
   net_profit     DECIMAL(8,2)
   )
   distribute by (customer_code)
   in BDI_TSFACT
   ;
   ```  

   `dbsql -f <your-filename>`

   You can used the file named [fact.sql](Labs/CreateDBObjects/fact.sql) located in `~/labs/create` in the Db2wh container.


   * Check the table definition (db2clp example).  
   `db2 connect to bludb`  
   `db2 list tables for schema BDI_lab`  
   `db2 DESCRIBE TABLE BDI_lab.time_fact;`  
   `db2 DESCRIBE TABLE BDI_lab.sales_fact;`  

* Check the table definition (dbsql example).  

   ```  
   dbsql  
   set schema BDI_lab;   
   select tabschema, tabname from syscat.tables where tabschema = 'BDIXX';
   \d time_fact;  
   \d sales_fact;
   ```  

* Drop any objects you created during your exploration.  

   `dbsql -c "DROP TABLE BDI_lab.time_dim;"`    
   `dbsql -c "DROP TABLE BDI_lab.sales_fact;"`  
   `dbsql -c "DROP TABLESPACE BDI_TSDIM;"`  
   `dbsql -c "DROP TABLESPACE BDI_TSFACT;"`  
