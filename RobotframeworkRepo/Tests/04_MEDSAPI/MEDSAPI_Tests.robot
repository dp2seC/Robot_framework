***Settings***
Documentation  This test case is defined to test all the MEDS API endpoints for 200,404 and 422 scenarios.
...            All the Meds API and SiM/iM endpoints have been included in the test. The endpoints are listed in the Input file accordingly.

Force Tags  Sanity
Library  DataDriver  ../../EX_Files/API/InputAPIEndpoints.xlsx   sheet_name=Sheet1
Resource  ../../Resources/User_Keywords/MEDSAPI.robot
Resource  ../../Resources/Common/kw_common_DB.robot
Resource  ../../Resources/Common/uv_common.robot
Suite Setup  Run Keywords  Connect to  MW  
...                   AND  Connect to  MEDS  
Suite Teardown  Run Keywords  DB Disconnect  MW  
...                      AND  DB Disconnect  MEDS
Resource  ../../Resources/Common/db_connection_strings.robot
Resource  ../../Resources/DB/MEDSAPI_Validations.robot
Resource  ../../Resources/API/MEDSAPI_Validations.robot
Test Template  Test Scenarios

# robot -d Results/MEDSAPI_Results Tests/MEDSAPI

***Test Cases***

Verifing Endpoints for Valid and Invalid User

***Keywords***

Test Scenarios 
    [Arguments]        ${validinputURL}  ${validinputheader}   ${invalidinputheader}  ${invalidinputURL}  ${Base_URL}   ${EndpointName}  ${Queryvalue}
    For Valid User     ${validinputURL}  ${validinputheader}      ${Base_URL}   ${EndpointName}   ${Queryvalue}
    For Invalid User   ${validinputURL}  ${invalidinputheader}    ${Base_URL}   ${EndpointName}   ${Queryvalue}
    For Invalid URL    ${invalidinputURL}  ${validinputheader}    ${Base_URL}   ${EndpointName}   ${Queryvalue}