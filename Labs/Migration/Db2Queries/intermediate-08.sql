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
-- intermediate-08.sql
--

SELECT
    DATE_DIM.D_YEAR AS "Date_D_YEAR",
    DATE_DIM.D_QOY AS "Date_D_QOY",
    SUM(CAST(STORE_SALES.SS_QUANTITY AS DECIMAL(31,2))) AS "Quantity__Store_Sales_"
FROM
    DATE_DIM DATE_DIM
        INNER JOIN STORE_SALES STORE_SALES
        ON DATE_DIM.D_DATE_SK = STORE_SALES.SS_SOLD_DATE_SK
WHERE
    DATE_DIM.D_YEAR IN ( 1999, 2000, 2001 )
GROUP BY
    DATE_DIM.D_YEAR,
    DATE_DIM.D_QOY
;
