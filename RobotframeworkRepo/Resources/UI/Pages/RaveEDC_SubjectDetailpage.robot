*** Settings ***
Library    SeleniumLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Load
    Wait Until Page Contains    Actions    timeout=20s

Select Screening Visit
    Sleep   5s
    Click Element   xpath=/html/body/div[4]/div/div/div[1]/div/div[2]/ul/ul/li[1]/a
    Sleep   1s
    Click Element   xpath=//*[@id="1028736"]

Select Informed Consent
    Sleep  10s
    Click Element   xpath=//*[@id="1028731"]

Select Subject Randomisation
    Sleep  3s
    Click Element  xpath=//*[@id="1028732"]

Click Save
    Click Button  save-button