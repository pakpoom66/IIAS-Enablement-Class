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
-- complex-2.sql
--

SELECT
    CD.CD_CREDIT_RATING AS "Customers_Cd_Credit_Rating",
    STORE.S_COUNTRY AS "Stores_S_COUNTRY",
    IB.IB_INCOME_BAND_SK AS "Household_Demographics_IB_INCOME_BAND_SK",
    SUM(SS.SS_NET_PROFIT) AS "Net_Profit__Store_Sales_",
    SUM(SS.SS_LIST_PRICE) AS "List_Price__Store_Sales_",
    SUM(SS.SS_SALES_PRICE) AS "Sales_Price__Store_Sales_",
    SUM(SS.SS_COUPON_AMT) AS "Coupon_Amount___Store_Sales_",
    SUM(SS.SS_NET_PAID) AS "Net_Paid__Store_Sales_",
    SUM(CAST(SS.SS_QUANTITY AS DECIMAL(31,2))) AS "Quantity__Store_Sales_",
    SUM(CAST(SS.SS_WHOLESALE_COST AS DECIMAL(31,2))) AS "WholeSale_Cost__Store_Sales_",
    SUM(SS.SS_NET_PAID - CAST(SS.SS_WHOLESALE_COST AS DECIMAL(31,2))) AS "Gross_Profit__Store_Sales_"
FROM
    CUSTOMER CUSTOMER
        INNER JOIN STORE_SALES SS
        ON CUSTOMER.C_CUSTOMER_SK = SS.SS_CUSTOMER_SK
            INNER JOIN CUSTOMER_DEMOGRAPHICS CD
            ON CD.CD_DEMO_SK = CUSTOMER.C_CURRENT_CDEMO_SK
                INNER JOIN HOUSEHOLD_DEMOGRAPHICS HD
                ON HD.HD_DEMO_SK = SS.SS_HDEMO_SK
                    INNER JOIN INCOME_BAND IB
                    ON IB.IB_INCOME_BAND_SK = HD.HD_INCOME_BAND_SK
                        INNER JOIN STORE STORE
                        ON STORE.S_STORE_SK = SS.SS_STORE_SK 
GROUP BY 
    CD.CD_CREDIT_RATING, 
    STORE.S_COUNTRY,
    IB.IB_INCOME_BAND_SK
ORDER BY
    "Customers_Cd_Credit_Rating",
    "Stores_S_COUNTRY",
    "Household_Demographics_IB_INCOME_BAND_SK"
;
