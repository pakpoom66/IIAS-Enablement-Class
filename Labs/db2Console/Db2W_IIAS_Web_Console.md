

Overview
========

IBM Db2 Warehouse is a software-defined data warehouse for private and virtual clouds that support Docker container technology. It is client managed and optimized for fast and flexible deployment with automated scaling to meet agile analytic workloads. Fusing IBM Db2 BLU and Netezza technologies, Db2 Warehouse offers cloud elasticity combined with the simplicity of a software appliance. It is supported on variety of platforms such as Intel x86, Power and Linux on z and IBM Integrated Analytics System. Db2 Warehouse can also be deployed on IBM Cloud Private platform, IBM Cloud, or any virtual private cloud such as AWS, Microsoft Azure and more.

Introduction
============

Db2 Warehouse is a best-of-breed of database technology that is available in the many deployment form-factors. It combines BLU acceleration with analytical capabilities of Netezza to facilitate analytics for data warehouse. In this Proof-of-Technology, you will learn how to interact with Db2 Warehouse, create tables, load data and query data for exploration. You will also learn how migrated an existing Netezza database into Db2 Warehouse.


Lab 1: Db2 Warehouse Web Console
================================

Lab Objectives
---------------

In this section, you will interface with Db2 Warehouse using the Web Console. You will create a schema, table, load a table and query tables already loaded .

You will use the Virtual Machine (VM) provided to perform the exercises below. Inside the Ubuntu VM you are running the Db2 Warehouse software running as a Docker Container.

> VM User ID: sailfish
>
> VM User PW: passw0rd

Db2 Warehouse Overview
----------------------

Db2® Warehouse is an analytics data warehouse that you deploy by using a Docker container. Db2 Warehouse provides control over data and applications but simple deployment and management. The product offers in-memory BLU processing technology and in-database analytics, plus scalability and performance through the MPP architecture. Db2 Warehouse also provides Oracle and Netezza® compatibility.

You can deploy Db2 Warehouse in a wide range of environments, from a basic laptop (our PoT environment) for development and training purposes, all the way to a large production cluster. You can choose either a single-node (SMP) deployment (our lab) or a multi-node (MPP) deployment. (On Windows and Mac, only SMP deployments are supported.) An MPP deployment has a minimum of three nodes and a maximum of either 24 or 60 nodes. The maximum depends on the number of data partitions that were allocated when you deployed.

The containerization technology that Db2 Warehouse uses makes deployment fast and simple. Deployment typically requires fewer than 30 minutes for an MPP cluster and significantly less for SMP. Usually, only one or two commands are required to download and initialize the image. As you can see in Figure 1, the Db2 Warehouse container is lightweight because it doesn’t contain a guest operating system or a hypervisor, as with a VM. The Db2 Warehouse software stack is isolated in its own container, but you can use your existing infrastructure and cloud management or monitoring tools.

*Figure 1: Architecture for Db2 Warehouse.*

![](./media/image4.png)

IBM® provides two editions of Db2 Warehouse:

-   Db2 Warehouse Enterprise Edition. This is the warranted edition of Db2 Warehouse. You can use this edition in production environments, and it supports both SMP and MPP deployments. It comes with a 90-day trial license so that you can try before buying.

-   Db2 Warehouse Developer Edition. You can use this edition to try out features in your development and test environments; this edition is not intended for production use and is for SMP environments only. This edition is unwarranted and does not come with official IBM support, but you can post questions to the community forum. This edition has a non-expiring free license.

> In this Lab Db2 Warehouse has been set up for you. Details on deploying Db2 Warehouse can be found here: <https://www.ibm.com/support/knowledgecenter/en/SS6NHC/com.ibm.swg.im.dashdb.doc/admin/local_setup.html>

Access the VM Desktop Environment
---------------------------------

1.  Login to VM Desktop:

> VM User ID: sailfish
>
> VM User PW: passw0rd
>
> ![](./media/image5.png)
>
> **The VM Desktop **
>
> For this Lab shortcuts are available on the VM desktop to start/stop, command line, status command line tools. By double clicking these shortcuts you perform the function detailed in the image.
>
> ![](./media/image6.png)

Get the Db2 Warehouse Status
----------------------------

