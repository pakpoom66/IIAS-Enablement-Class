# Class Prerequisites

  In preparation for the class we have created a VM image what contains Harmony Profiler, Db2 Client, Db2 Warehouse.   This is preconfigure to connection to a Netezza machine.

  There are desktop icons on this Ubuntu image that will Start/Stop and exec Db2 Warehouse, Db2 Client and Harmony Profile.  All of these launchers are bash scripts located in ~/scripts directory.

  In the Db2Wh container are all the ddl and sql scripts needed to execute the labs.

# Lab systems used during class

Based on availability, we will have access to and IBM Integrated Analytics System for you to review for the administration labs and DSX lab.

[IIAS Console TBD](https://<IP_address>:8443/console)
[IIAS DSX Console TBD](https://<IP_address>:8444/)

Db2Warehouse VM:  Guest VM requirements.   Virtual Box:   2 Cores and 8GB RAM
* The VM image login ***username:*** sailfish ***password:*** ./.cshr1c.
* The Local Db2 Warehouse database:
  * ***username:*** bluadmin ***password:*** blueadmin

  * ***username:*** root ***password:*** sailfish

DSX Local VM:   Guest VM Requirements.   Virtual Box     4 Cores and 12+ GB RAM
* The VM image login ***username:*** sailfish ***password:*** ./.cshr1c.
  * ***username:*** root ***password:*** sailfish

* The DSX Local Login:
  * ***username:*** admin ***password:*** password

# Lab artifacts

Lab artifacts are included in the vm as well an here on git.

* [Migration Lab](./Labs/MigrationTooling/Readme.md)
* [Create DB Objects Lab](./Labs/CreateDBObjects/Readme.md)
* [Data Load Lab](./Labs/DataLoading/Readme.md)
