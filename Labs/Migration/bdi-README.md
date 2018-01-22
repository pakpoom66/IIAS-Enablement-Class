BDInsights
==========

A collaborative database workload kit for the future! Could be setup on Linux, AIX and Windows machines and run against IBM DB2, Netezza, Amazon RedShift, Microsoft SQL Server, Oracle, SAP HANA, and extended for more. BDInsights consists of 100 queries in total: 70 simple, 25 intermediate and 5 complex. Data is generated using TPC-DS v1.0, and could be arbitrarily large.

This kit defines **server** to be the database that is filled with generated data; It refers to **client** as the Jmeter plans and queries that are ran against the server. This kit will setup both the server and client.


See the [change log](CHANGES.md) for updates to the project.

[![Build Status](http://m402.torolab.ibm.com:8080/buildStatus/icon?job=Bdinsights)](http://m402.torolab.ibm.com:8080/job/Bdinsights)

[Unix Installation](#unix-installation)
[Windows Installation](#windows-installation)

### Unix Installation

We provide a simplified build script for a full installation on a Unix-based machine. This script will generate a specified database of a specified size, and do a canonical set of queries and output its results using Jmeter. The workload needs a few packages to be installed, which is verified in the build script.

 - Java 1.7+
 - Jmeter 2.13+
 - Perl 5.16.2+
 - GCC 4.8+
 - Database to benchmark


See [Installing Prereqs](#installing-prereqs).

Now you can clone this repository:
```bash
git clone git@github.ibm.com:SQL-Performance/biday3.git
cd biday3
```

BDInsights is configured through environment variables, and it is handy to keep these configurations inside a file which we can source each time. A basic configuration is available called `bdienv.sh`. You need to edit this file to suit your own environment. See [Configuration](#configuration).

Now you are ready to run the install sequence. Note that it takes a long time to run, and cannot be interrupted. A database of 1TB might take more than 6 hours. It might be useful to run this in the background.

*Note: This script is meant to be run on the server where your database is hosted.  Do not run this script on the client.*
```bash
install_script/bdiSetUp.sh
```

### Advanced

This section is for advanced configuration of the kit, and lists some tools available as part of the kit.

#### Testing (Linux and AIX over DB2 only)

The kit comes with a suite of test cases to ensure integrity of databases generated on DB2 over Linux or AIX. The test suite will run through creating 4 databases of size 1 GB. While sourcing the `bdienv.sh` file will not be needed (this test suite will create its own), the suite does need access to the database:

```bash
export DBUSERNAME=myusername
export DBPASSWORD=mypassword
./test.sh
```

#### Cleanup (Linux and AIX only)

```bash
clean.sh
```
The above script will remove any temporary data generator, params and workload files generated.

#### Manual Run

For comparing performance between database systems, we specify a serial run and a multiuser run:

```bash
cd workloads

# serial
./run.pl -db=bdi -schema=bdinsights -base=serialRun -serial_iterations=3 warmup serial

# multiuser
./run.pl -db=bdi -schema=bdinsights -base=multiUserRun -heavy_users=8 -heavy_iterations=1 warmup multiuser
```

#### Jmeter with Grafana

Example setup and software stack can be referenced from the [JMeter user manual](http://jmeter.apache.org/usermanual/realtime-results.html). The following files are provided:

- `demo/BD_Insights_grafana_example.json`
	- This dashboard is suitable for single runs
- `demo/BD_Insights_DUAL_grafana_example.json`
	- This dashboard is useful for showing live results of two simultaneous runs
		- note: requires 2 instances of Jmeter

#### Additional

Additional documentation are in the `docs` folder:

- `docs/DIRECTORIES.md` outlines what each folder inside this kit is used for.
- `docs/DEVEL.md` explains how to add new client and server databases
- `docs/setup` walks through how to set up the server and client manually
- `docs/run` explains in detail how to configure a custom run as well as a standard canonical run for reporting


### Windows Installation

While we try to make all our code platform independent, insufficient testing has been done on Windows to guarantee its usability. See `bdienv.bat` and running `kitsetup.pl` manually.

### Installing Prereqs

**Java**
Depending on the flavor of Unix. See [OpenJDK]().

**GCC**
See [GCC](https://gcc.gnu.org/wiki/InstallingGCC)

**Jmeter**
```bash
cd
curl -L -O https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-2.13.zip
unzip apache-jmeter-2.13.zip
apache-jmeter-2.13/bin/jmeter -v
```

**Perl**
```bash
curl -L http://xrl.us/installperlnix | bash
perl -v
```

### Configuration

`bdienv.sh` is the file that contains all the environment variables that characterize your installation, including settings on the database, OS, client. Before running any of the Perl scripts inside the repository, you will need to adjust the file.

The file is a sequence of variable names to be exported, and each line is either a comment or looks like
```bash
export VARIABLE=some value
```
Simply edit the value after the `=`. Some key variables are outlined here:

 - BDI_PLATFORM: operating system that you are running on
 - BDI_DBMS: database system that you are benchmarking
	 - note: you need to go through this setup twice if you are testing two databases
 - BDI_SCALING: size of database to create in gigabytes
	 - note that the data files will take this much space, and the database will take even more space, though not quite as much because of compression. Make sure that twice this much space is available on the system
 - BDI_DBSERVER: location of the database
	 - localhost for local database
	 - ip address for network database
 - BDI_PORT: port of the database
 - BDI_USERS: username to connect to database
 - BDI_PASSWORDS: password to connect to database
	 - if doing simple installation, simply put the credentials of your operating system
	 - make sure to keep the "default=" prefix
 - BDI_JDBCDRIVERJAR: directory which the database adapter is installed in.
	 - this usually comes with a database

See comments inside the file for details. When it looks good, source it:
```bash
source bdienv.sh
```
