*** Settings ***


*** Keywords ***
Verify user is in Home Page
    Page Should Contain  ${StudySecHeading} 

Click MEDS Ingestor App link
    Click Link  ${HP_MEDSIngestorAppLink}