*** Settings ***
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    RAVE
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    RODS MASTER

*** Keywords  ***

Data sync between Rave and CDC
    ${CDC_query} =  catenate  select (CONVERT(VARCHAR,count((cast(tran_end_time as date))))) 
     ...  from CDCStaging.${RAVE_URL}.lsn_time_mapping where tran_end_time BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
    ${CDC_sync} =  RAVE.Query  ${CDC_query}
    ${CDC_sync} =  Set Variable  ${CDC_sync}[0][0]
    Wait Until Keyword Succeeds  5x  5 min  CDC sync completion  ${CDC_sync}

CDC sync completion
    [Arguments]  ${CDC_sync}
    ${CDC_query} =  catenate  select (cast(tran_end_time as date)) from CDCStaging.${RAVE_URL}.lsn_time_mapping 
    ...  where tran_end_time BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
    RAVE.Row Count Is Greater Than X  ${CDC_query}  ${CDC_sync}


Verify Status For
    [Arguments]  ${exp_status}  ${retry_times}  ${retry_interval}
    Wait Until Keyword Succeeds  ${retry_times}  ${retry_interval}   Validate job status  ${exp_status}

Validate Job Status
    [Arguments]  ${exp_status}
    ${status_query} =  catenate   select status from global_dom.global_info where schema_name='${RAVE_URL}'
    ${URL_status} =  RODS MASTER.Query  ${status_query}
    ${URL_status} =  Set Variable  ${URL_status}[0][0]
    Should Be Equal  ${URL_status}  ${exp_status}


Set Last Processed Date to null
    ${url_update_query} =  catenate   update global_dom.global_info set last_processed=NULL where schema_name='${RAVE_URL}'
    ${url_update} =  RODS MASTER.Execute Sql String  ${url_update_query}


