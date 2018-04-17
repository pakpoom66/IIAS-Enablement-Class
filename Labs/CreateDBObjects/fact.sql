CREATE TABLE sales_fact
(
customer_code  INTEGER,
district_code  SMALLINT,
time_code      INTEGER,
product_code   INTEGER,
units_sold     SMALLINT,
revenue        DECIMAL(8,2),
cost           DECIMAL(8,2),
net_profit     DECIMAL(8,2)
)
distribute by (customer_code)
in BDI_TSFACT
;
