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
-- intermediate-03.sql
--

SELECT
    STORE.S_STORE_SK AS "Stores_S_STORE_SK",
    SUM(STORE_SALES.SS_NET_PAID) AS "Net_Paid__Store_Sales_",
    SUM(STORE_SALES.SS_COUPON_AMT) AS "Coupon_Amount__S",
    SUM(STORE_SALES.SS_NET_PAID - CAST(STORE_SALES.SS_WHOLESALE_COST AS DECIMAL(31,2))) AS "Gross_Profit__St"
FROM
    STORE STORE
        INNER JOIN STORE_SALES STORE_SALES
        ON STORE.S_STORE_SK = STORE_SALES.SS_STORE_SK
WHERE
    STORE.S_COUNTRY IN ( 'United States' )
AND STORE.S_STATE IN ( 'TN' )
GROUP BY
    STORE.S_STORE_SK
;
