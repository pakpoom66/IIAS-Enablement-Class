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
-- complex-1.sql
--

select  count(*) from (
    select distinct c_last_name
                  , c_first_name
                  , d_date
    from store_sales
       , date_dim
       , customer
    where store_sales.ss_sold_date_sk = date_dim.d_date_sk
      and store_sales.ss_customer_sk = customer.c_customer_sk
      and d_year = 2000
  intersect
    select distinct c_last_name
                  , c_first_name
                  , d_date
    from catalog_sales
       , date_dim
       , customer
    where catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
      and catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
      and d_year = 2000
  intersect
    select distinct c_last_name
                  , c_first_name
                  , d_date
    from web_sales
       , date_dim
       , customer
    where web_sales.ws_sold_date_sk = date_dim.d_date_sk
      and web_sales.ws_bill_customer_sk = customer.c_customer_sk
      and d_year = 2000
) hot_cust
 fetch first 100 rows only
;
