# Lab Narrative

ABC Retailer has been running a success Business Intelligence workload on a PureData for Analytics N1001-010 system since January 2012.  The customer is aware that IBM will [end of support](https://www-01.ibm.com/software/support/lifecycleapp/PLCDetail.wss?q45=F614185R84192X59) on June 30, 2019 for PDA N1001 systems.  The customer has plans to expand the current workload to include analytics and machine learning.  However, their current needs are to migrate their production workload to a system that will supported beyond June 30, 2019 and be expandable to support new workload and data.  This activity has casued the customer to look at other vendor solutions.  This retailer has decided to keep the system on-premise and utilize an appliance offering for production.  The customer was open to host their developmemnt environment on non-appliance systems.  However, the customer wanted a small appliance for firmware and other upgrade testing.

A Request for Proposal (RFP) has been issued to several vendors.  Based on the results of the RFP IBM was selected to perform an on-premise Proof of Concept (POC) with the IBM Integrated Analytics System N4001-010 (full rack).  Two other vendors have been selected, Oracle and Teradata.

## IBM Proposed solutions:  
 > * Production: M4001-010 (POC System)
 > * Test: M4001-003
 > * Development: Db2 Warehouse deployed on customer VMware ESXi.

The POC will focus on the customer's retail database with in-store, on-line, and catalog sales of merchandise,

There are three types of users represented in the workload:
* Returns dashboard analysts
* These analysts are investigating the rates of return and impact on the bottom line of the business
* Sales report analysts
* These analysts are generating sales reports to understand the profitability of their retail enterprise
* (Deep-dive analysts (data scientist)

These analysts are hand-crafting deep-dive analysis to answer questions identified by the returns dashboards and sales report analysts.

Queries were inspired by:
* Cognos10-generated SQL for dashboards and reports
* Cognos10-generated SQL for in-memory dynamic cubes
* Industry standard benchmark queries

Each query was categorized into the three types of users
* Returns dashboard analysts = simple queries with narrow range of data, may not hit fact table
  * Runtime range sub-second to 1s
  * Source: 71% Cognos dashboards, 29% benchmark standard

* Sales report analysts = intermediate complexity with broader range of data
  * Runtime range up to 1min
  * Source: 40% Cognos reports, 56% benchmark standard, 4% dynamic cube

* Data scientist = most complex SQL with large/full range of data
  * Runtime range 10s of minutes
  * Source: 80% benchmark standard, 20% dynamic cube

### BIDay3 Schema and Query Coverage

* BIDay3 has a multi-fact table retail database
  * 7 fact tables: store sales, store returns, catalog sales, catalog returns, web sales, web returns, and inventory
  * 17 dimension tables
  * 2 Mystery tables

* Database 10 TB of raw data 
  > (lab exercise: only 5GB load into source system)

* All tables in the schema are accessed by the workload
  * Only *_RETURNS and INVENTORY fact tables are accessed by simple return dashboard queries
