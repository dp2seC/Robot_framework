*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Load
    Wait Until Page Contains    ${iMedidata}    timeout=20s

Open Meds Extractor
    Click Link    MEDS Extractor

Open Rave EDC
    Click Link    Rave EDC