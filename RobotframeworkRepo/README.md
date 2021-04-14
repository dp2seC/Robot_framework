# MEDS Services - E2E Automation
Using [RobotFramework](https://robotframework.org/), performing E2E data validation from RAVE to RODS to MEDS and to MWarehouse and MEDS-API

## Introduction
Robot test automation framework for MEDS Services which provides value on data quality tests,\
    Data Completeness- Identifying missing/duplicates\
    Data Transformation- Lookup transformation logic\
    Data Consistency- Stable incremental loads\
    Data Accuracy- Reconciliation of source vs target\
    Interpretability- Identifying data domain using significant column names. For eg: RODS_UUID, MEDS_UUID,mWarehouse_key 

## Installation
[mssql](https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server?view=sql-server-ver15)

[mysql](https://pymysql.readthedocs.io/en/latest/user/installation.html)

[oracle](https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html#overview)

[postgresql](https://pypi.org/project/psycopg2/)

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install dependencies.

```bash
pip install -U -r requirements.txt
```

## Usage

```bash
robot -d Results/E2E Tests
```

## Suites
 __01- Data Preparation__
 ```bash
 robot -d Results/Data_Preparation_Results Tests/01_Data_Preparation
 ```
 Create study and site\
 Upload CRF draft\
 Create subjects and clinical data\

 __02- Rave to RODS__
 ```bash
 robot -d Results/Data_Preparation_Results Tests/02_RAVE_TO_RODS/01_RODS_JobRun.robot
 ```
 Verify CDCStaging sync\
 Trigger RODS job\
 Validation of source as RAVE\

 __03- RODS to MEDS__
```bash    
robot -d Results/R2M_Results Tests/03_RODS_TO_MEDS
```
Validation of source as RODS\
Validation of source as MEDS\
Validation of source as IMEDIDATA\
Validation of source as DALTON\
Validation of source as SUBJECTS\

 __04- MEDSAPI__
```bash    
robot -d Results/MEDSAPI_Results Tests/04_MEDSAPI
```
Verifing Endpoints for Valid and Invalid User

__05- MEDSPROCESSOR__

```bash
robot -d Results/MEDSPROCESSOR_Results Tests/05_MEDSPROCESSOR  
