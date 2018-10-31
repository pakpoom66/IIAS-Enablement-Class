# Lab 3 modifications

**Modify from lab note entry:**

* TASK 1: Change data source in Jupyter Notebook entry:
  ~~~
  df_data:df_data= spark.read.format('jdbc').options(url='jdbc:db2://dashdb-entry-yp-dal10-02.services.dal.bluemix.net:50000/BLUDB',driver='com.ibm.db2.jcc.DB2Driver',dbtable='dash105886.GOSALES',user='dash105886',password='D_7yv_YIMgt0').load()
  ~~~

* TASK 2 : Remote Data Set

  **Jdbc entry:**

  `jdbc:db2://dashdb-entry-yp-dal10-02.services.dal.bluemix.net:50000/BLUDB`

  **db2warehouse credentials:**

  ***userid:*** `dash105886`
  ***password:*** `D_7yv_YIMgt0`

  Here's the connection settings , just incase
  ~~~
{
  "hostname": "dashdb-entry-yp-dal10-02.services.dal.bluemix.net",
  "password": "D_7yv_YIMgt0",
  "https_url": "https://dashdb-entry-yp-dal10-02.services.dal.bluemix.net",
  "port": 50000,
  "ssldsn": "DATABASE=BLUDB;HOSTNAME=dashdb-entry-yp-dal10-02.services.dal.bluemix.net;PORT=50001;PROTOCOL=TCPIP;UID=dash105886;PWD=D_7yv_YIMgt0;Security=SSL;",
  "host": "dashdb-entry-yp-dal10-02.services.dal.bluemix.net",
  "jdbcurl": "jdbc:db2://dashdb-entry-yp-dal10-02.services.dal.bluemix.net:50000/BLUDB",
  "uri": "db2://dash105886:D_7yv_YIMgt0@dashdb-entry-yp-dal10-02.services.dal.bluemix.net:50000/BLUDB",
  "db": "BLUDB",
  "dsn": "DATABASE=BLUDB;HOSTNAME=dashdb-entry-yp-dal10-02.services.dal.bluemix.net;PORT=50000;PROTOCOL=TCPIP;UID=dash105886;PWD=D_7yv_YIMgt0;",
  "username": "dash105886",
  "ssljdbcurl": "jdbc:db2://dashdb-entry-yp-dal10-02.services.dal.bluemix.net:50001/BLUDB:sslConnection=true;"
}
~~~