1.  Get the status of the Db2 Warehouse Docker Container by double-clicking the “Status Db2 Warehouse” icon on the desktop. A terminal window will open and display the status. ![](./media/image7.png)

> All Services should be RUNNING as shown above. If a service isn’t running double click the **Stop Db2 Warehouse** icon. Then click the **Start Db2 Warehouse** icon. Wait a few minutes and then Click the “Status Db2 Warehouse” icon.
>
> ***Note***: if you are working in the IBM Integrated Analytics System environment appliance commands are used the perform these operations from the host operating system such as apstart and apstop.
>
> More details available here: <https://www.ibm.com/support/knowledgecenter/en/SS6NHC/com.ibm.swg.im.iias.admin.doc/doc/appl_apcmds.html>

Sign-in to the Web Console
--------------------------

1.  Click the Firefox Icon on the left of the Desktop.

> ![](./media/image8.png)

-  Enter the following in the URL bar:

> <https://172.18.0.2:8443/console/dsconsolelib/shared/login/loginrepauth.jsp>
>
> or click the 172.18.0.2 icon.

1.  Login to the Web Console

-   Use the following user IDs and password:

> ![](./media/image9.png)
>
> VM User ID: bluadmin
>
> VM User PW: bluadmin
>
> As the bluadmin user or another administrator you will see the administrative options in the console. Go ahead and explore the console. When you are ready for the next step click IBM Db2 Warehouse at the top lef of the screen to return the to the Welcome to IBM Db2 Warehouse home page.
>
> ![](./media/image10.png)

Create a Db2 Warehouse User
---------------------------

1.  From the top left corner of the screen, press the **Options** button (“hamburger” button) to expand the menu.

2.  Select **SETTINGS**.

3.  In the expanded options under **SETTINGS**, select **Users and Privileges**.

4.  You will see a list of existing users, along with their user ID, user name, email, whether they have admin privileges. The last column shows the actions you can take such as edit or remove the user.

5.  Click on the **Add** button below the Users tab.

6.  In the Add new user window, enter the following information

    -   User ID: potuser01

    -   Name: pot user

    -   Email: enter your email

    -   Password: Potuser01_123 (Note: password is case sensitive so you will need enter exactly as shown)

    -   Confirm the password: Potuser01_123

        -   Note that the password must match all the criteria, including mixed case letters, at least 1 number and a special symbol and satisfies the length requirement.

    -   Leave User Privilege field as the default with the **User** option checked.

    -   Click on **Create**.

> ![](./media/image11.png)

-   You should see a **SUCCESS** message displayed as the user is created.

-   Click on **Close** to close the Create User window.

> ![](./media/image12.png)

Login as the New Web Console User
---------------------------------

1.  We will switch users now to explore what a typical user will see as they log into the Web console. First log out of the current user by clicking on **Person** icon at the top right corner.

2.  Click on **Sign out** at the bottom of the drop-down menu.

> ![](./media/image13.png)

1.  Confirm signing out by clicking on **Yes** on the pop up window

2.  On the log in screen, enter the credential of the new user we created in the previous section

3.  User name: potuser01

    -   Password: Potuser01\_123 (Note: password is case sensitive)

    -   Click on the **Sign in** button

> ![](./media/image14.png)

-   Notice right away that the log in screen looks different when you log in as a user rather than an administrator. Browse through the available menus.

-   Explore the Web Console for a regular user.

-   **Logout and login as** bluadmin **again.**

Create a Schema as bluadmin
---------------------------

1.  From the top left corner of the screen, press the **Options** button (“hamburger” button) to expand the menu.

2.  Select **ADMINISTER** in the drop-down menu.

3.  Click on **Schemas**

4.  Click **Create**

5.  Enter the schema name: POT

6.  Click the **+** to display the SQL command

7.  Click on the **Run** button.

> ![](./media/image15.png)

1.  Click **Close**

2.  Enter %POT% in the **Filter by Name** field and press enter.

3.  Notice that the new schema is now listed in the list of available schemas.

> ![](./media/image16.png)

1.  New schema created.

Create a table
--------------

Next, we will create new table in the POT schema. We will do this using a script stored on the VM.

1.  Create tables, from the top left corner of the screen, press the **Options** button (“hamburger” button) to expand the menu.

