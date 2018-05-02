# Load / Data Movement Lab  

The typical scenario in a POC is that the customer will provide you data (files) to be loaded.  Prior to having the customer dump the entire dataset, request sample rows (1,000-10,000) for all the tables that you will load in the POC.  This will allow you to identify any potential issues with the generated load files.

The data files have been prepared for you and are located in `/scratch/home/lab/data`.  The data files used in this lab do not include the schema as part of the the file name.  This was done for this lab to have one set of data files that all teams use to load.  In a customer POC it is recommended that data files names include the schema as part of the data file name. Example: `BDIPOC.CALL_CENTER.del`.  This will make scripting easier.

We will perform the following types of loads: `dbload`, `Db2 LOAD`, `Db2 LOAD FROM CURSOR`, `CREATE TABLE AS SELECT...` (CTAS) and Federation.  You are likely to use these load options/methods during a POC depending on your goal for the data loading.  

   1.  `dbload` (BEST PERFORMANCE)
   1.  `Db2 LOAD` (BEST COMPRESSION)
   1.  `Db2 LOAD FROM CURSOR` (BEST COMPRESSION for Copying data within the cluster and outside the cluster)
   1. `CREATE TABLE AS SELECT...` (Netezza CTAS Style)
   1.  Federation (Ease of data movement - slowest performing and poorest compression)


## Table and Data Information

| schema | table | file name | records | size |
|---|---|---|---:|---:|
|  TEAMXX  |  CALL_CENTER  |  CALL_CENTER.del  |  15  |  6.7K  |
|  TEAMXX  |  CATALOG_PAGE  |  CATALOG_PAGE.del  |  11,844  |  1.7M  |
|  TEAMXX  |  CATALOG_RETURNS  |  CATALOG_RETURNS.del  |  720,174  |  126M  |
|  TEAMXX  |  CATALOG_SALES  |  CATALOG_SALES.del  |  71,99,490  |  1.7G  |
|  TEAMXX  |  CUSTOMER  |  CUSTOMER.del  |  277,001  |  53M  |
|  TEAMXX  |  CUSTOMER_ADDRESS  |  CUSTOMER_ADDRESS.del  |  138,001  |  23M  |
|  TEAMXX  |  CUSTOMER_DEMOGRAPHICS  |  CUSTOMER_DEMOGRAPHICS.del  |  1,920,801  |  115M  |
|  TEAMXX  |  DATE_DIM  |  DATE_DIM.del  |  73,050  |  12M  |
|  TEAMXX  |  HOUSEHOLD_DEMOGRAPHICS  |  HOUSEHOLD_DEMOGRAPHICS.del  |  7,201  |  208K  |
|  TEAMXX  |  INCOME_BAND  |  INCOME_BAND.del  |  21  |  314  |
|  TEAMXX  |  INVENTORY  |  INVENTORY.del  |  49,329,000  |  920M  |
|  TEAMXX  |  ITEM  |  ITEM.del  |  54,001  |  22M  |
|  TEAMXX  |  PROMOTION  |  PROMOTION.del  |  389  |  82K  |
|  TEAMXX  |  REASON  |  REASON.del  |  40  |  4.9K  |
|  TEAMXX  |  SHIP_MODE  |  SHIP_MODE.del  |  21  |  2.4K  |
|  TEAMXX  |  STORE  |  STORE.del  |  53  |  18K  |
|  TEAMXX  |  STORE_RETURNS  |  STORE_RETURNS.del  |  1,437,911  |  203M  |
|  TEAMXX  |  STORE_SALES  |  STORE_SALES.del  |  14,400,052  |  2.4G  |
|  TEAMXX  |  TIME_DIM  |  TIME_DIM.del  |  86,401  |  9.4M  |
|  TEAMXX  |  WAREHOUSE  |  WAREHOUSE.del  |  8  |  1.4K  |
|  TEAMXX  |  WEB_PAGE  |  WEB_PAGE.del  |  122  |  18K  |
|  TEAMXX  |  WEB_RETURNS  |  WEB_RETURNS.del  |  359,991  |  60M  |
|  TEAMXX  |  WEB_SALES  |  WEB_SALES.del  |  3,599,503  |  864M  |
|  TEAMXX  |  WEB_SITE  |  WEB_SITE.del  |  35  |  14K  |



