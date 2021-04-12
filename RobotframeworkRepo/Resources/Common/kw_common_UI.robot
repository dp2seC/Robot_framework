*** Keywords ***

Prepare Test
    Open Browser  about:blank  ${BROWSER}
    Set Selenium Implicit Wait  10 seconds
    Set Selenium Timeout  10 seconds
    Maximize Browser Window
    Set Screenshot Directory  ${ScreenhotFilePath}

End Test
    Close Browser

Load Website
    [Arguments]  ${URL}
    Go To  ${URL}

Login to Website
    [Arguments]  ${user}  ${password}  ${user_text_field}  ${user_pass_field}  ${submit}
    Input Text  ${user_text_field}  ${user}
    Input Password  ${user_pass_field}  ${password}
    Click Button  ${submit}

Search For 
    [Arguments]  ${term}  ${input_box}  ${search_button}
    Input Text  ${input_box}  ${term}
    Click Button  ${search_button}
    sleep  2s

Verify and click 
    [Arguments]  ${action}  ${term}
    sleep  3s
    Run Keyword If  '${action}' == 'Link'
    ...  Run Keywords  Page Should Contain  ${term}
    ...  AND  Click Link  ${term}
    ...  AND  sleep  3s
    ...  ELSE IF  '${action}' == 'Element'
    ...  Run Keywords  Wait Until Page Contains Element  ${term}  timeout=120
    ...  AND  Click Element  ${term}
    ...  AND  sleep  3s
    ...  ELSE IF  '${action}' == 'Button'
    ...  Run Keywords  Element Should Be Enabled  ${term}
    ...  AND  Click Button  ${term}
    ...  AND  sleep  3s

Wait For
    [Arguments]  ${term}
    ${status} =  Run Keyword And Return Status  
    ...  Wait Until Page Contains  ${term}  timeout=30
    Run Keyword if  '${status}' == 'False'
    ...  Run Keywords
    ...  Reload Page
    ...  AND  Wait Until Page Contains  ${term}  timeout=30
 
Verify and Input  
    [Arguments]  ${text_field}  ${term}
    Page Should Contain Textfield  ${text_field}
    Input Text  ${text_field}  ${term}
    sleep  2s

Navigate Home and Logout
    [Arguments]  ${home_link}  ${user_setting_link}  ${logout_link}
    Verify and click  Element  ${home_link}
    Verify and click  Element  ${user_setting_link} 
    Verify and click  Element  ${logout_link}

Verify and Upload file
    [Arguments]  ${upload_input}  ${file_path}
    Page Should Contain Element  ${upload_input}
    Choose file  ${upload_input}  ${file_path}

Click on Link with Name in WebTable
    [Documentation]   This will work only with table having named element.
    [Arguments]  ${term}
    sleep  3s
    ${status} =  Run Keyword And Return Status  
    ...  Click Link  ${term}
    Run Keyword if  '${status}' == 'False'
    ...  Run Keywords
    ...  Execute Javascript  window.scrollBy(0,200);
    ...  AND  sleep  5s
    ...  AND  Click Link  ${term}

Verify For  
    [Arguments]  ${action}  ${term}
    sleep  2s
    Run Keyword If  '${action}' == 'Link'
    ...  Page Should Contain Link  ${term}  message=${term} not found
    Run Keyword IF  '${action}' == 'Button'
    ...  Page Should Contain Button  ${term}  message=${term} not found

Take Screenshot
    [Arguments]  ${filename}
    sleep  2s
    Capture Page Screenshot  ${filename}

Select Item From Dropdown by  
    [Arguments]  ${action}  ${dropdown}  ${term}
    sleep  2s
    Run Keyword If  '${action}' == 'Label'
    ...  Select From List By Label  ${dropdown}  ${term}

Get Current DateTime
    ${DateTime} =  Get Current Date   result_format=%d%m%Y%H%S
    [Return]  ${DateTime}

Set Common Status
    Run Keyword if  '${TEST STATUS}' == 'FAIL'
    ...  Set global Variable  ${common_status}  False


    