2.  Select **Run SQL** in the drop-down menu.

3.  Run SQL menu option

4.  Click on the Script button, and select **Open from client**

5.  In the pop up window, select **Browse**.

6.  In the **File Upload** window, click on the **Desktop** icon,

7.  Double click the folder **POT**

8.  Double click on the folder **DDL_Go_Sales_DW**

9.  Select the file **POT_DDL_gosalesdw.ddl**

10. Click the **Open** button.

> ![](./media/image17.png)

1.  The file is now selected, click **OK** to confirm the selection. The content of the file is now displayed in the SQL editor.

> ![](./media/image18.png)

1.  Click on the Run button, then select Run all from the menu.

2.  The bottom portion of the window is automatically switched to the **Result** tab. You can see the status of run and click on the line items to view the detail of the execution on the right side.

> ![](./media/image19.png)

-   Results of the run

-   Make sure there are no errors. The statement should have a green check symbol next to it.

-   When the table is created press the Options button (“hamburger” button) to expand the menu and select “**ADMINISTER**” in the drop-down menu.

-   Administer menu option

<!-- -->

-   From the top left corner of the screen, press the Options button (“hamburger” button) to expand the menu.

-   Select **Tables**.

-   Enter **EMP_EXPENSE_FACT** in the **Filter by name** field and press enter.

-   Click on the table **EMP_EXPENSE_FACT** with the “BLUADMIN” schema.

-   ![](./media/image20.png)

-   Explore the available tabs: Properties, Columns, Constraints, Statistics, Dependencies.

Load data using the Web Console
--------------------------------

We will start loading data into the table we just created.

-   From the top left corner of the screen, press the Options button (“hamburger” button) to expand the menu.

-   Select Load in the drop-down menu.

-   Select “Load from file”

-   Click “Choose a file”

-   Click Desktop

-   Double Click the folder “POT”

-   Double Click the folder “Data_Go_Sales_DW”

-   Select the file “EMP_EXPENSE_FACT.csv”

-   Click on the Open button.

> ![](./media/image21.png)

-   Select “No” for Does row one contain the column names?

-   Click the “Preview” button at the bottom right corner of the screen to advance to the Target step.

> ![](./media/image22.png)

-   Review the data preview screen.

-   Click “Next”

-   Select “Load into an existing table” and click “Next”

-   We will select the load target. First select the schema POT.

-   In the tables list, select EMP_EXPENSE_FACT. The table definition will be shown on the right. Notice you have the option to append new data to the table or overwrite the table with new data. In this case, since the table is empty, either option will give us the same result. We will leave it as the default.

> ![](./media/image23.png)

-   Click **Finish**

-   When the load is completed, you will see the statistics displayed, such as number of rows read, loaded and rejected, the duration of the load and any errors or warnings associated with this load job.

> ![](./media/image24.png)

-   Load completed

-   Minimize or close your browser to display the Windows VM desktop.

Query data from the console
---------------------------

Another method to query tables in the database is through the Web Console. Let’s bring up the console if it isn’t already running.

1.  Click the Firefox Icon on the left of the Desktop.

> ![](./media/image8.png)

-   Enter the following in the URL bar:

> <https://172.18.0.2:8443/console/dsconsolelib/shared/login/loginrepauth.jsp>
>
> or click the 172.18.0.2 icon

1.  Login to the Web Console

-   Use the following user IDs and password:

> ![](./media/image9.png)
>
> VM User ID: bluadmin
>
> VM User PW: bluadmin

1.  Before we run SQL, let’s go back to explore the tables we loaded. From the top left corner of the screen, press the Options button (“hamburger” button) to expand the menu.

    -   Select **Run SQL** in menu.

    -   Run SQL menu option

        -   In the editor type the following query

        -   select \* from gosalesdw.emp_employee_dim;

        -   Select **Run all** from the Run drop down box.

        -   The results are displayed on the bottom right, you can scroll through the results.

            ![](./media/image25.png)

2.  Next let’s run the seven queries that we ran from the command line using dbsql. Select the **Script** button from the **RUN SQL** page and select **Open from client**.

3.  Navigate to the folder POT asset by clicking on the folder name under Favorites in the left panel.

