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
-- intermediate-21.sql
--

select
  c_last_name
 ,c_first_name
 ,substr(s_city,1,30)
 ,ss_ticket_number
 ,amt
 ,profit
from
   (select ss_ticket_number
          ,ss_customer_sk
          ,s_city
          ,sum(ss_coupon_amt) amt
          ,sum(ss_net_profit) profit
    from store_sales ss
        ,date_dim datedim
        ,store store
        ,household_demographics hd
    where ss.ss_sold_date_sk = datedim.d_date_sk
      and ss.ss_store_sk = store.s_store_sk
      and ss.ss_hdemo_sk = hd.hd_demo_sk
      and (hd.hd_dep_count = 2 or hd.hd_vehicle_count > 1)
      and datedim.d_dow = 3
      and datedim.d_moy = 6
      and datedim.d_year in (2000)
      and store.s_number_employees between 200 and 250
      group by ss_ticket_number
              ,ss_customer_sk
              ,ss_addr_sk
              ,s_city) ms
  ,customer
  where ss_customer_sk = c_customer_sk
  order by c_last_name
          ,c_first_name
          ,substr(s_city,1,30)
          ,profit
 fetch first 100 rows only
;
