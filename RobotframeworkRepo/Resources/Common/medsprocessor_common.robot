*** Settings ***
Library  SeleniumLibrary
Library  DateTime
Library  OperatingSystem
Library  String
Resource  ../../Resources/UI/Pages/MEDSProcessor_LoginPage.robot
Resource  ../../Resources/DB/MEDSPROCESSOR_TrackingDB.robot

*** Keywords ***

Begin Web Test
    Open Browser  about:blank  ${BROWSER}
    #Set Selenium Speed  .3
    Set Selenium Implicit Wait  10 seconds
    Set Selenium Timeout  10 seconds
    Maximize Browser Window
    Set Screenshot Directory  ${ScreenhotFilePath}
    #Set Window Size  580  1018  True
    Rename Files
    Connect to DB

End Web test
    Disconnect DB
    Close Browser

Get Date time as a string with no space
    ${DateTime} =  Get Current Date
    ${Date} =  Convert Date  ${DateTime}  result_format=%d%m%Y%H%S
    ${Date_Formatted} =  Convert Date  ${DateTime}  result_format=%d/%m/%Y %H:%M
    Set Suite Variable  ${Date}
    Set Suite Variable  ${Date_Formatted}
    [Return]  ${Date}

Test Start
    Clear Table for Test
    Open Website
    Login

Test End
    Restore Table after Test
    Logout

Open Website
    Load URL

Login
    Input login credential and click login button

Logout
    Click on Logout button
    Load URL

Get files from location
    @{files} =  List Files In Directory  ${ImportFilePath}
    [Return]  @{files}

Rename Files
    @{files} =  Get files from location
    ${Date} =  Get Date time as a string with no space
    FOR  ${file}  IN  @{files}
        Continue For Loop If  '${file}' == 'LB-NONCSV' or '${file}' == 'medidatalogo.png'
        ${str} =  Replace String Using Regexp  ${file}  \_.*$  _${Date}.csv
        Move File  ${ImportFilePath}/${file}  ${ImportFilePath}/${str}
    END
