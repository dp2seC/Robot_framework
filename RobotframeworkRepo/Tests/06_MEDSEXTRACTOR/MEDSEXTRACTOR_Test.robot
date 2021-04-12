*** Settings ***
Documentation  EDC raw data E2E robot framework automation suite
Library  SeleniumLibrary
Resource  ../../Resources/User_Keywords/MEDSEXTRACTOR.robot
Test Teardown  Close Browser

*** Test Cases ***
Verify that user can extract Rave EDC data successfully for the existing subject using MEDS Extractor application
    Given User log into Rave EDC
    And navigate to existing subject in Rave EDC
    And navigate to screening Visit form with data for existing subject
    And navigate to Informed Consent form, add data in the form
    And navigate to Subject Randomisation form for existing subject, add data in the form
#    And navigate to Meds Extractor New Export Job Page
#    And create Rave EDC extract with the above datasets
#    And verify that Extract is completed successfully
#    And Verify that Execution is completed successfully in Hercules for the extract
#    And verify that Step function is completed successfully in MAPI for the extract
#    And verify that Extract exists in S3 under MAPI location
#    When User navigate to MEDS Extractor UI and download the extract for the successful job
#    Then user download file from MEDS Extractor
#    And verify that Data extracted successfully for the Subject Randomisation form from MEDS Extractor downloads
#    And verify that Data extracted successfully for the Informed Consent form from MEDS Extractor downloads
#    And verify that Data extracted successfully for the Screening Visit form from MEDS Extractor downloads.
