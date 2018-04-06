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
-- intermediate-19.sql
--

SELECT
    STORE.S_COUNTRY AS "Stores_S_COUNTRY", 
    STORE.S_STATE AS "Stores_S_STATE", 
    SUM(CAST(STORE_SALES.SS_QUANTITY AS DECIMAL(31,2))) AS "Quantity__Store_Sales_"
FROM
    DATE_DIM DATE_DIM
        INNER JOIN STORE_SALES STORE_SALES
        ON DATE_DIM.D_DATE_SK = STORE_SALES.SS_SOLD_DATE_SK
            INNER JOIN STORE STORE
            ON STORE.S_STORE_SK = STORE_SALES.SS_STORE_SK
WHERE 
    STORE.S_COUNTRY IN ( 'United States' )
AND STORE.S_STATE IN ( 'TN' )
GROUP BY 
    STORE.S_COUNTRY, 
    STORE.S_STATE
ORDER BY
    "Stores_S_COUNTRY",
    "Stores_S_STATE"
;
