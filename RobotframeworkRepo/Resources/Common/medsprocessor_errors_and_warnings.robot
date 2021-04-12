*** Settings ***
Resource  ../../Resources/UI/Pages/MEDSProcessor_HomePage.robot
Resource  ../../Resources/UI/Pages/MEDSProcessor_Ingestor.robot

*** Keywords ***
Navigate to MEDS Ingestor App
    Verify user is in Home Page
    Click MEDS Ingestor App link

Choose Import Job
    Verify User is in MEDS Ingestor Page
    Click on job link

Click on "Import New Data" button
    [Arguments]  ${filename}
    Verify user is in Imported Data page
    Using "Import New Data" button choose file to import  ${filename}

Capture import status from UI
    Record the message for the file uploaded

Capture import status from DB and write to CSV
    Record the status from DB
    Write to CSV
