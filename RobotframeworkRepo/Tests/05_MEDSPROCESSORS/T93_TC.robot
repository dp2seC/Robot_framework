*** Settings ***
Documentation  Executing scenarios in MIXD_Error&Warnings_List.xlsx [https://drive.google.com/open?id=1JpmK8nCbyqxlYWwRBMnUQ0uYgnIPiY05]
Resource  ../../Resources/Common/medsprocessor_common.robot
Resource  ../../Resources/Common/medsprocessor_errors_and_warnings.robot
Resource  ../../Resources/Common/medsprocessor_LocatorVariables.robot

Suite Setup  Begin Web Test
Suite Teardown  End Web test
Test Setup  Test Start
Test Teardown  Test End

Test Template  Uploading different types of file

# Copy/paste any of the below line to Terminal window to execute
# robot -d Results/MEDSPROCESSOR_Results Tests/05_MEDSPROCESSORS/T93_TC.robot


*** Test Cases ***                              filename
Test for a file with no site details            ${ImportFilePath}/LB-NoSite_${Date}.csv
Test for a Valid file                           ${ImportFilePath}/LB-Valid_${Date}.csv
#Test for a non CSV File                         ${ImportFilePath}/LB-NONCSV
#Test for a file with wrong site                 ${ImportFilePath}/LB-WrongSite_${Date}.csv
#Test for an Empty file                          ${ImportFilePath}/LB-Empty_${Date}.csv
#Test for a file with additional header          ${ImportFilePath}/LB-AdditionalHeader_${Date}.csv


*** Keywords ***
Uploading different types of file
    [Arguments]  ${filename}
    Navigate to MEDS Ingestor App
    Choose Import Job
    Click on "Import New Data" button  ${filename}
    Capture import status from UI  
    Capture import status from DB and write to CSV

