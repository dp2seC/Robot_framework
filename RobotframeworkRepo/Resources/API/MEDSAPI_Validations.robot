*** Keywords ***
Create Header
    [Arguments]  ${Inputheader}
    ${headers} =  Create Dictionary  mcc-impersonate=${Inputheader}
    Set Test Variable  ${headers}

Get Response
    [Arguments]  ${InputURL}  ${Base_URL}  ${EndpointName}  ${Queryvalue}
    ${response} =  Create session and get status  ${InputURL}  ${headers}  ${Base_URL}  ${EndpointName}  ${Queryvalue}
    Set Test Variable  ${response}

Validate Status Code
    [Arguments]  ${UserStatusCode}  ${EndpointName}   ${Queryvalue}
    ${statuscode} =  convert to string  ${response.status_code}
    Run Keyword If  '${statuscode}' == '${UserStatusCode}' and '${UserStatusCode}' == '200'
    ...            Run Keywords  Log  Success
    ...  AND       Endpoint Validation  ${EndpointName}  ${Queryvalue}  ${response}  
    ...  ELSE IF  '${statuscode}' == '${UserStatusCode}'  Log  Success
    ...  ELSE      Run keyword And Continue On Failure  Fail  The request returned ${statuscode} status code instead of ${UserStatusCode}


Create session and get status  
    [Arguments]   ${validinputURL}   ${headers}   ${Base_URL}   ${EndpointName}   ${Queryvalue}
    create session  ${Session_Name}   ${Base_URL}    proxies=${proxies}   disable_warnings=${disable_warnings}
    ${response} =  get request  ${Session_Name}  ${validinputURL}  headers=${headers}
    [Return]  ${response }

Endpoint Validation
    [Arguments]   ${EndpointName}   ${Queryvalue}   ${response}
    Run Keyword If  '${EndpointName}' == 'mWarehouse_Counts'  mWarehouse_Counts  ${Queryvalue}  ${response}                     ELSE IF
    ...  '${EndpointName}' == 'mWarehouse_Rates'  mWarehouse_Rates  ${Queryvalue}  ${response}                                  ELSE IF
    ...  '${EndpointName}' == 'mWarehouse_Timeseries'  mWarehouse_Timeseries  ${Queryvalue}  ${response}                        ELSE IF
    ...  '${EndpointName}' == 'Latest_visit_date'  Latest_subject_visit_date  ${Queryvalue}  ${response}                        ELSE IF
    ...  '${EndpointName}' == 'Data_Reference_Queries'  Data_Reference_Queries  ${Queryvalue}  ${response}                      ELSE IF
    ...  '${EndpointName}' == 'Open_SAE'  Open and Monitoring SAE  ${Queryvalue}  ${response}  ${EndpointName}                  ELSE IF
    ...  '${EndpointName}' == 'SAE_Monitoring_Log'  Open and Monitoring SAE  ${Queryvalue}  ${response}  ${EndpointName}        ELSE IF
    ...  '${EndpointName}' == 'Subject_Triggers'  Subject_Triggers  ${Queryvalue}  ${response}                                  ELSE IF
    ...  '${EndpointName}' == 'All_Subjects_Endpoint'  All_Subjects_Endpoint   ${Queryvalue}  ${response}                       ELSE IF
    ...  '${EndpointName}' == 'Visit_Activity_Data_Point_Endpoint'  Visit_Activity_Data_Point_Endpoint  ${Queryvalue}  ${response}  ELSE
    ...  Log  No validation required
