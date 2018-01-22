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
-- intermediate-20.sql
--

with ss as (
 select i_item_id
        ,sum(ss_ext_sales_price) total_sales
 from
        store_sales,
        date_dim,
        customer_address,
        item
 where
        i_item_id in (select i_item_id
                      from item
                      where i_category in ( 'Books' ))
                        and ss_item_sk              = i_item_sk
                        and ss_sold_date_sk         = d_date_sk
                        and d_year                  = 2000
                        and d_moy                   = 6
                        and ss_addr_sk              = ca_address_sk
                        and ca_gmt_offset           = -5
                      group by i_item_id),

cs as (
 select i_item_id
        ,sum(cs_ext_sales_price) total_sales
 from
        catalog_sales,
        date_dim,
        customer_address,
        item
 where
        i_item_id in (select i_item_id
                      from item
                      where i_category in ( 'Books' ))
                        and cs_item_sk              = i_item_sk
                        and cs_sold_date_sk         = d_date_sk
                        and d_year                  = 2000
                        and d_moy                   = 6
                        and cs_bill_addr_sk         = ca_address_sk
                        and ca_gmt_offset           = -5
                      group by i_item_id),
ws as (
 select
          i_item_id
         ,sum(ws_ext_sales_price) total_sales
 from
        web_sales,
        date_dim,
        customer_address,
        item
 where
        i_item_id in (select i_item_id
                      from item
                      where i_category in ( 'Books' ))
                        and ws_item_sk              = i_item_sk
                        and ws_sold_date_sk         = d_date_sk
                        and d_year                  = 2000
                        and d_moy                   = 6
                        and ws_bill_addr_sk         = ca_address_sk
                        and ca_gmt_offset           = -5
                      group by i_item_id)
select
  i_item_id
 ,sum(total_sales) total_sales
from  ( select * from ss
        union all
        select * from cs
        union all
        select * from ws) tmp1
 group by i_item_id
  fetch first 100 rows only
;
