*** Settings ***
Library  Collections
Resource  ../../DB/MEDSPROCESSOR_TrackingDB.robot
Library  ../../../Custom_Lib/CSV.py


*** Keywords ***
Verify User is in MEDS Ingestor Page
    Wait Until Page Contains  ${MEDSIngestorHeading}   timeout=15

Click on job link
    Sleep  8s
    Click Element  ${ImportJobLink}

Verify user is in Imported Data page
     Wait Until Page Contains  ${ImportNewDataHeading}   timeout=15

Using "Import New Data" button choose file to import
    [Arguments]  ${filename}
    sleep  15s
    Choose File  ${ImportNewDataFile}  ${filename}

Record the message for the file uploaded
    sleep  6s
    ${UI_Message} =  Get Text  ${ImportFileMessageDiv}
    Set Test Variable  ${UI_Message}
    Capture Page Screenshot

Record the status from DB
    sleep  15s
    ${query} =  Catenate  select job_uuid,error_description,file_processing_status from tracking.external_edc_file_status
    ...                   where data_integration_version_uuid = ${data_integration_version_uuid}
    ${DB_Message} =  Query  ${query}  returnAsDict=True
    Run Keyword if  ${DB_Message} == []  Set An Empty Message
    ...  ELSE  Copy Dictionary from query result  ${DB_Message}
    &{ResultForCSV} =  Create Dictionary  Date=${Date_Formatted}  TestName=${TEST NAME}  UIMessage=${UI_Message}  
    ...  JobUUID=${DB_Message}[job_uuid]  DBMessage=${DB_Message}[error_description]  FileStatus=${DB_Message}[file_processing_status]
    Set Test Variable  &{ResultForCSV}

Write to CSV
    write into csv  ${CSVFilePath}  ${ResultForCSV}

Set An Empty Message
    &{DB_Message} =  Create Dictionary  job_uuid=None  error_description=No Error Found or DB return Null
    ...              file_processing_status=None
    Set Test Variable  ${DB_Message}

Copy Dictionary from query result
    [Arguments]  ${DB_Message} 
    ${DB_Message} =  Copy Dictionary  ${DB_Message}[0]
    Set Test Variable  ${DB_Message}
