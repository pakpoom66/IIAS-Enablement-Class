
\echo
\echo *****  Creating database:  "BDI00"
CREATE DATABASE BDI00 ;

\echo
\echo ************************************************************
\echo ************************************************************
\echo ************************************************************
\echo
\echo
\echo *****  Connecting to database:  "BDI00"
\echo
\echo
\echo ************************************************************
\echo ************************************************************
\echo ************************************************************
\echo
\set ON_ERROR_STOP TRUE
\connect BDI00
\unset ON_ERROR_STOP

\echo
\echo *****  Creating schema:  "BDINSIGHTS"
CREATE SCHEMA  BDINSIGHTS
;

\echo
\echo *********************
\echo ***** Setting schema:  "BDINSIGHTS"
\echo *********************
\echo
\set ON_ERROR_STOP TRUE
set schema "BDINSIGHTS";
\unset ON_ERROR_STOP
\echo


\echo
\echo *****  Creating table:  "CALL_CENTER"

CREATE TABLE  CALL_CENTER
(
     CC_CALL_CENTER_SK            bigint                    not null,
     CC_CALL_CENTER_ID            character(16)             not null,
     CC_REC_START_DATE            date,
     CC_REC_END_DATE              date,
     CC_CLOSED_DATE_SK            bigint,
     CC_OPEN_DATE_SK              bigint,
     CC_NAME                      character varying(50),
     CC_CLASS                     character varying(50),
     CC_EMPLOYEES                 bigint,
     CC_SQ_FT                     bigint,
     CC_HOURS                     character(20),
     CC_MANAGER                   character varying(40),
     CC_MKT_ID                    bigint,
     CC_MKT_CLASS                 character(50),
     CC_MKT_DESC                  character varying(100),
     CC_MARKET_MANAGER            character varying(40),
     CC_DIVISION                  bigint,
     CC_DIVISION_NAME             character varying(50),
     CC_COMPANY                   bigint,
     CC_COMPANY_NAME              character(50),
     CC_STREET_NUMBER             character(10),
     CC_STREET_NAME               character varying(60),
     CC_STREET_TYPE               character(15),
     CC_SUITE_NUMBER              character(10),
     CC_CITY                      character varying(60),
     CC_COUNTY                    character varying(30),
     CC_STATE                     character(2),
     CC_ZIP                       character(10),
     CC_COUNTRY                   character varying(20),
     CC_GMT_OFFSET                numeric(5,2),
     CC_TAX_PERCENTAGE            numeric(5,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  CALL_CENTER
ALTER TABLE CALL_CENTER ADD PRIMARY KEY (CC_CALL_CENTER_SK);

\echo
\echo *****  Creating table:  "CATALOG_PAGE"

CREATE TABLE  CATALOG_PAGE
(
     CP_CATALOG_PAGE_SK           bigint                    not null,
     CP_CATALOG_PAGE_ID           character(16)             not null,
     CP_START_DATE_SK             bigint,
     CP_END_DATE_SK               bigint,
     CP_DEPARTMENT                character varying(50),
     CP_CATALOG_NUMBER            bigint,
     CP_CATALOG_PAGE_NUMBER       bigint,
     CP_DESCRIPTION               character varying(100),
     CP_TYPE                      character varying(100)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  CATALOG_PAGE
ALTER TABLE CATALOG_PAGE ADD PRIMARY KEY (CP_CATALOG_PAGE_SK);

\echo
\echo *****  Creating table:  "CATALOG_RETURNS"

CREATE TABLE  CATALOG_RETURNS
(
     CR_RETURNED_DATE_SK          bigint,
     CR_RETURNED_TIME_SK          bigint,
     CR_ITEM_SK                   bigint                    not null,
     CR_REFUNDED_CUSTOMER_SK      bigint,
     CR_REFUNDED_CDEMO_SK         bigint,
     CR_REFUNDED_HDEMO_SK         bigint,
     CR_REFUNDED_ADDR_SK          bigint,
     CR_RETURNING_CUSTOMER_SK     bigint,
     CR_RETURNING_CDEMO_SK        bigint,
     CR_RETURNING_HDEMO_SK        bigint,
     CR_RETURNING_ADDR_SK         bigint,
     CR_CALL_CENTER_SK            bigint,
     CR_CATALOG_PAGE_SK           bigint,
     CR_SHIP_MODE_SK              bigint,
     CR_WAREHOUSE_SK              bigint,
     CR_REASON_SK                 bigint,
     CR_ORDER_NUMBER              bigint                    not null,
     CR_RETURN_QUANTITY           bigint,
     CR_RETURN_AMOUNT             numeric(7,2),
     CR_RETURN_TAX                numeric(7,2),
     CR_RETURN_AMT_INC_TAX        numeric(7,2),
     CR_FEE                       numeric(7,2),
     CR_RETURN_SHIP_COST          numeric(7,2),
     CR_REFUNDED_CASH             numeric(7,2),
     CR_REVERSED_CHARGE           numeric(7,2),
     CR_STORE_CREDIT              numeric(7,2),
     CR_NET_LOSS                  numeric(7,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  CATALOG_RETURNS
ALTER TABLE CATALOG_RETURNS ADD PRIMARY KEY (CR_ITEM_SK, CR_ORDER_NUMBER);

\echo
\echo *****  Creating table:  "CATALOG_SALES"

CREATE TABLE  CATALOG_SALES
(
     CS_SOLD_DATE_SK              bigint,
     CS_SOLD_TIME_SK              bigint,
     CS_SHIP_DATE_SK              bigint,
     CS_BILL_CUSTOMER_SK          bigint,
     CS_BILL_CDEMO_SK             bigint,
     CS_BILL_HDEMO_SK             bigint,
     CS_BILL_ADDR_SK              bigint,
     CS_SHIP_CUSTOMER_SK          bigint,
     CS_SHIP_CDEMO_SK             bigint,
     CS_SHIP_HDEMO_SK             bigint,
     CS_SHIP_ADDR_SK              bigint,
     CS_CALL_CENTER_SK            bigint,
     CS_CATALOG_PAGE_SK           bigint,
     CS_SHIP_MODE_SK              bigint,
     CS_WAREHOUSE_SK              bigint,
     CS_ITEM_SK                   bigint                    not null,
     CS_PROMO_SK                  bigint,
     CS_ORDER_NUMBER              bigint                    not null,
     CS_QUANTITY                  bigint,
     CS_WHOLESALE_COST            numeric(7,2),
     CS_LIST_PRICE                numeric(7,2),
     CS_SALES_PRICE               numeric(7,2),
     CS_EXT_DISCOUNT_AMT          numeric(7,2),
     CS_EXT_SALES_PRICE           numeric(7,2),
     CS_EXT_WHOLESALE_COST        numeric(7,2),
     CS_EXT_LIST_PRICE            numeric(7,2),
     CS_EXT_TAX                   numeric(7,2),
     CS_COUPON_AMT                numeric(7,2),
     CS_EXT_SHIP_COST             numeric(7,2),
     CS_NET_PAID                  numeric(7,2),
     CS_NET_PAID_INC_TAX          numeric(7,2),
     CS_NET_PAID_INC_SHIP         numeric(7,2),
     CS_NET_PAID_INC_SHIP_TAX     numeric(7,2),
     CS_NET_PROFIT                numeric(7,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  CATALOG_SALES
ALTER TABLE CATALOG_SALES ADD PRIMARY KEY (CS_ITEM_SK, CS_ORDER_NUMBER);

\echo
\echo *****  Creating table:  "CHAR_TEST"

CREATE TABLE  CHAR_TEST
(
     ASCII_VALUE                  character(1),
     CHARACTER_STRING             character varying(100),
     DECIMAL_VALUE                integer,
     OCTAL_VALUE                  character(3),
     HEXADECIMAL_VALUE            character(2),
     DISTRIBUTION_COLUMN          byteint
)
DISTRIBUTE ON (DISTRIBUTION_COLUMN)
;

\echo
\echo *****  Creating table:  "CUSTOMER"

CREATE TABLE  CUSTOMER
(
     "C_CUSTOMER_SK"              bigint                    not null,
     "C_CUSTOMER_ID"              character(16)             not null,
     "C_CURRENT_CDEMO_SK"         bigint,
     "C_CURRENT_HDEMO_SK"         bigint,
     "C_CURRENT_ADDR_SK"          bigint,
     "C_FIRST_SHIPTO_DATE_SK"     bigint,
     "C_FIRST_SALES_DATE_SK"      bigint,
     "C_SALUTATION"               character(10),
     "C_FIRST_NAME"               character varying(20),
     "C_LAST_NAME"                character varying(30),
     "C_PREFERRED_CUST_FLAG"      character(1),
     "C_BIRTH_DAY"                bigint,
     "C_BIRTH_MONTH"              bigint,
     "C_BIRTH_YEAR"               bigint,
     "C_BIRTH_COUNTRY"            character varying(20),
     "C_LOGIN"                    character(13),
     "C_EMAIL_ADDRESS"            character(50),
     "C_LAST_REVIEW_DATE"         character(10)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  CUSTOMER
ALTER TABLE CUSTOMER ADD PRIMARY KEY ("C_CUSTOMER_SK");

\echo
\echo *****  Creating table:  "CUSTOMER_ADDRESS"

CREATE TABLE  CUSTOMER_ADDRESS
(
     CA_ADDRESS_SK                bigint                    not null,
     CA_ADDRESS_ID                character(16)             not null,
     CA_STREET_NUMBER             character(10),
     CA_STREET_NAME               character varying(60),
     CA_STREET_TYPE               character(15),
     CA_SUITE_NUMBER              character(10),
     CA_CITY                      character varying(60)     not null,
     CA_COUNTY                    character varying(30)     not null,
     CA_STATE                     character(2)              not null,
     CA_ZIP                       character(10)             not null,
     CA_COUNTRY                   character varying(20)     not null,
     CA_GMT_OFFSET                numeric(5,2),
     CA_LOCATION_TYPE             character(20)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  CUSTOMER_ADDRESS
ALTER TABLE CUSTOMER_ADDRESS ADD PRIMARY KEY (CA_ADDRESS_SK);

\echo
\echo *****  Creating table:  "CUSTOMER_DEMOGRAPHICS"

CREATE TABLE  CUSTOMER_DEMOGRAPHICS
(
     CD_DEMO_SK                   bigint                    not null,
     CD_GENDER                    character(1),
     CD_MARITAL_STATUS            character(1),
     CD_EDUCATION_STATUS          character(20),
     CD_PURCHASE_ESTIMATE         bigint,
     CD_CREDIT_RATING             character(10),
     CD_DEP_COUNT                 bigint,
     CD_DEP_EMPLOYED_COUNT        bigint,
     CD_DEP_COLLEGE_COUNT         bigint
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  CUSTOMER_DEMOGRAPHICS
ALTER TABLE CUSTOMER_DEMOGRAPHICS ADD PRIMARY KEY (CD_DEMO_SK);

\echo
\echo *****  Creating table:  "DATE_DIM"

CREATE TABLE  DATE_DIM
(
     "D_DATE_SK"                  bigint                    not null,
     "D_DATE_ID"                  character(16)             not null,
     "D_DATE"                     date                      not null,
     "D_MONTH_SEQ"                bigint                    not null,
     "D_WEEK_SEQ"                 bigint                    not null,
     "D_QUARTER_SEQ"              bigint                    not null,
     "D_YEAR"                     bigint                    not null,
     "D_DOW"                      bigint                    not null,
     "D_MOY"                      bigint                    not null,
     "D_DOM"                      bigint                    not null,
     "D_QOY"                      bigint                    not null,
     "D_FY_YEAR"                  bigint,
     "D_FY_QUARTER_SEQ"           bigint,
     "D_FY_WEEK_SEQ"              bigint,
     "D_DAY_NAME"                 character(9),
     "D_QUARTER_NAME"             character(6),
     "D_HOLIDAY"                  character(1),
     "D_WEEKEND"                  character(1),
     "D_FOLLOWING_HOLIDAY"        character(1),
     "D_FIRST_DOM"                bigint,
     "D_LAST_DOM"                 bigint,
     "D_SAME_DAY_LY"              bigint,
     "D_SAME_DAY_LQ"              bigint,
     "D_CURRENT_DAY"              character(1),
     "D_CURRENT_WEEK"             character(1),
     "D_CURRENT_MONTH"            character(1),
     "D_CURRENT_QUARTER"          character(1),
     "D_CURRENT_YEAR"             character(1)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  DATE_DIM
ALTER TABLE DATE_DIM ADD PRIMARY KEY ("D_DATE_SK");

\echo
\echo *****  Creating table:  "HOUSEHOLD_DEMOGRAPHICS"

CREATE TABLE  HOUSEHOLD_DEMOGRAPHICS
(
     HD_DEMO_SK                   bigint                    not null,
     HD_INCOME_BAND_SK            bigint,
     HD_BUY_POTENTIAL             character(15)             not null,
     HD_DEP_COUNT                 bigint                    not null,
     HD_VEHICLE_COUNT             bigint                    not null
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  HOUSEHOLD_DEMOGRAPHICS
ALTER TABLE HOUSEHOLD_DEMOGRAPHICS ADD PRIMARY KEY (HD_DEMO_SK);

\echo
\echo *****  Creating table:  "INCOME_BAND"

CREATE TABLE  INCOME_BAND
(
     IB_INCOME_BAND_SK            bigint                    not null,
     IB_LOWER_BOUND               bigint,
     IB_UPPER_BOUND               bigint
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  INCOME_BAND
ALTER TABLE INCOME_BAND ADD PRIMARY KEY (IB_INCOME_BAND_SK);

\echo
\echo *****  Creating table:  "INVENTORY"

CREATE TABLE  INVENTORY
(
     INV_DATE_SK                  bigint                    not null,
     INV_ITEM_SK                  bigint                    not null,
     INV_WAREHOUSE_SK             bigint                    not null,
     INV_QUANTITY_ON_HAND         bigint
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  INVENTORY
ALTER TABLE INVENTORY ADD PRIMARY KEY (INV_DATE_SK, INV_ITEM_SK, INV_WAREHOUSE_SK);

\echo
\echo *****  Creating table:  "ITEM"

CREATE TABLE  ITEM
(
     "I_ITEM_SK"                  bigint                    not null,
     "I_ITEM_ID"                  character(16)             not null,
     "I_REC_START_DATE"           date,
     "I_REC_END_DATE"             date,
     "I_ITEM_DESC"                character varying(200)    not null,
     "I_CURRENT_PRICE"            numeric(7,2),
     "I_WHOLESALE_COST"           numeric(7,2),
     "I_BRAND_ID"                 bigint                    not null,
     "I_BRAND"                    character varying(50)     not null,
     "I_CLASS_ID"                 bigint                    not null,
     "I_CLASS"                    character varying(50)     not null,
     "I_CATEGORY_ID"              bigint                    not null,
     "I_CATEGORY"                 character varying(50)     not null,
     "I_MANUFACT_ID"              bigint                    not null,
     "I_MANUFACT"                 character(50)             not null,
     "I_SIZE"                     character(20),
     "I_FORMULATION"              character(20),
     "I_COLOR"                    character(20),
     "I_UNITS"                    character(10),
     "I_CONTAINER"                character(10),
     "I_MANAGER_ID"               bigint                    not null,
     "I_PRODUCT_NAME"             character(50)             not null
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  ITEM
ALTER TABLE ITEM ADD PRIMARY KEY ("I_ITEM_SK");

\echo
\echo *****  Creating table:  "PROMOTION"

CREATE TABLE  PROMOTION
(
     "P_PROMO_SK"                 bigint                    not null,
     "P_PROMO_ID"                 character(16)             not null,
     "P_START_DATE_SK"            bigint,
     "P_END_DATE_SK"              bigint,
     "P_ITEM_SK"                  bigint,
     "P_COST"                     numeric(15,2),
     "P_RESPONSE_TARGET"          bigint,
     "P_PROMO_NAME"               character(50),
     "P_CHANNEL_DMAIL"            character(1),
     "P_CHANNEL_EMAIL"            character(1),
     "P_CHANNEL_CATALOG"          character(1),
     "P_CHANNEL_TV"               character(1),
     "P_CHANNEL_RADIO"            character(1),
     "P_CHANNEL_PRESS"            character(1),
     "P_CHANNEL_EVENT"            character(1),
     "P_CHANNEL_DEMO"             character(1),
     "P_CHANNEL_DETAILS"          character varying(100),
     "P_PURPOSE"                  character(15),
     "P_DISCOUNT_ACTIVE"          character(1)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  PROMOTION
ALTER TABLE PROMOTION ADD PRIMARY KEY ("P_PROMO_SK");

\echo
\echo *****  Creating table:  "REASON"

CREATE TABLE  REASON
(
     R_REASON_SK                  bigint                    not null,
     R_REASON_ID                  character(16)             not null,
     R_REASON_DESC                character(100)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  REASON
ALTER TABLE REASON ADD PRIMARY KEY (R_REASON_SK);

\echo
\echo *****  Creating table:  "SHIP_MODE"

CREATE TABLE  SHIP_MODE
(
     SM_SHIP_MODE_SK              bigint                    not null,
     SM_SHIP_MODE_ID              character(16)             not null,
     SM_TYPE                      character(30),
     SM_CODE                      character(10),
     SM_CARRIER                   character(20),
     SM_CONTRACT                  character(20)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  SHIP_MODE
ALTER TABLE SHIP_MODE ADD PRIMARY KEY (SM_SHIP_MODE_SK);

\echo
\echo *****  Creating table:  "STORE"

CREATE TABLE  STORE
(
     "S_STORE_SK"                 bigint                    not null,
     "S_STORE_ID"                 character(16)             not null,
     "S_REC_START_DATE"           date,
     "S_REC_END_DATE"             date,
     "S_CLOSED_DATE_SK"           bigint,
     "S_STORE_NAME"               character varying(50)     not null,
     "S_NUMBER_EMPLOYEES"         bigint,
     "S_FLOOR_SPACE"              bigint,
     "S_HOURS"                    character(20),
     "S_MANAGER"                  character varying(40)     not null,
     "S_MARKET_ID"                bigint                    not null,
     "S_GEOGRAPHY_CLASS"          character varying(100)    not null,
     "S_MARKET_DESC"              character varying(100)    not null,
     "S_MARKET_MANAGER"           character varying(40)     not null,
     "S_DIVISION_ID"              bigint                    not null,
     "S_DIVISION_NAME"            character varying(50)     not null,
     "S_COMPANY_ID"               bigint                    not null,
     "S_COMPANY_NAME"             character varying(50)     not null,
     "S_STREET_NUMBER"            character varying(10),
     "S_STREET_NAME"              character varying(60),
     "S_STREET_TYPE"              character(15),
     "S_SUITE_NUMBER"             character(10),
     "S_CITY"                     character varying(60)              not null,
     "S_COUNTY"                   character varying(30)              not null,
     "S_STATE"                    character(2)                       not null,
     "S_ZIP"                      character(10)                      not null,
     "S_COUNTRY"                  character varying(20)              not null,
     "S_GMT_OFFSET"               numeric(5,2),
     "S_TAX_PERCENTAGE"           numeric(5,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  STORE
ALTER TABLE STORE ADD PRIMARY KEY ("S_STORE_SK");

\echo
\echo *****  Creating table:  "STORE_RETURNS"

CREATE TABLE  STORE_RETURNS
(
     SR_RETURNED_DATE_SK          bigint,
     SR_RETURN_TIME_SK            bigint,
     SR_ITEM_SK                   bigint                             not null,
     SR_CUSTOMER_SK               bigint,
     SR_CDEMO_SK                  bigint,
     SR_HDEMO_SK                  bigint,
     SR_ADDR_SK                   bigint,
     SR_STORE_SK                  bigint,
     SR_REASON_SK                 bigint,
     SR_TICKET_NUMBER             bigint                             not null,
     SR_RETURN_QUANTITY           bigint,
     SR_RETURN_AMT                numeric(7,2),
     SR_RETURN_TAX                numeric(7,2),
     SR_RETURN_AMT_INC_TAX        numeric(7,2),
     SR_FEE                       numeric(7,2),
     SR_RETURN_SHIP_COST          numeric(7,2),
     SR_REFUNDED_CASH             numeric(7,2),
     SR_REVERSED_CHARGE           numeric(7,2),
     SR_STORE_CREDIT              numeric(7,2),
     SR_NET_LOSS                  numeric(7,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  STORE_RETURNS
ALTER TABLE STORE_RETURNS ADD PRIMARY KEY (SR_ITEM_SK, SR_TICKET_NUMBER);

\echo
\echo *****  Creating table:  "STORE_SALES"

CREATE TABLE  "STORE_SALES"
(
     "SS_SOLD_DATE_SK"            bigint                             not null,
     "SS_SOLD_TIME_SK"            bigint                             not null,
     "SS_ITEM_SK"                 bigint                             not null,
     "SS_CUSTOMER_SK"             bigint                             not null,
     "SS_CDEMO_SK"                bigint                             not null,
     "SS_HDEMO_SK"                bigint                             not null,
     "SS_ADDR_SK"                 bigint                             not null,
     "SS_STORE_SK"                bigint                             not null,
     "SS_PROMO_SK"                bigint                             not null,
     "SS_TICKET_NUMBER"           bigint                             not null,
     "SS_QUANTITY"                bigint,
     "SS_WHOLESALE_COST"          numeric(7,2),
     "SS_LIST_PRICE"              numeric(7,2),
     "SS_SALES_PRICE"             numeric(7,2),
     "SS_EXT_DISCOUNT_AMT"        numeric(7,2),
     "SS_EXT_SALES_PRICE"         numeric(7,2),
     "SS_EXT_WHOLESALE_COST"      numeric(7,2),
     "SS_EXT_LIST_PRICE"          numeric(7,2),
     "SS_EXT_TAX"                 numeric(7,2),
     "SS_COUPON_AMT"              numeric(7,2),
     "SS_NET_PAID"                numeric(7,2),
     "SS_NET_PAID_INC_TAX"        numeric(7,2),
     "SS_NET_PROFIT"              numeric(7,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  STORE_SALES
ALTER TABLE "STORE_SALES" ADD PRIMARY KEY ("SS_ITEM_SK", "SS_TICKET_NUMBER");

\echo
\echo *****  Creating table:  "TIME_DIM"

CREATE TABLE  TIME_DIM
(
     T_TIME_SK                    bigint                             not null,
     T_TIME_ID                    character(16)                      not null,
     T_TIME                       bigint                             not null,
     T_HOUR                       bigint                             not null,
     T_MINUTE                     bigint                             not null,
     T_SECOND                     bigint                             not null,
     T_AM_PM                      character(2)                       not null,
     T_SHIFT                      character(20)                      not null,
     T_SUB_SHIFT                  character(20)                      not null,
     T_MEAL_TIME                  character(20)                      not null
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  TIME_DIM
ALTER TABLE TIME_DIM ADD PRIMARY KEY (T_TIME_SK);

\echo
\echo *****  Creating table:  "UTF8_TEST"

CREATE TABLE  UTF8_TEST
(
     BASE_LANGUAGE                character varying(50),
     SAMPLE_STRING                national character varying(200),
     DISTRIBUTION_COLUMN          integer
)
DISTRIBUTE ON (DISTRIBUTION_COLUMN)
;

\echo
\echo *****  Creating table:  "WAREHOUSE"

CREATE TABLE  WAREHOUSE
(
     W_WAREHOUSE_SK               bigint                             not null,
     W_WAREHOUSE_ID               character(16)                      not null,
     W_WAREHOUSE_NAME             character varying(20),
     W_WAREHOUSE_SQ_FT            bigint,
     W_STREET_NUMBER              character(10),
     W_STREET_NAME                character varying(60),
     W_STREET_TYPE                character(15),
     W_SUITE_NUMBER               character(10),
     W_CITY                       character varying(60),
     W_COUNTY                     character varying(30),
     W_STATE                      character(2),
     W_ZIP                        character(10),
     W_COUNTRY                    character varying(20),
     W_GMT_OFFSET                 numeric(5,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  WAREHOUSE
ALTER TABLE WAREHOUSE ADD PRIMARY KEY (W_WAREHOUSE_SK);

\echo
\echo *****  Creating table:  "WEB_PAGE"

CREATE TABLE  WEB_PAGE
(
     WP_WEB_PAGE_SK               bigint                             not null,
     WP_WEB_PAGE_ID               character(16)                      not null,
     WP_REC_START_DATE            date,
     WP_REC_END_DATE              date,
     WP_CREATION_DATE_SK          bigint,
     WP_ACCESS_DATE_SK            bigint,
     WP_AUTOGEN_FLAG              character(1),
     WP_CUSTOMER_SK               bigint,
     WP_URL                       character varying(100),
     WP_TYPE                      character(50),
     WP_CHAR_COUNT                bigint,
     WP_LINK_COUNT                bigint,
     WP_IMAGE_COUNT               bigint,
     WP_MAX_AD_COUNT              bigint
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  WEB_PAGE
ALTER TABLE WEB_PAGE ADD PRIMARY KEY (WP_WEB_PAGE_SK);

\echo
\echo *****  Creating table:  "WEB_RETURNS"

CREATE TABLE  WEB_RETURNS
(
     WR_RETURNED_DATE_SK          bigint,
     WR_RETURNED_TIME_SK          bigint,
     WR_ITEM_SK                   bigint                             not null,
     WR_REFUNDED_CUSTOMER_SK      bigint,
     WR_REFUNDED_CDEMO_SK         bigint,
     WR_REFUNDED_HDEMO_SK         bigint,
     WR_REFUNDED_ADDR_SK          bigint,
     WR_RETURNING_CUSTOMER_SK     bigint,
     WR_RETURNING_CDEMO_SK        bigint,
     WR_RETURNING_HDEMO_SK        bigint,
     WR_RETURNING_ADDR_SK         bigint,
     WR_WEB_PAGE_SK               bigint,
     WR_REASON_SK                 bigint,
     WR_ORDER_NUMBER              bigint                             not null,
     WR_RETURN_QUANTITY           bigint,
     WR_RETURN_AMT                numeric(7,2),
     WR_RETURN_TAX                numeric(7,2),
     WR_RETURN_AMT_INC_TAX        numeric(7,2),
     WR_FEE                       numeric(7,2),
     WR_RETURN_SHIP_COST          numeric(7,2),
     WR_REFUNDED_CASH             numeric(7,2),
     WR_REVERSED_CHARGE           numeric(7,2),
     WR_ACCOUNT_CREDIT            numeric(7,2),
     WR_NET_LOSS                  numeric(7,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  WEB_RETURNS
ALTER TABLE WEB_RETURNS ADD PRIMARY KEY (WR_ITEM_SK, WR_ORDER_NUMBER);

\echo
\echo *****  Creating table:  "WEB_SALES"

CREATE TABLE  WEB_SALES
(
     WS_SOLD_DATE_SK              bigint,
     WS_SOLD_TIME_SK              bigint,
     WS_SHIP_DATE_SK              bigint,
     WS_ITEM_SK                   bigint                             not null,
     WS_BILL_CUSTOMER_SK          bigint,
     WS_BILL_CDEMO_SK             bigint,
     WS_BILL_HDEMO_SK             bigint,
     WS_BILL_ADDR_SK              bigint,
     WS_SHIP_CUSTOMER_SK          bigint,
     WS_SHIP_CDEMO_SK             bigint,
     WS_SHIP_HDEMO_SK             bigint,
     WS_SHIP_ADDR_SK              bigint,
     WS_WEB_PAGE_SK               bigint,
     WS_WEB_SITE_SK               bigint,
     WS_SHIP_MODE_SK              bigint,
     WS_WAREHOUSE_SK              bigint,
     WS_PROMO_SK                  bigint,
     WS_ORDER_NUMBER              bigint                             not null,
     WS_QUANTITY                  bigint,
     WS_WHOLESALE_COST            numeric(7,2),
     WS_LIST_PRICE                numeric(7,2),
     WS_SALES_PRICE               numeric(7,2),
     WS_EXT_DISCOUNT_AMT          numeric(7,2),
     WS_EXT_SALES_PRICE           numeric(7,2),
     WS_EXT_WHOLESALE_COST        numeric(7,2),
     WS_EXT_LIST_PRICE            numeric(7,2),
     WS_EXT_TAX                   numeric(7,2),
     WS_COUPON_AMT                numeric(7,2),
     WS_EXT_SHIP_COST             numeric(7,2),
     WS_NET_PAID                  numeric(7,2),
     WS_NET_PAID_INC_TAX          numeric(7,2),
     WS_NET_PAID_INC_SHIP         numeric(7,2),
     WS_NET_PAID_INC_SHIP_TAX     numeric(7,2),
     WS_NET_PROFIT                numeric(7,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  WEB_SALES
ALTER TABLE WEB_SALES ADD PRIMARY KEY (WS_ITEM_SK, WS_ORDER_NUMBER);

\echo
\echo *****  Creating table:  "WEB_SITE"

CREATE TABLE  WEB_SITE
(
     WEB_SITE_SK                  bigint                             not null,
     WEB_SITE_ID                  character(16)                      not null,
     WEB_REC_START_DATE           date,
     WEB_REC_END_DATE             date,
     WEB_NAME                     character varying(50),
     WEB_OPEN_DATE_SK             bigint,
     WEB_CLOSE_DATE_SK            bigint,
     WEB_CLASS                    character varying(50),
     WEB_MANAGER                  character varying(40),
     WEB_MKT_ID                   bigint,
     WEB_MKT_CLASS                character varying(50),
     WEB_MKT_DESC                 character varying(100),
     WEB_MARKET_MANAGER           character varying(40),
     WEB_COMPANY_ID               bigint,
     WEB_COMPANY_NAME             character(50),
     WEB_STREET_NUMBER            character(10),
     WEB_STREET_NAME              character varying(60),
     WEB_STREET_TYPE              character(15),
     WEB_SUITE_NUMBER             character(10),
     WEB_CITY                     character varying(60),
     WEB_COUNTY                   character varying(30),
     WEB_STATE                    character(2),
     WEB_ZIP                      character(10),
     WEB_COUNTRY                  character varying(20),
     WEB_GMT_OFFSET               numeric(5,2),
     WEB_TAX_PERCENTAGE           numeric(5,2)
)
DISTRIBUTE ON RANDOM
;

\echo
\echo *****  Adding Primary Key Constraint:  WEB_SITE
ALTER TABLE WEB_SITE ADD PRIMARY KEY (WEB_SITE_SK);

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_RETURNS  (referencing CALL_CENTER)
ALTER TABLE CATALOG_RETURNS ADD Constraint "FK12" FOREIGN KEY (CR_CALL_CENTER_SK) REFERENCES CALL_CENTER (CC_CALL_CENTER_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_RETURNS  (referencing CATALOG_PAGE)
ALTER TABLE CATALOG_RETURNS ADD Constraint "FK13" FOREIGN KEY (CR_CATALOG_PAGE_SK) REFERENCES CATALOG_PAGE (CP_CATALOG_PAGE_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_RETURNS  (referencing CUSTOMER_ADDRESS)
ALTER TABLE CATALOG_RETURNS ADD Constraint "FK11" FOREIGN KEY (CR_RETURNING_ADDR_SK) REFERENCES CUSTOMER_ADDRESS (CA_ADDRESS_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_RETURNS  (referencing HOUSEHOLD_DEMOGRAPHICS)
ALTER TABLE CATALOG_RETURNS ADD Constraint "FK10" FOREIGN KEY (CR_RETURNING_HDEMO_SK) REFERENCES HOUSEHOLD_DEMOGRAPHICS (HD_DEMO_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_RETURNS  (referencing REASON)
ALTER TABLE CATALOG_RETURNS ADD Constraint "FK16" FOREIGN KEY (CR_REASON_SK) REFERENCES REASON (R_REASON_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_RETURNS  (referencing SHIP_MODE)
ALTER TABLE CATALOG_RETURNS ADD Constraint "FK14" FOREIGN KEY (CR_SHIP_MODE_SK) REFERENCES SHIP_MODE (SM_SHIP_MODE_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_RETURNS  (referencing WAREHOUSE)
ALTER TABLE CATALOG_RETURNS ADD Constraint "FK15" FOREIGN KEY (CR_WAREHOUSE_SK) REFERENCES WAREHOUSE (W_WAREHOUSE_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_SALES  (referencing ITEM)
ALTER TABLE CATALOG_SALES ADD Constraint "FK16A" FOREIGN KEY (CS_ITEM_SK) REFERENCES ITEM ("I_ITEM_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  CATALOG_SALES  (referencing PROMOTION)
ALTER TABLE CATALOG_SALES ADD Constraint "FK17" FOREIGN KEY (CS_PROMO_SK) REFERENCES PROMOTION ("P_PROMO_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  CUSTOMER  (referencing CUSTOMER_ADDRESS)
ALTER TABLE CUSTOMER ADD Constraint "FK3" FOREIGN KEY ("C_CURRENT_ADDR_SK") REFERENCES CUSTOMER_ADDRESS (CA_ADDRESS_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CUSTOMER  (referencing CUSTOMER_DEMOGRAPHICS)
ALTER TABLE CUSTOMER ADD Constraint "FK1" FOREIGN KEY ("C_CURRENT_CDEMO_SK") REFERENCES CUSTOMER_DEMOGRAPHICS (CD_DEMO_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  CUSTOMER  (referencing DATE_DIM)
ALTER TABLE CUSTOMER ADD Constraint "FK4" FOREIGN KEY ("C_FIRST_SHIPTO_DATE_SK") REFERENCES DATE_DIM ("D_DATE_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  CUSTOMER  (referencing DATE_DIM)
ALTER TABLE CUSTOMER ADD Constraint "FK5" FOREIGN KEY ("C_FIRST_SALES_DATE_SK") REFERENCES DATE_DIM ("D_DATE_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  CUSTOMER  (referencing HOUSEHOLD_DEMOGRAPHICS)
ALTER TABLE CUSTOMER ADD Constraint "FK2" FOREIGN KEY ("C_CURRENT_HDEMO_SK") REFERENCES HOUSEHOLD_DEMOGRAPHICS (HD_DEMO_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  STORE  (referencing DATE_DIM)
ALTER TABLE STORE ADD Constraint "FK" FOREIGN KEY ("S_CLOSED_DATE_SK") REFERENCES DATE_DIM ("D_DATE_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  STORE_SALES  (referencing CUSTOMER_ADDRESS)
ALTER TABLE "STORE_SALES" ADD Constraint "FK7" FOREIGN KEY ("SS_ADDR_SK") REFERENCES CUSTOMER_ADDRESS (CA_ADDRESS_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  STORE_SALES  (referencing HOUSEHOLD_DEMOGRAPHICS)
ALTER TABLE "STORE_SALES" ADD Constraint "FK6" FOREIGN KEY ("SS_HDEMO_SK") REFERENCES HOUSEHOLD_DEMOGRAPHICS (HD_DEMO_SK) ;

\echo
\echo *****  Adding Foreign Key Constraint:  STORE_SALES  (referencing ITEM)
ALTER TABLE "STORE_SALES" ADD Constraint "FK3A" FOREIGN KEY ("SS_ITEM_SK") REFERENCES ITEM ("I_ITEM_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  STORE_SALES  (referencing PROMOTION)
ALTER TABLE "STORE_SALES" ADD Constraint "FK9" FOREIGN KEY ("SS_PROMO_SK") REFERENCES PROMOTION ("P_PROMO_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  STORE_SALES  (referencing STORE)
ALTER TABLE "STORE_SALES" ADD Constraint "FK8" FOREIGN KEY ("SS_STORE_SK") REFERENCES STORE ("S_STORE_SK") ;

\echo
\echo *****  Adding Foreign Key Constraint:  WEB_SALES  (referencing ITEM)
ALTER TABLE WEB_SALES ADD Constraint "FK4A" FOREIGN KEY (WS_ITEM_SK) REFERENCES ITEM ("I_ITEM_SK") ;

\echo
\echo *****  Adding comments to objects

\echo
\echo *****  Grant privileges on objects to users

\echo
\echo *****  Grant privileges on objects to users (WITH grant option)

\echo
\echo *****  Grant admin privileges to users

\echo
\echo *****  Grant admin privileges to users (WITH grant option)

\echo
\echo *****  Grant privileges on objects to groups

\echo
\echo *****  Grant privileges on objects to groups (WITH grant option)

\echo
\echo *****  Grant admin privileges to groups

\echo
\echo *****  Grant admin privileges to groups (WITH grant option)

\echo
\echo *****  Changing owner of SCHEMA "BDINSIGHTS" to "DAHANCOC"
ALTER SCHEMA    BDINSIGHTS AUTHORIZATION TO DAHANCOC ;

\echo
\echo *****  Changing owner of DATABASE "BDI00" to "DAHANCOC"
ALTER DATABASE       BDI00 OWNER TO DAHANCOC ;
