------------------------------------------------------------------------------
-- Licensed Materials - Property of IBM
--
-- (C) COPYRIGHT International Business Machines Corp. 2014
-- All Rights Reserved.
--
-- US Government Users Restricted Rights - Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
------------------------------------------------------------------------------

--
-- complex-3.sql
--

WITH 
"RSF_Query1" AS 
    (
    SELECT
        CUSTOMER.C_CUSTOMER_SK AS "Customers_C_CUSTOMER_SK", 
        SUM(CAST(STORE_SALES.SS_QUANTITY AS DECIMAL(31,2))) AS "Quantity__Store_Sales_"
    FROM
        CUSTOMER CUSTOMER
            INNER JOIN STORE_SALES STORE_SALES
            ON CUSTOMER.C_CUSTOMER_SK = STORE_SALES.SS_CUSTOMER_SK 
    GROUP BY 
        CUSTOMER.C_CUSTOMER_SK
    )
SELECT
    "RSF_Query1"."Customers_C_CUSTOMER_SK" AS "Customers_C_CUSTOMER_SK", 
    "RSF_Query1"."Quantity__Store_Sales_" AS "Quantity__Store_Sales_"
FROM
    "RSF_Query1" 
WHERE 
    "RSF_Query1"."Quantity__Store_Sales_" > 16000.0
fetch first 100 rows only
;
