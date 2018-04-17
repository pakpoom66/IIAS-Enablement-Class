SET CURRENT SCHEMA BDI_LAB;

CREATE TABLE time_dim
(
time_code     INT,
order_date    DATE,
month_code    SMALLINT,
month_name    CHAR(10),
quarter_code  SMALLINT,
quarter_name  CHAR(10),
year INTEGER
)
distribute by random
in BDI_TSDIM
;