4.  Next, we will select the folder SQL_Go_Sales_DW by double clicking on the folder name.

5.  Select folder “SQL_Go_Sales_DW”

    ![](./media/image26.png)

6.  Select the file called **all-queries.sql**, click the **Open** button and click **OK**. The queries should be loaded into the editor. Review the queries.

    ![](./media/image27.png)

7.  Review content of SQL script

8.  Execute the queries by clicking the **Run** button and selecting **Run All**.

9.  The execution results are show on the bottom left and the query results on the bottom right.

10. Examine the results by clicking on the queries in the Results window.

    ![](./media/image28.png)

11. Generate an explain plan for one of the queries.

-   From the top left corner of the screen, press the Options button (“hamburger” button) to expand the menu.

-   Select **Run SQL**

-   Clear out SQL from the editor if necessary, **CTRL+A and DEL**

-   Select the **Script** drop-down button and select **Open From Client**

-   From the **Open script** window select **Browse**

-   Click **Home**

-   Double click **Desktop**

-   Double click the folder **PoT**

-   Double click the folder **SQL_Go_Sales_DW**

-   Select q7-explain.sql

-   Click **Open**

-   Click **OK** from the Open script window to load the query into the editor

-   Select the **Run** button

-   Select **Explain**

-   Examine the explain plan.

    ![](./media/image29.png)

<!-- -->

-   Click on the **CTQ** operator to display the description on the right.

    -   Read explains bottom to top.

    -   Explains represent our most granular form of diagnostics for query performance analysis

    -   CTQ operator denotes boundary between row and column oriented processing for Db2 BLU

    -   Key points for analyzing column-oriented processing with explains

        -   Position of CTQ in the plan indicates how much Db2 is able to leverage the columnar runtime

        -   Also look at the cardinalities (including section actuals) for number of rows flowing out of the CTQ into row-oriented processing

        -   Look for incompatible query constructs, or row oriented data objects that may cause portions of the plan to revert to row-oriented processing

-   Close the Query Graph by pressing CTRL+W

1.  Logout of the console by clicking the Person icon on the top right, click Sign out and click OK.

Congratulations

You have completed the Web Console Lab for IBM Db2 Warehouse / IBM Integrated Analytics System.

####

Notices
=======

This information was developed for products and services offered in the U.S.A.

IBM may not offer the products, services, or features discussed in this document in other countries. Consult your local IBM representative for information on the products and services currently available in your area. Any reference to an IBM product, program, or service is not intended to state or imply that only that IBM product, program, or service may be used. Any functionally equivalent product, program, or service that does not infringe any IBM intellectual property right may be used instead. However, it is the user's responsibility to evaluate and verify the operation of any non-IBM product, program, or service.

IBM may have patents or pending patent applications covering subject matter described in this document. The furnishing of this document does not grant you any license to these patents. You can send license inquiries, in writing, to:

IBM Director of Licensing\
IBM Corporation\
North Castle Drive\
Armonk, NY 10504-1785\
USA

For license inquiries regarding double-byte (DBCS) information, contact the IBM Intellectual Property Department in your country or send inquiries, in writing, to:

IBM World Trade Asia Corporation\
Licensing\
2-31 Roppongi 3-chome, Minato-ku\
Tokyo 106-0032, Japan

**The following paragraph does not apply to the United Kingdom or any other country where such provisions are inconsistent with local law:** INTERNATIONAL BUSINESS MACHINES CORPORATION PROVIDES THIS PUBLICATION "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Some states do not allow disclaimer of express or implied warranties in certain transactions, therefore, this statement may not apply to you.

This information could include technical inaccuracies or typographical errors. Changes are periodically made to the information herein; these changes will be incorporated in new editions of the publication. IBM may make improvements and/or changes in the product(s) and/or the program(s) described in this publication at any time without notice.

Any references in this information to non-IBM web sites are provided for convenience only and do not in any manner serve as an endorsement of those web sites. The materials at those Web sites are not part of the materials for this IBM product and use of those web sites is at your own risk.

IBM may use or distribute any of the information you supply in any way it believes appropriate without incurring any obligation to you.

