# Catalog the Db2 Warehouse and Netezza databases from your Db2 Warehouse Client Container

## Team Assignments
See the table for your system assigments.  Please use the system assigned to your team.

* [System/Database Assignments](/LabSystems.md)

## Authenticate to the POC Lab prior to testing the database connection
* [Authenticate to SVL POC Network](/Docs/06_Login_to_IIAS_SVL.md)

## Attach to your Db2 Warehouse Client container  

* Mac open `/Applications/Utilities/Terminal.app` or `/Applications/iTerm.app`  
  `docker exec -it client cli`  
  
* Windows start the docker cli  
  `docker exec -it client cli`

## Set up the environment variables for Db2 support tools  

* Create a new file called `.dbprofile`  
  `vi ~/.dbprofile`  

* Add following into the `.dbprofile` file.  
  ```
  #Db2 Warehouse environment variables
  export DB_DATABASE=bludb
  export DB_HOST=9.30.106.115
  export DB_USER=<team-assigned-ID>
  export DB_PASSWORD=<team-assigned-password>
  #Netezza environment variables
  export NZ_DATABASE=<your-assigned-database>
  export NZ_HOST=9.30.106.112
  export NZ_USER=<your-svlab-domain-id>
  export NZ_PASSWORD=<your-nzlab-domain-password>
  ```
## Persist the dbprofile 

* Add the following code to the end of your .bashrc file
  > Note: this will persist over subsequent attachments to the Db2 Warehouse Client container

  `vi ~/.bashrc`

  ```
  # Source the Db2 Warehouse and Netezza environment variables
  if [ -f /mnt/clientdir/clienthome/db2inst1/.dbprofile ]; then
      . /mnt/clientdir/clienthome/db2inst1/.dbprofile
  fi
  ```

* Exit the container and re-enter

  `exit`

  `docker exec -it client cli`

## Test database connection to Db2 Warehouse and Netezza 

### Attach to your Db2 Warehouse Client container
   
#### Mac open `/Applications/Utilities/Terminal.app` or `/Applications/iTerm.app`  
     `docker exec -it client cli`  
  
#### Windows start the docker cli  
     `docker exec -it client cli`
   
   * Db2 Warehouse
   
     `dbsql`
   
     ```
     BANKMDB.DAHANCOC(DAHANCOC)=> dbsql \q
     [dashDB Local - Client CLI ~]\>dbsql
     Welcome to dbsql, the IBM dashDB SQL interactive terminal.
       
     Type:  \? for help with internal slash commands
            \g or terminate with semicolon to execute query
            \q to quit
          
     BLUDB.BLUADMIN(BLUADMIN)=>
     ```
     
     Quit  
     `\q`

   * Netezza
   
     `nzsql`
   
     ```
     [dashDB Local - Client CLI ~]\>nzsql
     Welcome to nzsql, the IBM Netezza SQL interactive terminal.
     
     Type:  \h for help with SQL commands
            \? for help on internal slash commands
            \g or terminate with semicolon to execute query
            \q to quit
      
     SYSTEM.ADMIN(DAHANCOC)=>
     ```
     
     Quit  
     `\q`

