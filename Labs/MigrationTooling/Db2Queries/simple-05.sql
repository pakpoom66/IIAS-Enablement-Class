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
-- simple-05.sql
--

select 
    "m_STORE".S_COUNTRY AS "column0", 
    "m_STORE".S_STATE AS "column1" 
FROM  ( 
    SELECT 
        STORE.S_COUNTRY AS S_COUNTRY, 
        STORE.S_STATE AS S_STATE 
    FROM 
        STORE STORE
    GROUP BY 
        STORE.S_COUNTRY
      , STORE.S_STATE 
    )  "m_STORE" 
GROUP BY 
    "m_STORE".S_COUNTRY, 
    "m_STORE".S_STATE 
ORDER BY 
    "column0" ASC, 
    "column1" ASC
;
