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
-- complex-4.sql
--

with v1 as( 
 select i_category, 
        i_brand, 
        cc_name, 
        d_year, 
        d_moy, 
        sm_type, 
        sum(cs_sales_price) sum_sales, 
        avg(sum(cs_sales_price)) over 
               (partition by i_category, i_brand, cc_name, d_year) avg_monthly_sales, 
        rank() over 
           (partition by i_category, i_brand, cc_name 
                order by d_year, d_moy) rn 
 from item 
    , catalog_sales 
    , date_dim 
    , call_center 
    , ship_mode 
 where cs_item_sk = i_item_sk 
   and cs_sold_date_sk = d_date_sk 
   and cc_call_center_sk= cs_call_center_sk 
   and cs_ship_mode_sk = sm_ship_mode_sk 
   and d_year = 2000
 group by i_category 
        , i_brand 
        , cc_name 
        , d_year 
        , d_moy 
        , sm_type), 
 v2 as( 
 select v1.i_category
      , v1.i_brand
	 , v1.cc_name
	 , v1.d_year
	 , v1.d_moy
	 , v1.avg_monthly_sales
	 , v1.sum_sales
	 , v1.sm_type
	 , v1_lag.sum_sales psum
	 , v1_lead.sum_sales nsum 
 from v1 
    , v1 v1_lag 
    , v1 v1_lead 
 where v1.i_category = v1_lag.i_category 
   and v1.i_category = v1_lead.i_category 
   and v1.i_brand = v1_lag.i_brand 
   and v1.i_brand = v1_lead.i_brand 
   and v1. cc_name = v1_lag.cc_name 
   and v1. cc_name = v1_lead.cc_name 
   and v1.rn = v1_lag.rn + 1 
   and v1.rn = v1_lead.rn - 1) 
select * 
from v2 
where d_year = 2000
  and avg_monthly_sales > 0 
  and case when avg_monthly_sales > 0 
           then abs(sum_sales - avg_monthly_sales) / avg_monthly_sales 
		 else null end > 0.1 
order by sum_sales - avg_monthly_sales 
       , cc_name 
fetch first 100 rows only
;
