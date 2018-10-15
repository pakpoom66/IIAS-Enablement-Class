# Using DSX Machine Learning Builder

IBM® Integrated Analytics System (IIAS) consists of a high-performance hardware platform and optimized database query engine software that work together to support various data analysis and business reporting features. There are multiple ways to analyze data on IBM® Integrated Analytics System - IBM® Data Science Experience (DSX), Spark, R , Analytic Stored Procedures, and Spatial Extender. In this tutorial, the focus is on DSX Integration on IIAS.  IBM® Integrated Analytics System (IIAS) includes and supports a one-node installation of DSX Local.

DSX Local is an out-of-the box on premises enterprise solution for data scientists and data engineers. It offers a suite of data science tools that are integrated with proprietary IBM technologies. It also seamlessly integrates with RStudio, Spark, Jupyter and Zeppelin notebook technologies. The intuitive user interface provides a Projects space for teams and individuals to efficiently collaborate, which will enable companies to more quickly make informed decisions.

### Lab Narrative

IER is a fictional sporting goods store specializing in selling outdoor sports equipment. Their product offerings include equipment for Golf, Camping, Mountaineering and Personal Accessories (apparel, foot wear, etc.) for these sports.
Changes in market trends, such as  disposable income and customer demographic, are not only major growth drivers for sales, but they also impact revenue growth.  So the store needs to identify its Target Market based on what its customers will likely purchase in the future using its own historical sales information.

The retail store does not have a big Data Science team, but they have staff who are skilled in Analytics.  The current process takes a long time and they are not able to meet the demands on time. The Executive Board is not looking for a complicated IT infrastructure to support their Analytics needs.  They want to be able to create sophisticated Analytics processes to accelerate decision making using a robust, but simple, IT infrastructure.

Your job is to support management’s vision to accelerate decision making.

### Lab Overview

Using DSX's Machine Language Builder, we will provide steps and code to load data, explore data, create a predictive model, deploy the model, and start scoring with new data. In addition, we will introduce  basic data cleansing and exploration,  and pipeline creation using Apache Spark machine learning (ML) packages. This lab uses data from Db2 Warehouse on Cloud. But you can use this lab to use data from IBM® Integrated Analytics System (IIAS) instead. You can analyze data from multiple data sources for DSX on IIAS – databases from IIAS , DB2 Warehouse on Cloud, DB2 on Z, HDP, Netezza, Informix and Oracle.

Some familiarity with Python is helpful but not necessary. The Jupyter notebook uses Python 2.0 and the runtime compute engine is IBM Apache® Spark 2.0.

### A Note about this Lab.

DSX on Integrated Analytics System includes a one node implementation. DSX Local can be a 3 or more node cluster.  There are slight differences between the two implementations, but the functionality remains the same.

  1) **Logging in:** DSX on Integrated Analytics System is launched from IIAS console under the **Develop Analytics** section. It requires separate credentials (user ID and password) from Integrated Analytics System login. The default DSX userID and password is **admin** **password**.

  2) **Additional Runtime Compute Engine:** DSX on Integrated Analytics System can connect to the Integrated Analytics System Spark service using Apache Livy.

  3) **Model Deployment Type:** Model Deployment will be explained later in this lab. For DSX on Integrated Analytics System, the only supported deployment type is Online (vs. Batch)

### The following steps will walk through the process of using DSX Machine Learning builder wizard.

A)  Creating Projects. When you create a project for analyzing data, you associate it with a compute engine and storage. Then, you add collaborators, data assets, and analytic assets to your project. You can also add bookmarks to important resources and associate other services with your project.

**Click** on the hamburger icon on the top left and **select** **Projects**, then **select** the project name you created in Part 1 - your team name: example team00

