*** Settings ***
Library    SeleniumLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Load
    Wait Until Page Contains    Subjects    timeout=20s

Select a subject
    Sleep    10s
    Click Element    xpath=//*[@id="search"]/div/div/div/div/input
    Input Text    xpath=//*[@id="search"]/div/div/div/div/input    ${Subjects}[0]
    Click Element   xpath=/html/body/div[4]/div/div/div[2]/div[2]/div[1]/div/div[2]/div/div/span/a
    Sleep    3s
    #Click Element    xpath=//*[@id="typeahead-1391-8696-option-1"]/a
    #Wait Until Page Contains    results for '${Studies}[0]'     timeout=20s
    Click Element  xpath=/html/body/div[4]/div/div/div[2]/div[2]/div[2]/div/div/div[1]/table/tbody/tr/td[1]