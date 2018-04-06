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
-- intermediate-01.sql
--

select  sum(cs_ext_discount_amt)  as "excess discount amount" 
from 
   catalog_sales 
  ,item 
  ,date_dim
where
    i_manufact_id = 199
and i_item_sk = cs_item_sk 
and d_date between '1998-03-18' and 
        (cast('1998-03-18' as date) + 90 days)
and d_date_sk = cs_sold_date_sk 
and cs_ext_discount_amt  
     >= ( 
         select 
            1.3 * avg(cs_ext_discount_amt) 
         from 
            catalog_sales 
           ,date_dim
         where 
              cs_item_sk = i_item_sk 
          and d_date between '1998-03-18' and
                             (cast('1998-03-18' as date) + 90 days)
          and d_date_sk = cs_sold_date_sk 
      ) 
 fetch first 100 rows only
;