## Lab Overview

For this lab ,you will load data from inside the Db2 Warehouse container.   Now to load data into the BDI tables that you will create under your user default schema, so no need to prepend a schema name.  If IIAS, then create using the ID schema [`teamXX`].  You will have three sets of BDI tables to load, the tables will have the following extension added to the their name: `_DBLOAD`, `_DB2LOAD`, `_CURLOAD`, `_CTAS` and `FEDLOAD`.

Example for base table `CALL_CENTER` the following extension is added to the name:  
```
TEAMXX.CALL_CENTER_DBLOAD
TEAMXX.CALL_CENTER_DB2LOAD
TEAMXX.CALL_CENTER_CURLOAD
TEAMXX.CALL_CENTER_CTASLOAD
TEAMXX.CALL_CENTER_FEDLOAD
```

This lab will be performed from the command line inside the Db2 Warehouse container. On the IBM Integrated Analytics System  this would be performed inside the Db2 Warehouse container on the master node.  You can run any of the SQL statements from another tool  if you wish.  However, there are several bash scripts that need to be run from the Db2 Warehouse container.


### Access the IIAS Db2 Warehouse container command line.

#### Using the VM
* Use the launcher on the desktop that is labeled `Login in as bluadmin to Db2wh`. This will open you up to a shell inside the VM's Db2 Warehouse container as bluadmin.


#### If connecting to an actual IIAS System:

Following these steps to access the Db2 Warehouse command line (Linux command line).  

* Open a `Terminal` on Mac OS or Linux: `ssh teamXX@<VIP> -p 50022`  
  * VIP: `<virtual IP provided by instructor>`
  * User ID: `teamXX`
  * Password: `<password-provided-by-instructor>`
    > Replace `XX` with your assigned team number  

* Open `PuTTY` on Windows and enter the following information and click `*Open*`:  
  * Host Name (or IP address): Virtual IP provided by instructor
  * Port: `50022`
  * Connection type: `SSH`
  * Saved Session (Optional): `node0101`
  When prompted:  
  * User ID: `teamXX`
  * Password: `<password-provided-by-instructor>`
    > Replace `XX` with your assigned team number  


### Set up the dbtoolkit environment variables

To reduce the number of parameters needed for the dbtoolkit utilities you can set environment variables.

Add the following to your user ID's `.bashrc` file and source the file `source ~/.bashrc` to shorten the `dbsql` command.

   ```
   echo "export DB_HOST=<your-VIP>" >> ~/.bashrc  
   echo "export DB_DATABASE=BLUDB" >> ~/.bashrc  
   echo "export DB_USER=<`teamXX`>" >> ~/.bashrc  
   echo "export DB_PASSWORD=<your-password>" >> ~/.bashrc  
   ```

   Source the `.bashrc` file or logout and login.

   `source ~/.bashrc`

   > Note: These environment variables will be set for all future logins of `teamXX`.  With these variables set you do not need to provide the host, database, user ID or password to any of the dbtoolkit utilities such as `dbsql` or `dbload`.


### Create the tables needed for the lab.

From the IIAS Db2 Warehouse Container command line create the four sets of tables using either the dbtoolkit utility `dbsql` or the db2 command line processor - `db2`.


#### Copy each of the `DDL` files into seperate files inside the Db2 Warehouse container (Linux OS) or into a SQL tool of your choice and execute the `DDL`:

> Tools:

      * IIAS /Db2 Warehouse Console (`Run SQL`)
      * `dbsql` command line
      * `db2` command line processor
      * 3rd party tool [Aginity, DBeaver, etc]