![](images/tutorials/high-powered-analytics-appliance/image21.jpeg)

  - First create a data source that will be recognized by the machine
    learning builder. **Click** on **Data sources** from the above screen

  ![](images/tutorials/high-powered-analytics-appliance/image22.jpeg)

  **Click** on **add data source** on the right side of the screen.

  - In the  **Add data source** screen, values are :     
     - **Data Source Name** is ***GOSales***    
     - **Description** is Remote Data from DB2 Warehouse on Cloud
     - **Data Source Type** is ***dashDB***
     - **JDBC URL** copy-paste `jdbc:db2://dashdb-entry-yp-dal09-09.services.dal.bluemix.net:50000/BLUDB`
     - **Username** is ***dash7268***
     - **Password**  ***mV@\$e7q4RPzL***
     - **Shared** is ***UNCHECKED***.

  - When you’re done – the screen should look like below. **DO NOT** click ‘Create’ yet.
  Scroll down to define the remote data set **(Next section)**

  ![](images/tutorials/high-powered-analytics-appliance/image24.jpeg)

  -  Now scroll down, click on **Add Remote Data Set**.
     - **Remote Data Set Name** is ***GOSales***
     - **Schema** leave blank
     - **Table** is ***dash7268.GOSALES***

  ![](images/tutorials/high-powered-analytics-appliance/image25.jpeg)

  **Click** Create. The ‘GOSales’ data source should now appear.

  ![](images/tutorials/high-powered-analytics-appliance/image26.png)

  - In the prior steps, you have essentially loaded your data into a data structure or container. In an Apache Spark service, that is how a data gets processed. In DSX Local, some of the supported data frames are pandas.DataFrame, numpy.array,   Spark RDD and Spark DataFrame.

 **Click** on **Add model** under ** + ** pull down on the top right NOT the drop down arrow

 ![](images/tutorials/high-powered-analytics-appliance/image27.jpeg)



B)  **Creating Models** : Predictive modeling is a process that uses data mining and probability to forecast outcomes. Each model is made up of predictors, which are the variables which will impact future results. When data has been collected for these predictors, a statistical model is formulated. In this lab, the predictors are : gender, age, marital status and profession.

   - On the **Add Model** screen, use these values , **Name** your team name ***TeamXX*** . **Select**  ***Manual***. This will allow us to specify the ML algorithm to use. **Note** Data Scientists and Statisticians will know which Machine Language algorithm applies. **Click** on **Create**.

 ![](images/tutorials/high-powered-analytics-appliance/image28.jpeg)

   - **Selecting the data** : Now we need to select the data which will be used to create the model.

  ![](images/tutorials/high-powered-analytics-appliance/image29.jpeg)

  **Click** on the circle next to **GOSales** data source which we just created. **Click** on **Next**.

  - Wait until the data is loaded. A small sample of the data will be displayed.
  Keep **Auto Data Preparation** . **Click** **Next** to select the data. **Note:** The data displayed on your
  screen will be different from the image below

  ![](images/tutorials/high-powered-analytics-appliance/image31.jpeg)



