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
-- intermediate-25.sql
--

select c_last_name 
      ,c_first_name 
      ,ca_city 
      ,bought_city 
      ,t_hour 
      ,ss_ticket_number 
      ,amt 
      ,profit 
from (select ss_ticket_number 
            ,ss_customer_sk 
            ,ca_city bought_city 
            ,ss_sold_time_sk 
            ,sum(ss_coupon_amt) amt 
            ,sum(ss_net_profit) profit 
      from store_sales ss 
          ,date_dim datedim 
          ,store store  
          ,household_demographics hd 
          ,customer_address ca 
       where ss.ss_sold_date_sk = datedim.d_date_sk 
         and ss.ss_store_sk = store.s_store_sk 
         and ss.ss_hdemo_sk = hd.hd_demo_sk 
         and ss.ss_addr_sk = ca.ca_address_sk 
         and (hd.hd_dep_count = 2 or hd.hd_vehicle_count= 1) 
         and store.s_city in ('Fairview','Midway','Union','Salem','Highland Park')
       group by ss_ticket_number 
               ,ss_customer_sk 
               ,ss_addr_sk 
               ,ca_city 
               ,ss_sold_time_sk) dn 
    ,customer customer 
    ,customer_address current_addr 
    ,time_dim timedim 
where ss_customer_sk = c_customer_sk 
  and customer.c_current_addr_sk = current_addr.ca_address_sk 
  and ss_sold_time_sk = timedim.t_time_sk 
  and current_addr.ca_city <> bought_city 
order by c_last_name 
        ,c_first_name 
        ,ca_city 
        ,bought_city 
        ,ss_ticket_number 
fetch first 100 rows only
;
