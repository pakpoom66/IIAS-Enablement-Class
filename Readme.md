# Workshop Agenda
## Day 1   
This day is an overview of the system: What it is, how to administrate and monitor.
* Kick off
* [Overview/Architecture](https://ibm.box.com/s/o1rg57uzziyv28dzgn9tqb3az8vqath1)
* [Admin Overview](https://ibm.box.com/s/polu8i4yktsa6xcwun7ewh0jbmrvd68k)
* Lab: [Console exploration](Labs/Admin/Admin.md)     ***Assumes live system access***
* [Data Warehouse Admin Overview](https://ibm.box.com/s/vvblhgx2dbhonocaxqnpop9b0pq44b5n)
* Lab: [Administration as part of IIAS](Labs/db2Console/Db2W_IIAS_Web_Console.md) (VM)
* Lab: [Command line processor](Labs/db2cmd/Db2W_Cmd_Line.md) (VM)
* [Monitoring](https://ibm.box.com/s/0s45e3mdrgh7f9cvbmlm388eai6zjcbz)
  - Overall System
  - Individual Query (explain plans)

## Day 2
This day is about an introduction to Data Science.
* [Spark, Livey/Spark/ Data Science Experience](https://ibm.box.com/s/s3zdjdwy0p7fhka5g8psxu1vs4rt1slc)

* Access to IIAS - Data Science 
   ~~~
   https://9.30.106.50:8444
   username : admin    password: Sail2018fish!
   ~~~
STOP:
Assign Username

* Lab 1: [Creating and managing users](Labs/AdvAnalytics/CreateUser.md) ***Assumes live system access***
* Lab 2: [DSX : User experience](Labs/AdvAnalytics/AnalyticsAdmin.md)  ***Assumes live system access***
* Lab 3: [DSX Advance Labs - Jupyter Notebook and Machine Learning](https://cloudcontent.mybluemix.net/cloud/garage/tutorials/high-powered-analytics-appliance?task=3) ***Assumes live system access***

    ***Modifications to Lab 3*** [Click here for Modifications](Labs/AdvAnalytics/lab3mods.md)



## Day 3
This day is migration of tools, methods and understand of activities during a proof of concept.
* [Understanding the IIAS data engine - BLU](https://ibm.box.com/s/q1r8rzuzxsbhtqv5ztqlniztqve1wkgp)
  - Data structures (what happens when data is updated/deleted)
  - Groom/Compression/Stats/Reclaim
* [Understanding Data Layout](https://ibm.box.com/s/na7z74rsoqfap6bi4hy85skwc3bz0dbk)
* [Tools to move Data](https://ibm.box.com/s/7fnk0o6dlbhytj63tantuc3eeork6qqh)
  - Etl, Loading Methods and Utils, load rate and Best Practices
* Lab: [Data Loading](Labs/DataLoading/Readme.md)  (VM)
* [Performance tuning](https://ibm.box.com/s/lflozxmdq6bsfla92sj2ev9h00tx7mjx)
* [Migration Gotchas/best practices](https://ibm.box.com/s/nkbzottl6slozepsiy60wcemuxybtdvr)
* Lab: [Migration using tooling](Labs/MigrationTooling/Readme.md) (VM)
  - Harmony Profiler migrating a Netezza/PDA DDL
  - Set up Tables and Run db_migrate






# Class Prerequisites

  In preparation for the class we have created a VM image what contains Harmony Profiler, Db2 Client, Db2 Warehouse.   This is preconfigure to connection to a Netezza machine.

  There are desktop icons on this Ubuntu image that will Start/Stop and exec Db2 Warehouse, Db2 Client and Harmony Profile.  All of these launchers are bash scripts located in ~/scripts directory.

  In the Db2Wh container are all the ddl and sql scripts needed to execute the labs.  

# Lab systems and presentations used during class

Here is a [link to a Box folder](https://ibm.box.com/v/IIASWorkshop) with presentations for you to follow along.  For further education, please look at the [Channel Technical Enablememt Guide](https://www.onlinedigitallearning.com/course/view.php?id=3716)

Based on availability, we will have access to and IBM Integrated Analytics System for you to review for the administration labs and DSX lab.   Complete the needful in the [Partner access document](./PartnerAccess.md)

[IIAS Console](https://10.50.88.240:8443/console) 10.50.88.240


Db2 Warehouse VM:  Guest VM requirements.   Virtual Box:   3 Cores and 10GB RAM
* The VM image login ***username:*** sailfish ***password:*** passw0rd.
* The Local Db2 Warehouse database:
  * ***username:*** bluadmin ***password:*** bluadmin

  * ***username:*** root ***password:*** sailfish

DSX Workshop available

# Lab Instructions

Lab instructions are included in the vm as well an here on git.

* [Migration Lab](Labs/MigrationTooling/Readme.md) (VM)
* [Administration as part of IIAS](Labs/db2Console/Db2W_IIAS_Web_Console.md) (VM)
* [Command line processor](Labs/db2cmd/Db2W_Cmd_Line.md) (VM)
* [Create DB Objects Lab](Labs/CreateDBObjects/Readme.md) (VM)
* [Data Load Lab](Labs/DataLoading/Readme.md) (VM)
* [Administration Lab](Labs/Admin/Admin.md)  (IIAS system)
* [DSX User Experience Lab](Labs/AdvAnalytics/AnalyticsAdmin.md) (IIAS system)
