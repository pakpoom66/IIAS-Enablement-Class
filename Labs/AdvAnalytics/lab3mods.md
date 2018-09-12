# Lab 3 modifications

**Modify from lab note entry:**

* TASK 1: Change data source in Jupyter Notebook entry:
  ~~~
  df_data:df_data= spark.read.format('jdbc').options(url='jdbc:db2://dashdb-entry-yp-dal09-07.services.dal.bluemix.net:50000/BLUDB',driver='com.ibm.db2.jcc.DB2Driver',dbtable='dash5727.GOSALES',user='dash5727',password='CllsxW8CtENU').load()
  ~~~

* TASK 2 : Remote Data Set

  **Jdbc entry:**

  `jdbc:db2://dashdb-entry-yp-dal09-07.services.dal.bluemix.net:50000/BLUDB`

  **db2warehouse credentials:**

  ***userid:*** `dash5727`
  ***password:*** `CllsxW8CtENU`
