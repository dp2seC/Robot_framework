*** Settings ***
Library    SeleniumLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Load
    Wait Until Page Contains    All Studies    timeout=30s

Select a study
    Click Element    search-term
    Input Text    search-term    ${Studies}[0]
    Click Button    search-list-submit
    Wait Until Page Contains    results for '${Studies}[0]'     timeout=30s
    Click Element  xpath=//*[@id="main"]/div/div[2]/table/tbody/tr[1]/td[1]