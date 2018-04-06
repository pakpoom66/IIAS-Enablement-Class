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
-- intermediate-10.sql
--

select dt.d_year
      ,item.i_brand_id brand_id
      ,item.i_brand brand
      ,sum(ss_ext_sales_price) ext_price
      ,avg(ss_ext_discount_amt) ext_discount
 from date_dim dt
     ,store_sales store_sales
     ,item item
 where dt.d_date_sk = store_sales.ss_sold_date_sk
    and store_sales.ss_item_sk = item.i_item_sk
    and item.i_manager_id = 20
    and dt.d_year in ( 1999, 2000, 2001 )
 group by dt.d_year
         ,item.i_brand
         ,item.i_brand_id
 order by dt.d_year
         ,ext_price desc
         ,brand_id
 fetch first 100 rows only
;
