*** Keywords ***
Open Rave Architect and Login
    ${url_arc} =  Replace String  ${url_arc}  {  \${
    ${url_arc} =  Replace Variables  ${url_arc}
    Load Website  ${url_arc}
    Login to Website  ${arc_user}  ${arc_password}  
    ...  ${arc_user_textfield}  ${arc_pass_textfield}  ${arc_submit_button}

Navigate to Architect Page
    Verify and click   Link  ${arc_architect_link}
    ${status} =  Run Keyword And Return Status  
    ...  Verify For  Link  ${study_name}
    Run Keyword if  '${status}' == 'False'
    ...  Run Keywords
    ...  Log  Study with name "${study_name}" not found
    ...  AND  Fail  Study with name "${study_name}" not found

Navigate to Project Page
    Click on Link with Name in WebTable  ${study_name}

Navigate to CRF Draft upload Page
    Verify and click   Link  ${arc_upload_draft_link}
    Run Keyword If  ${create_new_study} == False  
    ...  Get Artifacts  ${study_name}  ${draft_name}  ${current_draft_path}  False

Upload Draft
    Verify and Upload file   ${arc_upload_input_element}  ${current_draft}
    Verify and click   Button  ${arc_upload_button}
    sleep  75s

Publish Draft
    Wait For  ${draft_name}
    Click on Link with Name in WebTable  ${draft_name}
    Verify and Input  ${arc_CRF_Version_text_box}  ${draft_name}
    Verify and click  Button  ${arc_CRF_publish_button}
    Take Screenshot  ${draft_name}.png

Get CRF VersionID
    ${draft_name_len} =  Get Length  ${draft_name}
    ${draft_name_with_version} =  Get Text  ${arc_draft_name_after_publish}
    ${CRF_VERSION_ID} =  Get Substring  ${draft_name_with_version}  ${draft_name_len+2}  -1
    ${CRF_VERSION_ID} =  Convert To Integer  ${CRF_VERSION_ID}
    Set Global Variable  ${CRF_VERSION_ID}

Push Draft
    Click on Link with Name in WebTable  ${arc_draft_push_link}
    Select Item From Dropdown by  Label  ${arc_draft_study_env_dropdown}  ${arc_draft_study_env}
    Verify and click   Button  ${arc_draft_study_env_push_button}
    Take Screenshot  ${draft_name}_push.png