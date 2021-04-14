*** Settings ***
Library    SeleniumLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Load
    Wait Until Page Contains    Was the Subject Randomised?    timeout=20s

Enter data
    Sleep  5s
    Click Element  xpath=//*[@id="field-control-area"]/div[2]/div/div/portrait-form-view/div[1]/div[3]/div/div/div/div
