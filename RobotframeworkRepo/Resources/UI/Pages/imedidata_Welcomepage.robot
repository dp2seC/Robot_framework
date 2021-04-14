*** Settings ***
Library    SeleniumLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Open
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Wait until page contains    Welcome
    Maximize Browser Window

Input Username
    #${username}=    Get Decrypted Text    ${encrypted_username}
    Input Text    session[username]    ${username}

Input Password
    #${password}=    Get Decrypted Text    ${encrypted_pass}
    Input Text    session[password]    ${password}

Login
    Click Button    create_session_link