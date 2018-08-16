# Workshop Agenda
## Day 1   
This day is an overview of the system: What it is, how to administrate and monitor.
* Kick off
* Overview/Architecture
* Admin Overview
* Lab: [Console exploration](Labs/Admin/Admin.md)     ***Assumes live system access***
* Monitoring
  - Overall System
  - Individual Query (explain plans)
* Data Warehouse Admin Overview
* Lab: [Administration as part of IIAS](Labs/db2Console/Db2W_IIAS_Web_Console.md) (VM)
* Lab: [Command line processor](Labs/db2cmd/Db2W_Cmd_Line.md) (VM)

## Day 2
This day is migration of tools, methods and understand of activities during a proof of concept.
* Understanding the IIAS data engine - BLU
  - Data structures (what happens when data is updated/deleted)
  - Groom/Compression/Stats/Reclaim
* Understanding Data Layout
* Tools to move Data
  - Etl, Loading Methods and Utils, load rate and Best Practices
* Lab: [Data Loading](Labs/DataLoading/Readme.md)  (VM)
* Performance tuning
* Migration Gotchas/best practices
* Lab: [Migration using tooling](Labs/MigrationTooling/Readme.md) (VM)
  - Harmony Profiler migrating a Netezza/PDA DDL
  - Set up Tables and Run db_migrate

## Day 3

* Lab: [Console exploration](Labs/Admin/Admin.md) 
  ~~~
  Access to IIAS - Sailfish Appliance
  https://cap-au-sg-prd-01.integration.ibmcloud.com:15150/console/dswebcustomauth/pages/login.jsp

  Lab: Console exploration     Assumes live system access - As admin
  START on:  Review the Dashboard - Section
  Username : bluadmin   password: bluadmin

  Lab: Console exploration     Assumes live system access - As user
  START on:  Review the Dashboard - Section 
  (Notice the differences between an admin and user

  Username: potuser01
  Password: Potuser01_123

  ~~~

This day is about performance tuning  and tools as well as an introduction to Data Science.
* Spark, Livey/Spark/ Watson Studio

* DSX Lab:
Access to IIAS - Data Science 
https://cap-sg-prd-4.integration.ibmcloud.com:18940/auth/login/login.html
username : admin    password: password

STOP:
Assign Username


* LAB: Create DSX Users
  ~~~
  Drop Down from IBM Data Science Experience Local to IBM Data Platform
  (Hamburger Icon) -> User Management -> +add users

  Name: (Your name) Example : Paulinda
  Username (Note: Your assigned username) Example: team00
  Email: (Your email) : It's not used but it's a required field in a valid email format
  Access Level: Admin

  Username : team01 Password: sailfish01
  Username : team02 Password: sailfish02
  ........
  Username : team12 Password: sailfish12

  Note: DSX will provide a temporary password. This is the password to send to the user
  ~~~
* LAB: Assign password
  ~~~~
  (Hamburger Icon) -> User Management
  Look for Username (note STATUS column)
  on Actions column - > Click Pencil - Assign password as above:


  LAB: Check Login for new user
  - Signout as Admin (Top right corner)
  - Login as new user
  - Drop Down from IBM Data Science Experience Local to IBM Data Platform
  - (Hamburger Icon) -> User Management
  - Look for Username (note STATUS column)
  ~~~~
* Lab: [DSX : User experience](Labs/AdvAnalytics/AnalyticsAdmin.md)  ***Assumes live system access***
* Lab: [Jupyter Notebook and Machine Learning](https://cloudcontent.mybluemix.net/cloud/garage/tutorials/high-powered-analytics-appliance?task=3)

DSX User Experience
Link: https://tjmcmanus.github.io/IIAS-Enablement-Class/Labs/AdvAnalytics/AnalyticsAdmin.html

STOP: DO NOT check Cluster Logs

DSX Advance Labs - Jupyter Notebook and Machine Learning
https://cloudcontent.mybluemix.net/cloud/garage/tutorials/high-powered-analytics-appliance?task=3



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

* [Migration Lab](Labs/MigrationTooling/Readme.md) (VM)
* [Administration as part of IIAS](Labs/db2Console/Db2W_IIAS_Web_Console.md) (VM)
* [Command line processor](Labs/db2cmd/Db2W_Cmd_Line.md) (VM)
* [Create DB Objects Lab](Labs/CreateDBObjects/Readme.md) (VM)
* [Data Load Lab](Labs/DataLoading/Readme.md) (VM)
* [Administration Lab](Labs/Admin/Admin.md)  (IIAS system)
* [DSX User Experience Lab](Labs/AdvAnalytics/AnalyticsAdmin.md) (IIAS system)
