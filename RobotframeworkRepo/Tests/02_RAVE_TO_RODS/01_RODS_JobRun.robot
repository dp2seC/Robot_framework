*** Settings ***
Resource  ../../setting_references.robot
Library  Collections
Library  String
Suite Setup  Run Keywords  Connect to  RAVE 
...                  AND  Connect to  RODS MASTER  
Suite Teardown  Run Keywords  DB Disconnect  RAVE  
...                     AND  DB Disconnect  RODS MASTER
Test Teardown  Set Common Status

# Command: robot -d Results/Data_Preparation_Results Tests/02_RAVE_TO_RODS/01_RODS_JobRun.robot
# Command: robot --removekeywords WUKS -d Results/Data_Preparation_Results Tests/Tests/02_RAVE_TO_RODS/01_RODS_JobRun.robot


*** Test Cases ***

Verify CDCStaging sync
    Run Keyword IF  ${common_status}
    ...  Run Keywords  Data sync between Rave and CDC
    
Trigger RODS job
    Run Keyword IF  ${common_status}
    ...   Run Keywords  Verify Status For  REFRESH  5x  8 min
    ...   AND  Set Last Processed Date to null
    ...   AND  Verify Status For  REFRESHQUEUE  8x  5 min
    ...   AND  Verify Status For  REFRESH  5x  10 min