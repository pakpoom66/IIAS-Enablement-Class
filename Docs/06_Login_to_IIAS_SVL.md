# Accessing IBM Integrated Analytics System (SVL)

> NOTE: LDAP has not been enabled on the Sailfish System yet.  You will not be able to connect to Sailfish using your LDAP user ID.  You will be assinged a team userid and password the week of the class.  For testing purposes you can use:

* Test user ID until week of class  
  
   USERID: sfuser  
   PASSWORD: Sailfishtest@2018  

> Replace any occurrence of `<your-svl-domain-id>` with your assigned team ID

> Note:  
> * Authenticate to the [BSO Firewall](/Docs/06_Authenticate_SVL.md) prior accessing the SVL systems.
>   * This is your IBM Intranet User ID and password.  
> * Use your SVL Domain Userid/Password when connecting to the SVL Systems  
>   * This is **not** your IBM intranet password.  
> * Unlock your account or reset the SVL LAB password via [USAM](https://labportal.eslabs.ibm.com/#!/tools/amp)  
   
## Database Administrator and Users - Web Console

The web console is a web-based client for managing and monitoring the Integrated Analytics System. You can use the web console more directly and intuitively to administer multiple database objects such as tables, views, schemas, privileges, workloads, and add users. You can also monitor the system and workloads, get alerts, and receive recommendations on how to solve system and database problems.

The database administrator uses the web console to monitor performance.

1. Users and administrators connect to the web console via a web browser at:  
   `https://9.30.106.50:8443/console`

1. Use your SVL Domain User ID and Password to login.

Administrators can log in as user bluadmin or other administrator users, while database users can log in as the database user.

## Appliance Administrator and Users - Operating System Command Line
   Database users must be added to the appliance by the database administrator.
   Users and administrators connect to the database BLUDB through a terminal session at:

> NOTE: you will not have access to the host OS during the class.  This is for illustration purposes only.
1. Log into the IIAS with your LAB Domain Credentials.  
  
   * Mac: Open Terminal (/Applications/Utilities.Terminal.app) or iTerm (/Applications/iTerm.app)  
     
     Login to IIAS head node OS:  
     `$ ssh <your-svl-domain-id>@9.30.106.50`  
     > Enter your NZLAB Domain ID and password
     
     Login to Db2 Warehouse container directly:  
     `$ ssh <your-svl-domain-id>@9.30.106.50 -p 50022`  
     > Enter your SVL Domain ID and password
     
   * Windows: Open PuTTY and enter the following information in the "PuTTY Configuration" window:  
      
     **Sailfish Headnode Host OS**  
     (1) HostName (or IP address)	: 9.30.106.50  
     (2) Port				: 22  
     (3) Connection type		: ssh  
     (4) Saved Sessions			: IIAS-Headnode-Host-SVL (node0101)  
     (5) Click `Save`  
     (6) Click `Open`  
     > Enter your NZLAB Domain ID and password  

## Database Administrator and Users - Container Operating System Command Line (inside the container)  
   Database users must be added to the appliance by the database administrator.
   Users and administrators connect to the database BLUDB through a terminal session at:

1. Log into the IIAS Db2 Warehouse server container with your LAB Domain Credentials.  
  
   * Mac: Open Terminal (/Applications/Utilities.Terminal.app) or iTerm (/Applications/iTerm.app)  
           
     Login to Db2 Warehouse container directly:  
     `$ ssh <your-svl-domain-id>@9.30.106.50 -p 50022`  
     > Enter your SVL Domain ID and password
     
   * Windows: Open PuTTY and enter the following information in the "PuTTY Configuration" window:  
      
     **Db2 Warehouse Container**  
     (1) HostName (or IP address)	: 9.30.106.50  
     (2) Port				: 50022  
     (3) Connection type		: ssh  
     (4) Saved Sessions			: IIAS-Headnode-Db2-SVL (node0101)  
     (5) Click `Save`  
     (6) Click `Open`  
     > Enter your SVL Domain ID and password

     **Click `Open`  
     
1. Set up your environment variables inside the Db2 Warehouse server container  

   Add the following to your .bashrc file.  
   
   ```
   #Db2 Warehouse environment variables
   export DB_DATABASE=bludb
   export DB_HOST=9.30.106.50
   export DB_USER=<your-svl-domain-id>
   export DB_PASSWORD=<your-svl-domain-password>
   #Netezza environment variables
   export NZ_DATABASE=<your-assigned-database>
   export NZ_HOST=9.30.106.112
   export NZ_USER=<your-svl-domain-id>
   export NZ_PASSWORD=<your-svl-domain-password>
   ```
   
   `source .bashrc`  
   
   or  
   
   log out/in  
   
   
