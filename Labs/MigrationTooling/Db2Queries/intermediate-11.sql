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
-- intermediate-11.sql
--

with ss as
 (select ca_county
        ,d_qoy
        ,d_year
        ,sum(ss_ext_sales_price) as store_sales
 from store_sales
     ,date_dim
     ,customer_address
 where ss_sold_date_sk = d_date_sk
   and ss_addr_sk=ca_address_sk
 group by ca_county,d_qoy, d_year),
ws as
 (select ca_county
        ,d_qoy
        ,d_year
        ,sum(ws_ext_sales_price) as web_sales
 from web_sales
     ,date_dim
     ,customer_address
 where ws_sold_date_sk = d_date_sk
   and ws_bill_addr_sk=ca_address_sk
 group by ca_county
         ,d_qoy
         , d_year)
 select /* tt */
        ss1.ca_county
       ,ss1.d_year
       ,ws2.web_sales/ws1.web_sales web_q1_q2_increase
       ,ss2.store_sales/ss1.store_sales store_q1_q2_increase
       ,ws3.web_sales/ws2.web_sales web_q2_q3_increase
       ,ss3.store_sales/ss2.store_sales store_q2_q3_increase
 from
        ss ss1
       ,ss ss2
       ,ss ss3
       ,ws ws1
       ,ws ws2
       ,ws ws3
 where
    ss1.d_qoy = 1
    and ss1.d_year = 1998
    and ss1.ca_county = ss2.ca_county
    and ss2.d_qoy = 2
    and ss2.d_year = 1998
 and ss2.ca_county = ss3.ca_county
    and ss3.d_qoy = 3
    and ss3.d_year = 1998
    and ss1.ca_county = ws1.ca_county
    and ws1.d_qoy = 1
    and ws1.d_year = 1998
    and ws1.ca_county = ws2.ca_county
    and ws2.d_qoy = 2
    and ws2.d_year = 1998
    and ws1.ca_county = ws3.ca_county
    and ws3.d_qoy = 3
    and ws3.d_year =1998
    and case when ws1.web_sales > 0 
             then cast(ws2.web_sales as decimal(25,2))/ws1.web_sales 
             else null end
       > case when ss1.store_sales > 0 
              then cast(ss2.store_sales as decimal(25,2))/ss1.store_sales 
              else null end
     order by ss1.ca_county
;
