*** Settings ***
#Library  SeleniumLibrary


*** Keywords ***
Load URL
    Go To  ${URL}

Input login credential and click login button
    Input Text  ${LP_LoginTextBox}  ${LP_LoginUserName}
    Input Password  ${LP_PasswordTextBox}  ${LP_LoginPassword}
    Click Button  ${LP_LoginButton}

Click on Logout button
    Click Element  ${LP_HomeImage}
    sleep  3s
    Click Element  ${LP_UserSettingsLink}
    Click Element  ${LP_Logout}
    sleep  3s