* [`dbload` DDL](DataLoading/bdi_DBLOAD.ddl)  
* [`db2load` DDL](DataLoading/bdi_DB2LOAD.ddl)  
* [`curload` DDL](DataLoading/bdi_CURLOAD.ddl)  
* CTAS will be done in the LOAD CTAS section
* [`fedload` DDL](DataLoading/bdi_FEDLOAD.ddl)  

> Note: If you use `dbsql` in the Db2 Warehouse container on the IIAS head node you can copy the DDL files located in `/scratch/home/lab/ddl` to your home directory as follows:

```
cd
mkdir -p lab/ddl
cd lab/ddl
cp /scratch/home/lab/ddl/*.ddl ./
ls ./
```

##### Option 1: Use `dbsql` to create the tables:

   1. Process the DDL files via the `dbsql`  

      ```
      cd
      cd lab/ddl/
      dbsql -schema <teamXX> -f bdi_DBLOAD.ddl
      dbsql -schema <teamXX> -f bdi_DB2LOAD.ddl
      dbsql -schema <teamXX> -f bdi_CURLOAD.ddl  
      dbsql -schema <teamXX> -f bdi_FEDLOAD.ddl
      ```

      > Your schema is `teamXX`, where `XX` is your assigned team number.  

      > Note: dbtoolkit will use the environment variables (`DB_HOST`, `DB_DATABASE`, `DB_USER`, `DB_PASSWORD` ) if options not specified at command line.

      > *`dbsql` Long version*, options override environment variables.  
      `dbsql -host <hostname/VIP> -d bludb -u <teamXX> -pw <your-password> -schema <teamXX> -f <ddlfile>`  

   1. List the created tables  

      ```
      dbsql -schema <teamXX> -c "\d" |grep _DBLOAD  
      dbsql -schema <teamXX> -c "\d" |grep _DB2LOAD  
      dbsql -schema <teamXX> -c "\d" |grep _CURLOAD  
      dbsql -schema <teamXX> -c "\d" |grep _FEDLOAD  
      ```

      > Note: Your schema is `teamXX`, where `XX` is your assigned team number.

##### Option 2: Use `db2clp` to create the tables:

   1. Connect to the database  

      `db2 connect to bludb`

      > Note: this connect persists until `db2 connect reset` or `db2 terminate` executed.

   1. Process the DDL files via the `db2clp`  

      ```
      cd
      cd lab/ddl/
      db2 -tvf bdi_DBLOAD.ddl   
      db2 -tvf bdi_DB2LOAD.ddl  
      db2 -tvf bdi_CURLOAD.ddl  
      db2 -tvf bdi_FEDLOAD.ddl  
      ```

   1. List the created tables  

      ```
      db2 list tables for schema <teamXX> |grep _DBLOAD  
      db2 list tables for schema <teamXX> |grep _DB2LOAD  
      db2 list tables for schema <teamXX> |grep _CURLOAD  
      db2 list tables for schema <teamXX> |grep _FEBLOAD  
      ```

      > Note: Your schema is `teamX`, where `XX` is your assigned team number.

   1. Reset the Db2 Connection  

      `db2 connect reset`  

   1. Terminate the Db2 Connection  

      `db2 terminate`

### Load using `dbload`

Load the data files into the Db2 tables defined with the `_DBLOAD` extension.  Utilize the `dbload` utility available in the Db2 Warehouse container.

Data file directory: `/scratch/home/lab/data`  

You can access help by typing `dbload -h`.

