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
-- intermediate-06.sql
--

SELECT
    ITEM.I_CATEGORY AS "Items_Trimmed_Category", 
    ITEM.I_CLASS AS "Items_Trimmed_Clasification", 
    ITEM.I_BRAND AS "Items_Trimmed_Brand",
    AVG(CAST(STORE_SALES.SS_LIST_PRICE AS DOUBLE PRECISION)) AS "List_Price__Store_Sales_",
    SUM(CAST(STORE_SALES.SS_WHOLESALE_COST AS DECIMAL(31,2))) AS "Wholesale__Cost__"
FROM
    ITEM ITEM
        INNER JOIN STORE_SALES STORE_SALES
        ON ITEM.I_ITEM_SK = STORE_SALES.SS_ITEM_SK 
WHERE 
    ITEM.I_CATEGORY IN ( 'Music', 'Men', 'Children' )
AND ITEM.I_CLASS IN ( 'accessories', 'classical', 'infants' )
GROUP BY 
    ITEM.I_CATEGORY, 
    ITEM.I_CLASS,
    ITEM.I_BRAND
;
