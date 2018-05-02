# Class Prerequisites

  In preparation for the class we have created a VM image what contains Harmony Profiler, Db2 Client, Db2 Warehouse.   This is preconfigure to connection to a Netezza machine.

  There are desktop icons on this Ubuntu image that will Start/Stop and exec Db2 Warehouse, Db2 Client and Harmony Profile.  All of these launchers are bash scripts located in ~/scripts directory.

  In the Db2Wh container are all the ddl and sql scripts needed to execute the labs.

# Lab systems used during class

Based on availability, we will have access to and IBM Integrated Analytics System for you to review for the administration labs and DSX lab.

[IIAS Console](https://10.50.88.240:8443/console)


Db2Warehouse VM:  Guest VM requirements.   Virtual Box:   3 Cores and 10GB RAM
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