C)  **Training** predictive models. A predictive model must be trained to determine which data is useful and which data is not needed. You **train** a model by using historical data. In this lab - the sales history.

  - From **Select a technique** screen, **Column value to predict (Label Col)**, **Click** the drop down list select **PRODUCT_LINE**.

   DSX will suggest the best technique to train based on the attributes of the data we're predicting, i.e. PRODUCT_LINE in our lab. Notice that a **Multiclass Classification** is selected for the **Suggested technique**. We assign an object (e.g. Golf Equipment) to its class (e.g.product_line). In our data, there are multiple product lines, Golf equipment, Camping Equipment, Product Accessories etc. A multiclass classification makes an assumption that there are many types of **Product Lines** but one and only one can be assigned at a time (e.g. per record / per row, in the database world). Each sales transaction will only include one and only one product line - so they can buy two different products, but each transaction will be unique .

   - Once it's determined what 'type' of data we're dealing with, DSX will recommend what type(s) of ML algorithm(s) are relevant in the form of **Estimators**. Estimators are used to train on the data and produce a model for each one. **Click** **Add Estimators**.

 ![](images/tutorials/high-powered-analytics-appliance/image33.jpeg)

  - A list of estimators will be displayed. Leave the **Search** blank (magnifying glass) to let DSX decide which estimator to use. Select all three estimators (Decision Tree Classifier, Random Forest Classifier, Naïve Bayes) to compare results between all 3 , by **clicking** on the

  ![](images/tutorials/high-powered-analytics-appliance/image35.jpeg)

    for each technique. Now **click** **Add**.

  ![](images/tutorials/high-powered-analytics-appliance/image36.jpeg)

  ![](images/tutorials/high-powered-analytics-appliance/image38.jpeg)

  - The list of configured estimators will be listed on the right hand side of the screen. Click **Next** to train and evaluate the model

  ![](images/tutorials/high-powered-analytics-appliance/image40.jpeg).

  - The models will now be trained. This may take some time so please be patient.

  - The results of the 3 estimators will be listed. In this case, the **Decision Tree Classifier** provided the best results. DSX will select the estimator with the best performance, but you can choose the estimator you want to use. In Part 1 of this lab, for example, we used Random Forest. After selecting the estimator type, **click** on **Save**. Note: The accuracy (Performance) of each of these models in this lab exercise is **Poor** or **Fail**. In real world applications, you can achieve greater accuracy by using a customized code via a Notebook as we did in Part 1 of this lab, including more data, and using regularization, normalization or other statistical techniques. To demonstrate the DSX's capability for developing models, we will continue and use only the best of the 3 estimators.

 ![](images/tutorials/high-powered-analytics-appliance/image42.jpeg)

 - You will be prompted to **Save** the model. Each time you use the same model name , its version will be incremented. **Click** **Save**

 ![](images/tutorials/high-powered-analytics-appliance/image44.jpeg)

 - The Model will be processed

 ![](images/tutorials/high-powered-analytics-appliance/image45.jpeg)

 - The list of Models will be displayed. Your list of Models will be different from the screen print below.

 ![](images/tutorials/high-powered-analytics-appliance/image46.jpeg)

D) **Deploying the Model** : After the model is validated, the model will be applied to new data  and implement a **Scoring** system. Now it’s time to deploy the model. **Click** on the 3 dots next to the model you just created, and select **Deploy**

 ![](images/tutorials/high-powered-analytics-appliance/image47.jpeg)

  - In the **Create deployment** screen , **Name** is your team name - example team00. For DSX on IIAS , the only supported deployment type
    is online. For **Type** drop down list - select Online . Click on
    **Create**.

 ![](images/tutorials/high-powered-analytics-appliance/image48.jpeg)

  - The model will be deployed. When it completes, a list of deployed models will be listed under the **Deployments** tab. Under the **Deployment** column, look for your team name e.g. team00 and **Click**.

 ![](images/tutorials/high-powered-analytics-appliance/image49.jpeg)

  - A Deployment screen with deployment parameters will be displayed. The **Deployment Name**, Internal Scoring Endpoints - which is the computing engine used for scoring (e.g., the internal scoring endpoint is an NGINX web server). You can score    models outside DSX using these scoring endpoints via REST APIs such as CURL, for example. **PUBLISHER** is the username (team00) , The **ASSOCIATED MODEL NAME** is the MODEL name , **Input Schema** lists the Input variables , the **Output Schema** includes the predicted variables which includes the product line.

  **Click** ‘**TestAPI**’.

 ![](images/tutorials/high-powered-analytics-appliance/image53.jpeg)

  - Use the provided input or specify something different, then **click** on **Predict**. The scoring results will be displayed. The results indicate that for the following customer demographic : Gender: F (Female), Age: 31, Marital
 Status:Married, Profession: Executive, the predicted product interests are as follows:

 40% - Camping Equipment

 37% - Personal Accessories

  8% - Mountaineering Equipment

  7% - Golf Equipment

  8% - Outdoor Protection

 ![](images/tutorials/high-powered-analytics-appliance/image50.jpeg)

  - You can try other values. To do so, **Click** **Close** to close the current screen. This will bring up the Deployment screen. Then **click** **Test API**. Other values to try are listed in the following table:

  ![](images/tutorials/high-powered-analytics-appliance/image51.jpeg)
