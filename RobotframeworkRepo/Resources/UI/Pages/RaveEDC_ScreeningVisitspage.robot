*** Settings ***
Library    SeleniumLibrary
Library    ScreenCapLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Load
    Wait Until Page Contains    Date of Subject Screening    timeout=20s

Enter Date
    Click Element   xpath=/html/body/div[4]/div/div/div[2]/div/datapage/div/form/div/div[2]/div/div/portrait-form-view/div/div[3]/div/div/div/div
    Sleep  1s
    Input Text  xpath=//*[@id="field-control-area"]/div[2]/div/div/portrait-form-view/div/div[3]/div/div/div/div/span[1]/span/span/span/div/div/input[1]  19
    Input Text  xpath=//*[@id="field-control-area"]/div[2]/div/div/portrait-form-view/div/div[3]/div/div/div/div/span[1]/span/span/span/div/div/input[2]  2020
    Select From List By Value  xpath=//*[@id="field-control-area"]/div[2]/div/div/portrait-form-view/div/div[3]/div/div/div/div/span[1]/span/span/span/div/div/select[1]  string:Oct
    Sleep  15s
    Take Screenshot    name=site_selected  format=jpg  width=800px