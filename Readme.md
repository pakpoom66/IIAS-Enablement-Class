# Workshop Agenda
## Day 1   
This day is an overview of the system: What it is, how to administrate and monitor.
* Kick off
* Overview/Architecture
* Lab: [Console exploration](Labs/Admin/Admin.md)     ***Assumes live system access***
* Console and command line/Console Demo
  * Lab: [Console exploration](Labs/Admin/Admin.md)     ***Assumes live system access***
* Monitoring
  - Overall System
  - Individual Query (explain plans)
* Lab: Your DB2 Wh lab for a drill down into Administer part of IIAS admin (VM)
* Lab: Command line processor (VM)

## Day 2
This day is migration of tools, methods and understand of activities during a proof of concept.
* Understanding the IIAS data engine - BLU
  - Data structures (what happens when data is updated/deleted)
  - Groom/Compression/Stats/Reclaim
  - Security.
  - Interesting software things
* The tools to move Data
  - Etl, Loading Methods and Utils, load rate and Best Practices
* Lab: Data Loading (VM)
* Performance tuning
* Lab: [Data Loading](Labs/DataLoading/Readme.md)   
* Migration Gotchas/best practices
* Lab: [Migration using tooling](Labs/MigrationTooling/Readme.md)
  - Harmony Profiler migrating a Netezza/PDA DDL
  - Set up Tables and Run DB2 Migrate

## Day 3
This day is about performance tuning  and tools as well as an introduction to Data Science.
* Spark, Livey/Spark/ Watson Studio
* Lab: [DSX : User experience](Labs/AdvAnalytics/AnalyticsAdmin.md)  ***Assumes live system access***
* Lab: [Jupyter Notebook and Machine Learning](https://cloudcontent.mybluemix.net/cloud/garage/tutorials/high-powered-analytics-appliance?task=3)



# Class Prerequisites

  In preparation for the class we have created a VM image what contains Harmony Profiler, Db2 Client, Db2 Warehouse.   This is preconfigure to connection to a Netezza machine.

  There are desktop icons on this Ubuntu image that will Start/Stop and exec Db2 Warehouse, Db2 Client and Harmony Profile.  All of these launchers are bash scripts located in ~/scripts directory.

  In the Db2Wh container are all the ddl and sql scripts needed to execute the labs.

# Lab systems used during class

Based on availability, we will have access to and IBM Integrated Analytics System for you to review for the administration labs and DSX lab.   Complete the needful in the [Partner access document](./PartnerAccess.md)

[IIAS Console](https://10.50.88.240:8443/console) 10.50.88.240


Db2 Warehouse VM:  Guest VM requirements.   Virtual Box:   3 Cores and 10GB RAM
* The VM image login ***username:*** sailfish ***password:*** ./.cshr1c.
* The Local Db2 Warehouse database:
  * ***username:*** bluadmin ***password:*** bluadmin

  * ***username:*** root ***password:*** sailfish

DSX Workshop available

# Lab Instructions

Lab instructions are included in the vm as well an here on git.

* [Migration Lab](Labs/MigrationTooling/Readme.md)
* [Create DB Objects Lab](Labs/CreateDBObjects/Readme.md)
* [Data Load Lab](Labs/DataLoading/Readme.md)
* [Administration Lab](Labs/Admin/Admin.md)
* [DSX User Experience Lab](Labs/AdvAnalytics/AnalyticsAdmin.md)
