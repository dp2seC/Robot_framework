*** Settings ***
Resource  ../../Resources/Common/kw_common_UI.robot
Resource  ../../Resources/Common/uv_common.robot
Resource  ../../Resources/User_Keywords/Data_Preparation.robot
Resource  ../../path.robot
Suite Setup  Run Keywords  
...          Prepare Test
...          AND  Delete Old CRF
...          AND  Delete Old Screenshots
Suite Teardown  End Test
Test Teardown  Set Common Status

# Command: robot -d Results/Data_Preparation_Results Tests/01_Data_Preparation


*** Test Cases ***
Create study and site? -> ${create_new_study}
     Run Keyword IF  ${create_new_study}
     ...  Run Keywords  Create Study And Site
     ...  AND  Sleep  60s

Upload Draft? -> ${common_status}
     Run Keyword IF  ${common_status}
    ...  Publish CRF for study

Create Subject and input clinical data? -> ${common_status}
    Run Keyword IF  ${common_status}
    ...  Create Subjects


