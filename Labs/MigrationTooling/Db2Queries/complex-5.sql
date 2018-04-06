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
-- complex-5.sql
--

SELECT
    STORE.S_STORE_SK AS "Stores_S_STORE_SK", 
    (SUM(STORE_SALES.SS_NET_PAID) - SUM(CAST(STORE_SALES.SS_WHOLESALE_COST AS DECIMAL(31,2)))) * SUM(CAST(STORE_SALES.SS_QUANTITY AS DECIMAL(31,2))) AS "SubTotal_Gross_Profit__Store_Sales_"
FROM
    STORE STORE
        INNER JOIN STORE_SALES STORE_SALES
        ON STORE.S_STORE_SK = STORE_SALES.SS_STORE_SK 
--WHERE 
--    STORE.S_COUNTRY IN ( 'United States' ) 
GROUP BY 
    STORE.S_STORE_SK
;
