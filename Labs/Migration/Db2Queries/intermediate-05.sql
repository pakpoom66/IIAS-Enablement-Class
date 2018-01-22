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
-- intermediate-05.sql
--

select
        "m_STORE".S_COUNTRY AS "column0",
        "m_STORE".S_STATE AS "column1",
        SUM("m_STORE_SALES".SS_SALES_PRICE) AS "column2"
FROM  (
        SELECT
                DATE_DIM.D_DATE_SK AS D_DATE_SK,
                DATE_DIM.D_YEAR AS D_YEAR
        FROM DATE_DIM DATE_DIM
        )  "m_SOLD_DATE_DIM"
INNER JOIN  (
        SELECT
                STORE_SALES.SS_SOLD_DATE_SK AS SS_SOLD_DATE_SK,
                STORE_SALES.SS_STORE_SK AS SS_STORE_SK,
                STORE_SALES.SS_SALES_PRICE AS SS_SALES_PRICE
        FROM STORE_SALES STORE_SALES
        )  "m_STORE_SALES"
ON "m_SOLD_DATE_DIM".D_DATE_SK = "m_STORE_SALES".SS_SOLD_DATE_SK
INNER JOIN  (
        SELECT
                STORE.S_COUNTRY AS S_COUNTRY,
                STORE.S_STATE AS S_STATE,
                STORE.S_STORE_SK AS S_STORE_SK
        FROM STORE STORE
        LEFT OUTER JOIN DATE_DIM END_DATE_DIM
        ON END_DATE_DIM.D_DATE_SK = STORE.S_CLOSED_DATE_SK
        )  "m_STORE"
ON "m_STORE".S_STORE_SK = "m_STORE_SALES".SS_STORE_SK
WHERE "m_SOLD_DATE_DIM".D_YEAR IN ( 1999, 2000 )
GROUP BY
        "m_STORE".S_COUNTRY,
        "m_STORE".S_STATE
order by
        "column0",
        "column1"
;
