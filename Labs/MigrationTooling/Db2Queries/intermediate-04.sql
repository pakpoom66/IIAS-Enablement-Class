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
-- intermediate-04.sql
--

SELECT
    DATE_DIM.D_WEEK_SEQ AS "Date_D_WEEK_SEQ",
    ITEM.I_CATEGORY AS "Items_Trimmed_Category",
    STORE.S_COUNTRY AS "Stores_S_COUNTRY",
    STORE.S_STATE AS "Stores_S_STATE",
    STORE.S_COUNTY AS "Stores_S_COUNTY",
    STORE.S_CITY AS "Stores_S_CITY",
    SUM(CAST(STORE_SALES.SS_WHOLESALE_COST AS DECIMAL(31,2))) AS "WholeSale_Cost__Store_Sales_"
FROM
    DATE_DIM DATE_DIM
        INNER JOIN STORE_SALES STORE_SALES
        ON DATE_DIM.D_DATE_SK = STORE_SALES.SS_SOLD_DATE_SK
            INNER JOIN ITEM ITEM
            ON ITEM.I_ITEM_SK = STORE_SALES.SS_ITEM_SK
                INNER JOIN STORE STORE
                ON STORE.S_STORE_SK = STORE_SALES.SS_STORE_SK
WHERE
    DATE_DIM.D_YEAR IN ( 2002 ) 
AND DATE_DIM.D_QOY IN ( 4 ) 
AND ITEM.I_CATEGORY IN ( 'Electronics' ) 
AND STORE.S_COUNTRY IN ( 'United States' ) 
AND STORE.S_STATE IN ( 'TN' )
GROUP BY
    DATE_DIM.D_WEEK_SEQ,
    ITEM.I_CATEGORY,
    STORE.S_COUNTRY,
    STORE.S_STATE,
    STORE.S_COUNTY,
    STORE.S_CITY
;
