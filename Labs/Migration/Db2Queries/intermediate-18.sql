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
-- intermediate-18.sql
--

select c_last_name
      ,c_first_name
      ,c_salutation
      ,c_preferred_cust_flag
      ,ss_ticket_number
      ,cnt from
   (select ss_ticket_number
          ,ss_customer_sk
          ,count(*) cnt
    from store_sales ss
        ,date_dim datedim
        ,store store
        ,household_demographics hd
    where ss.ss_sold_date_sk = datedim.d_date_sk
      and ss.ss_store_sk = store.s_store_sk
      and ss.ss_hdemo_sk = hd.hd_demo_sk
      and (datedim.d_dom between 1 and 3 or datedim.d_dom between 25 and 28)
      and hd.hd_buy_potential = '>10000'
      and hd.hd_vehicle_count > 0
      and (case when hd.hd_vehicle_count > 0
           then hd.hd_dep_count/ hd.hd_vehicle_count
           else null end)  > 1.2
      and datedim.d_year in (2000,2000+1)
      and store.s_county in ('Williamson County','Maverick County','Huron County','Kittitas County', 'Fairfield County','Jackson County','Barrow County','Pennington County')
    group by ss_ticket_number
            ,ss_customer_sk) dn
  ,customer
    where ss_customer_sk = c_customer_sk
      and cnt between 15 and 20
    order by c_last_name
            ,c_first_name
            ,c_salutation
            ,c_preferred_cust_flag desc
    fetch first 100 rows only
;
