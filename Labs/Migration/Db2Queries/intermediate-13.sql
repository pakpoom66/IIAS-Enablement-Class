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
-- intermediate-13.sql
--

SELECT
    ITEM.I_CATEGORY AS "Items_Trimmed_Category", 
    ITEM.I_CLASS AS "Items_Trimmed_Clasification", 
    ITEM.I_BRAND AS "Items_Trimmed_Brand", 
    SUM(STORE_SALES.SS_NET_PROFIT) AS "Net_Profit__Stor",
    SUM(STORE_SALES.SS_COUPON_AMT) AS "Coupon_Amount__S",
    SUM(STORE_SALES.SS_NET_PAID - CAST(STORE_SALES.SS_WHOLESALE_COST AS DECIMAL(31,2))) AS "Gross_Profit__St"
FROM
    ITEM ITEM
        INNER JOIN STORE_SALES STORE_SALES
        ON ITEM.I_ITEM_SK = STORE_SALES.SS_ITEM_SK 
WHERE 
    ITEM.I_CATEGORY IN ( 'Music', 'Men', 'Children' ) AND
    ITEM.I_CLASS IN ( 'accessories', 'classical', 'infants' ) AND
    ITEM.I_BRAND IN ( 'importoexporti #2', 'amalgimporto #2', 'edu packscholar #2' ) 
GROUP BY 
    ITEM.I_CATEGORY, 
    ITEM.I_CLASS, 
    ITEM.I_BRAND
;
