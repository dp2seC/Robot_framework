*** Settings ***
Library    SeleniumLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Load
    Wait Until Page Contains    Sites    timeout=30s

Select a site
    Click Element    search-term
    Input Text    search-term    ${Sites}[0]
    Click Button    search-list-submit
    Wait Until Page Contains    results for '${Sites}[0]'     timeout=20s
    Click Element  xpath=//*[@id="main"]/div/div[2]/table/tbody/tr[1]/td[1]