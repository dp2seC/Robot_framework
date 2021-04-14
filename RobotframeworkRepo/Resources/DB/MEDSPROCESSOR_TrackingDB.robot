*** Settings ***
Library  DatabaseLibrary

*** Keywords ***
Connect to DB
    Connect To Database Using Custom Params   psycopg2  ${DbConString}

Execute Query
    [Arguments]  ${SqlToRun}
    ${queryResults} =  Query  ${SqlToRun}
    [Return]  ${queryResults}

Disconnect DB
    Disconnect From Database


Clear Table for Test
    ${query} =  Catenate  Update tracking.external_edc_file_status set data_integration_version_uuid = 'Auto'
                     ...  where data_integration_version_uuid = ${data_integration_version_uuid}
    Execute Sql String  ${query}

Restore Table after Test
    ${query} =  Catenate  Update tracking.external_edc_file_status set data_integration_version_uuid = ${data_integration_version_uuid}
                     ...  where data_integration_version_uuid = 'Auto'
    Execute Sql String  ${query}