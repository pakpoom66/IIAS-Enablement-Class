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
-- simple-08.sql
--

select "m_RETURNED_DATE_DIM".D_YEAR AS "column0",
       "m_RETURNED_DATE_DIM".D_YEAR_NAME AS "column1" 
FROM  ( SELECT DATE_DIM.D_YEAR AS D_YEAR,
               CAST(DATE_DIM.D_YEAR AS VARCHAR(4)) AS D_YEAR_NAME 
        FROM DATE_DIM DATE_DIM )  "m_RETURNED_DATE_DIM" 
WHERE "m_RETURNED_DATE_DIM".D_YEAR IN ( 1998, 1999, 2000, 2001 ) 
GROUP BY "m_RETURNED_DATE_DIM".D_YEAR
       , "m_RETURNED_DATE_DIM".D_YEAR_NAME 
ORDER BY "column0" ASC
       , "column1" ASC
;
