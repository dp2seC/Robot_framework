*** Settings ***
Library  ../../Custom_Lib/CRFdraftCreator.py
Library  SeleniumLibrary
Library  String
Library  OperatingSystem
Library  DateTime
Resource  ../UI/Pages/CA_Home.robot
Resource  ../UI/Pages/RAVE_EDC.robot
Resource  ../UI/Pages/RAVE_Architect.robot

*** Keywords ***
Create Study And Site
    Open Medidata and Login
    Navigate to RaveEDC App and Choose Admin Role
    Add New Study
    Add New Site
    Navigate Home and Logout  ${LP_HomeImage}  ${LP_UserSettingsLink}  ${LP_Logout}

Publish CRF for study
    Open Rave Architect and Login
    Navigate to Architect Page
    Navigate to CRF Draft upload Page
    Upload Draft
    Navigate to Architect Page
    Navigate to Project Page
    Publish Draft
    Get CRF VersionID
    Navigate to Architect Page
    Navigate to Project Page
    Push Draft
    Navigate Home and Logout  ${arc_home_link}  ${arc_user_setting_link}  ${arc_logout_link}

Create Subjects
    Open Medidata and Login
    Navigate to RaveEDC App and Choose study_name
    FOR  ${i}  IN RANGE  ${sbj_count}
        ${Date}=  Get Current DateTime 
        Run Keyword And Continue On Failure  Select a study site 
        Add Subject  ${edc_sbj_name}_${Date}_${i}
        Add Clinical Data
    END
    Navigate Home and Logout  ${LP_HomeImage}  ${LP_UserSettingsLink}  ${LP_Logout}

Get Artifacts
    [Arguments]  ${study_name}  ${draft_name}  ${current_draft_path}  ${create_new_study}
    @{artifacts} =  Prepare Draft For Study  ${study_name}  ${draft_name}  ${current_draft_path}  ${create_new_study}
    Run Keyword IF  ${artifacts}[0]
    ...  Run Keywords  Set Suite Variable  ${study_name}  ${artifacts}[1]
    ...  AND  Set Suite Variable  ${site_name}  ${artifacts}[1]
    ...  AND  Set Suite Variable  ${common_status}  True
    ...  AND  Set Suite Variable  ${current_draft}  ${artifacts}[2]
    ...  AND  Set Suite Variable  ${draft_name}  ${artifacts}[3]
    ...  ELSE  Run Keywords  Set Suite Variable  ${common_status}  False
    ...  AND  Fail  ${artifacts}[1]

Delete Old CRF
    ${status} =  Run Keyword And Return Status  
    ...  Directory Should Exist  ${current_draft_path}/Draft/
    Run Keyword If  '${status}' == 'True'
    ...  Empty Directory  ${current_draft_path}/Draft/
    
Delete Old Screenshots
    ${status} =  Run Keyword And Return Status  
    ...  Directory Should Exist  ${ScreenhotFilePath}
    Run Keyword If  '${status}' == 'True'
    ...  Empty Directory  ${ScreenhotFilePath}