#### Load the BDI `_DBLOAD` tables as follows:  

   1. Use the load script to load the tables for `_DBLOAD`:

      ```
      cd  
      mkdir -p lab/load  
      cd lab/load  
      cp /scratch/home/lab/load/bdi_DBLOAD.sh ./  
      ./bdi_DBLOAD.sh | tee bdi_DBLOAD.out  
      ```

      > Note: after the load completes you can review the output:  

      `less bdi_DBLOAD.out`

   1. Verify loaded records for each `_DBLOAD` table:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/verify_DBLOAD.sql ./  
      db2 connect to bludb  
      db2 -xf verify_DBLOAD.sql |grep errors  
      ```

   1. Check compression after data loads:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/compr_DBLOAD.sql ./  
      db2 connect to bludb  
      db2 -tf compr_DBLOAD.sql  
      ```

### Load using Db2 `LOAD`

Load the data files into the Db2 tables defined with the `_DB2LOAD` extension.  Utilize the Db2 `LOAD` utility available in the Db2 Warehouse container.

Data file directory: `/scratch/home/lab/data`  

You can access help by typing `db2 load ?`.

#### Load the BDI `_DB2LOAD` tables as follows:  


   1. Use the load script to load the tables for `_DB2LOAD`:

      ```
      cd  
      mkdir -p lab/load  
      cd lab/load  
      cp /scratch/home/lab/load/bdi_DB2LOAD.sh ./  
      ./bdi_DB2LOAD.sh | tee bdi_DB2LOAD.out  
      ```

      > Note: after the load completes you can review the output:  

      `less bdi_DB2LOAD.out`

   1. Verify loaded records for each `_DB2LOAD` table:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/verify_DB2LOAD.sql ./  
      db2 connect to bludb  
      db2 -xf verify_DB2LOAD.sql |grep errors  
      ```

   1. Check compression after data loads:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/compr_DB2LOAD.sql ./  
      db2 connect to bludb  
      db2 -tf compr_DB2LOAD.sql  
      ```

### Load using Db2 `LOAD FROM CURSOR`

For the following exercise to work you must have loaded all the tables with the `_DBLOAD` extension.  The `CURSOR` pulls the data from the `_DBLOAD` tables.

   1. Use the load script to load the tables for `_CURLOAD`:

      ```
      cd  
      mkdir -p lab/load  
      cd lab/load  
      cp /scratch/home/lab/load/bdi_CURLOAD.sh ./  
      chmod +x bdi_CURLOAD.sh  
      ./bdi_CURLOAD.sh | tee bdi_CURLOAD.out  
      ```

      > Note: after the load completes you can review the output:  

      `less bdi_CURLOAD.out`

   1. Verify loaded records for each `_CURLOAD` table:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/verify_CURLOAD.sql ./  
      db2 connect to bludb  
      db2 -xf verify_CURLOAD.sql |grep errors  
      ```

   1. Check compression after data loads:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/compr_CURLOAD.sql ./  
      db2 connect to bludb  
      db2 -tf compr_CURLOAD.sql  
      ```

### Load using `CREATE TABLE AS...`(CTAS)

For the following exercise to work you must have loaded all the tables with the `_DBLOAD` extension.  The `CTAS` pulls the data from the `_DBLOAD` tables.

   1. Use the load script to load the tables for `_CTASLOAD`:

      ```
      cd  
      mkdir -p lab/load  
      cd lab/load  
      cp /scratch/home/lab/load/bdi_CTASLOAD.sql ./    
      db2 connect to bludb  
      db2 -tvf bdi_CTASLOAD.sql | tee bdi_CTASLOAD.out  
      ```

      > Note: after the load completes you can review the output:  

      `less bdi_CTASLOAD.out`

   1. Verify loaded records for each `_CTASLOAD` table:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/verify_CTASLOAD.sql ./  
      db2 connect to bludb  
      db2 -xf verify_CTASLOAD.sql |grep errors  
      ```

   1. Check compression after data loads:

      ```
      cd  
      cd lab/load  
      cp /scratch/home/lab/load/compr_CTASLOAD.sql ./  
      db2 connect to bludb  
      db2 -tf compr_CTASLOAD.sql  
      ```
