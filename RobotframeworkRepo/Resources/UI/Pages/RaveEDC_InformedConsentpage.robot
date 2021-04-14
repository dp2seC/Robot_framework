*** Settings ***
Library    SeleniumLibrary
Resource  ../../Common/medsextractor_variables.robot

*** Keywords ***
Load
    Wait Until Page Contains    Did subject complete Informed Consent?    timeout=20s

Enter Data
    Sleep  3s
    Input Text  xpath=/html/body/div[4]/div/div/div[2]/div/datapage/div/form/div/div[2]/div/div/portrait-form-view/div[2]/div[3]/div/div/div/div/span/span/span/span/div/div/input[1]  08
    Select from list By Value  xpath=//*[@id="field-control-area"]/div[2]/div/div/portrait-form-view/div[2]/div[3]/div/div/div/div/span/span/span/span/div/div/select  string:Feb
    Input Text  xpath=//*[@id="field-control-area"]/div[2]/div/div/portrait-form-view/div[2]/div[3]/div/div/div/div/span/span/span/span/div/div/input[2]  2021
    Sleep  5s
    Take Screenshot    name=informed_consent  format=jpg  width=800px