Any performance data contained herein was determined in a controlled environment. Therefore, the results obtained in other operating environments may vary significantly. Some measurements may have been made on development-level systems and there is no guarantee that these measurements will be the same on generally available systems. Furthermore, some measurements may have been estimated through extrapolation. Actual results may vary. Users of this document should verify the applicable data for their specific environment.

Information concerning non-IBM products was obtained from the suppliers of those products, their published announcements or other publicly available sources. IBM has not tested those products and cannot confirm the accuracy of performance, compatibility or any other claims related to non-IBM products. Questions on the capabilities of non-IBM products should be addressed to the suppliers of those products.

All statements regarding IBM's future direction and intent are subject to change or withdrawal without notice, and represent goals and objectives only.

This information contains examples of data and reports used in daily business operations. To illustrate them as completely as possible, the examples include the names of individuals, companies, brands, and products. All of these names are fictitious and any similarity to the names and addresses used by an actual business enterprise is entirely coincidental. All references to fictitious companies or individuals are used for illustration purposes only.

COPYRIGHT LICENSE:

This information contains sample application programs in source language, which illustrate programming techniques on various operating platforms. You may copy, modify, and distribute these sample programs in any form without payment to IBM, for the purposes of developing, using, marketing or distributing application programs conforming to the application programming interface for the operating platform for which the sample programs are written. These examples have not been thoroughly tested under all conditions. IBM, therefore, cannot guarantee or imply reliability, serviceability, or function of these programs.

Trademarks and copyrights
=========================

The following terms are trademarks of International Business Machines Corporation in the United States, other countries, or both:

IBM IBM logo 1-2-3 AIX DB2 IMS

Lotus Cloudant Sametime IBM Data Studio DCW

Adobe, the Adobe logo, PostScript, and the PostScript logo are either registered trademarks or trademarks of Adobe Systems Incorporated in the United States, and/or other countries.

IT Infrastructure Library is a registered trademark of the Central Computer and Telecommunications Agency which is now part of the Office of Government Commerce.

Intel, Intel logo, Intel Inside, Intel Inside logo, Intel Centrino, Intel Centrino logo, Celeron, Intel Xeon, Intel SpeedStep, Itanium, and Pentium are trademarks or registered trademarks of Intel Corporation or its subsidiaries in the United States and other countries.

Linux is a registered trademark of Linus Torvalds in the United States, other countries, or both.

Microsoft, Windows, Windows NT, and the Windows logo are trademarks of Microsoft Corporation in the United States, other countries, or both.

Oracle is a registered trademark of Oracle Corporation and/or its affiliates.

ITIL is a registered trademark, and a registered community trademark of The Minister for the Cabinet Office, and is registered in the U.S. Patent and Trademark Office.

UNIX is a registered trademark of The Open Group in the United States and other countries.

Java and all Java-based trademarks and logos are trademarks or registered trademarks of Oracle and/or its affiliates.

Cell Broadband Engine is a trademark of Sony Computer Entertainment, Inc. in the United States, other countries, or both and is used under license therefrom.

Linear Tape-Open, LTO, the LTO Logo, Ultrium, and the Ultrium logo are trademarks of HP, IBM Corp. and Quantum in the U.S. and other countries.

![IBM-600dpi-1](./media/image30.png)

© Copyright IBM Corporation 2018.

The information contained in these materials is provided for informational purposes only, and is provided AS IS without warranty of any kind, express or implied. IBM shall not be responsible for any damages arising out of the use of, or otherwise related to, these materials. Nothing contained in these materials is intended to, nor shall have the effect of, creating any warranties or representations from IBM or its suppliers or licensors, or altering the terms and conditions of the applicable license agreement governing the use of IBM software. References in these materials to IBM products, programs, or services do not imply that they will be available in all countries in which IBM operates. This information is based on current IBM product plans and strategy, which are subject to change by IBM without notice. Product release dates and/or capabilities referenced in these materials may change at any time at IBM’s sole discretion based on market opportunities or other factors, and are not intended to be a commitment to future product or feature availability in any way.

IBM, the IBM logo and ibm.com are trademarks of International Business Machines Corp., registered in many jurisdictions worldwide. Other product and service names might be trademarks of IBM or other companies. A current list of IBM trademarks is available on the web at “Copyright and trademark information” at www.ibm.com/legal/copytrade.shtml.

![Please Recycle](./media/image31.png)
