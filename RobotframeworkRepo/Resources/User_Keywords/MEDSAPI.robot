*** Settings ***
Library   RequestsLibrary
Library   Collections
Library   JSONLibrary
Library   String
Library   DateTime
Library  OperatingSystem

*** Keywords ***

For Valid User
    [Arguments]   ${validinputURL}   ${validinputheader}   ${Base_URL}   ${EndpointName}   ${Queryvalue}
    Create Header  ${validinputheader}
    Get Response   ${validinputURL}  ${Base_URL}   ${EndpointName}   ${Queryvalue}
    Validate Status Code  ${ValidUserStatusCode}    ${EndpointName}   ${Queryvalue}

For Invalid User
    [Arguments]  ${validinputURL}  ${invalidinputheader}    ${Base_URL}   ${EndpointName}   ${Queryvalue}
    Create Header  ${invalidinputheader}
    Get Response  ${validinputURL}  ${Base_URL}   ${EndpointName}   ${Queryvalue}
    Validate Status Code  ${InValidUserStatusCode}  ${EndpointName}   ${Queryvalue}

For Invalid URL
    [Arguments]   ${invalidinputURL}  ${validinputheader}    ${Base_URL}   ${EndpointName}   ${Queryvalue}
    Run Keyword If  '${invalidinputURL}' == 'SKIP'      
    ...            Run Keywords  Log  The endpoint cannot be validated for the respective test scenario.
    ...  AND       Return From Keyword
    Create Header  ${validinputheader}
    Get Response  ${invalidinputURL}  ${Base_URL}   ${EndpointName}   ${Queryvalue}
    Validate Status Code  ${InvalidURLStatusCode}   ${EndpointName}   ${Queryvalue}
