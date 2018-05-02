# Workshop Agenda
## Day 1   
*	Kick off
*	Intro and Data Warehousing positioning
*	Overview/Architecture
   - Hardware
   -	Platform
   -	Software
   -	System Sizing/Expansion (TBD)
*	Console and command line/Console Demo
  	* [Lab Console exploration](Labs/Admin/Admin.md) (Need to build assumes live system access)
* Monitoring
    - Overall System
    - Individual Query (explain plans)

## Day 2
*	Data Movement
	- Etl, Loading Methods and Utils, load rate and Best Practices
* Data Update/Delete
  - Data structures (what happens when data is updated/deleted)
  - Groom/Compression/Stats/Reclaim
  - Security.
  - Interesting software things
* Lab: [Data Loading](Labs/DataLoading/Readme.md)   
*	Migration tooling
* Lab: [Migration using tooling](Labs/MigrationTooling/Readme.md)
  - Harmony Profiler migrating a Netezza/PDA DDL
  - Set up Tables and Run DB2 Migrate

## Day 3
*	Best Practices on Performance Tuning and tools
*	DSX & Spark
  -	Lab:  [DSX  - Overview of the interface](Labs/AdvAnalytics/AnalyticsAdmin.md)  (DSX Local)
-	Roadmap & Q&A  



# Class Prerequisites

  In preparation for the class we have created a VM image what contains Harmony Profiler, Db2 Client, Db2 Warehouse.   This is preconfigure to connection to a Netezza machine.

  There are desktop icons on this Ubuntu image that will Start/Stop and exec Db2 Warehouse, Db2 Client and Harmony Profile.  All of these launchers are bash scripts located in ~/scripts directory.

  In the Db2Wh container are all the ddl and sql scripts needed to execute the labs.

# Lab systems used during class

Based on availability, we will have access to and IBM Integrated Analytics System for you to review for the administration labs and DSX lab.   To gain access to the IIAS system, you will need to follow the steps in the [Partner Access Document](ExternalPartnerAccess.pdf).  If enrolled in a workshop, then follow teh 4 steps starting at the bottom of page 2.

[IIAS Console](https://10.50.88.240:8443/console)


Db2 Warehouse VM:  Guest VM requirements.   Virtual Box:   3 Cores and 10GB RAM
* The VM image login ***username:*** sailfish ***password:*** ./.cshr1c.
* The Local Db2 Warehouse database:
  * ***username:*** bluadmin ***password:*** bluadmin

  * ***username:*** root ***password:*** sailfish

DSX Local sytem hosted on Skytap
https://amazingkalam.bluedemos.skytapdns.com/dsx-admin/#/

# Lab artifacts

Lab artifacts are included in the vm as well an here on git.

* [Migration Lab](Labs/MigrationTooling/Readme.md)
* [Create DB Objects Lab](Labs/CreateDBObjects/Readme.md)
* [Data Load Lab](Labs/DataLoading/Readme.md)
* [Administration Lab](Labs/Admin/Admin.md)
* [DSX User Experience Lab](Labs/AdvAnalytics/AnalyticsAdmin.md)
