*** Settings ***
#Library  DatabaseLibrary
Library  Collections
Library  String
Library  ../../Custom_Lib/Utilities.py

*** Keywords ***
Execute Mapping Query
    [Arguments]  ${mapping_query}  ${merge_col}  ${mapping_db}  ${table_name}
    ${merge_col} =  Replace String  ${merge_col}  \n  ${empty}  
    @{merge_col} =  Split String  ${merge_col}  ,
    ${mapping_query} =  Replace String  ${mapping_query}  '[(  ${empty}  
    ${mapping_query} =  Replace String  ${mapping_query}  ,)]'  ${empty}
    ${mapping_query} =  Replace String  ${mapping_query}  ,)]  )]  
    ${mapping_query} =  Replace String  ${mapping_query}  [('  ' 
    ${mapping_query} =  Replace String  ${mapping_query}  ')]  '
    Run Keyword if  '${LOG_LEVEL}' == 'DEBUG'
    ...  log  ${mapping_query} 
    @{mapping_query_output} =  Run keyword  ${mapping_db}.query  ${mapping_query}  returnAsDict=True
    Run Keyword if  '${LOG_LEVEL}' == 'DEBUG'
    ...  log  ${mapping_query_output} 
    ${M_len} =  Get Length  ${mapping_query_output}
    Run Keyword if  ${M_len} == 0  Run Keywords
    ...  Set Test Variable  ${exception}  Mapping query returned no output
    ...  AND  Fail  Mapping query returned no output
    @{mapping_query_values} =  Parse Dict With Col  ${MasterResultFile}  ${CRF_VERSION_ID}  ${MEDS_STUDY}  ${table_name}  
    ...  ${mapping_query_output}  ${merge_col} 
    Set Test Variable  ${mapping_query_output}
    Set Test Variable  ${mapping_query_values}
    Set Test Variable  ${merge_col}
    Set Test Variable  ${M_len}

Execute Lookup Query
    [Arguments]  ${lookup_db}  ${lookup_query}  ${source_col_for_target}  ${table_name}
    ${source_col_for_target} =  Replace String  ${source_col_for_target}  \n  ${empty}
    @{source_col_for_target} =  Split String  ${source_col_for_target}  ,
    ${lookup_query} =  Replace String  ${lookup_query}  {   \${
    ${lookup_query} =  Replace Variables  ${lookup_query}
    ${lookup_query} =  Replace String  ${lookup_query}  [  (
    ${lookup_query} =  Replace String  ${lookup_query}  ]  )
    ${lookup_query} =  Replace String  ${lookup_query}  ,)  )
    ${lookup_query} =  Replace String  ${lookup_query}  None  NULL
    @{lookup_query_output} =  Run keyword  ${lookup_db}.query  ${lookup_query}  returnAsDict=True
    Run Keyword if  '${LOG_LEVEL}' == 'DEBUG'
    ...  log  ${lookup_query}
    @{lookup_query_output} =  Run keyword  ${lookup_db}.query  ${lookup_query}  returnAsDict=True
    Run Keyword if  '${LOG_LEVEL}' == 'DEBUG'
    ...  log  ${lookup_query_output}
    ${L_len} =  Get Length  ${lookup_query_output}
    Run Keyword if  ${L_len} == 0  Run Keywords
    ...  Set Test Variable  ${exception}  Lookup query returned no output, MappingCount:${M_len}
    ...  AND  Fail  Lookup query returned no output, MappingCount:${M_len}
    @{lookup_query_values} =  Parse Dict With Col  ${MasterResultFile}  ${CRF_VERSION_ID}  ${MEDS_STUDY}  ${table_name}  
    ...  ${lookup_query_output}  ${source_col_for_target}
    Set Test Variable  ${lookup_query_output}
    Set Test Variable  ${lookup_query_values}
    Set Test Variable  ${L_len}

Execute Target Query  
    [Arguments]  ${target_db}  ${target_query}  ${table_name}
    @{Target_data}=    Create List
    ${target_query} =  Replace String  ${target_query}  {  \${
    ${target_query} =  Replace Variables  ${target_query}
    ${target_query} =  Replace String  ${target_query}  [  (
    ${target_query} =  Replace String  ${target_query}  ]  )
    ${target_query} =  Replace String  ${target_query}  ,)  )
    Run Keyword if  '${LOG_LEVEL}' == 'DEBUG'
    ...  log  ${target_query} 
    @{target_query_output} =  Run keyword  ${target_db}.query  ${target_query}  returnAsDict=True
    Run Keyword if  '${LOG_LEVEL}' == 'DEBUG'
    ...  log  ${target_query_output}
    ${T_len} =  Get Length  ${target_query_output}
    Run Keyword if  ${T_len} == 0  Run Keywords
    ...  Set Test Variable  ${exception}  Target query returned no output,MappingCount:${M_len},LookupCount:${L_len}
    ...  AND  Fail  Target query returned no output,MappingCount:${M_len},LookupCount:${L_len}
    Set Test Variable  ${target_query_output} 

Validate Source and Target  
    [Arguments]  ${table_name}  ${sort_value}  ${data_structure}  ${result_path}  ${diff_csv_path}
    @{sort_value} =  Split String  ${sort_value}  ,
    @{data_structure} =  Split String  ${data_structure}  , 
    &{result} =  Prepare Source Target Validate  ${mapping_query_output}  ${lookup_query_output}  
    ...          ${target_query_output}  ${merge_col}  ${data_structure}  ${sort_value}
    ...          ${result_path}  ${diff_csv_path}  ${table_name}  ${MasterResultFile}  ${CRF_VERSION_ID}  ${MEDS_STUDY}  ${LOG_LEVEL}
    Run Keyword if  '${LOG_LEVEL}' == 'DEBUG'
    ...  log  ${result}
    Run Keyword if  '${result}[status]' == 'FAIL'  Fail  ${result}[result]

Test Case Error Handling
    ${variables} =  Get variables
    Run Keyword if  "\${exception}" in $variables  Set Variable  ${TEST MESSAGE}  ${exception}
    Run Keyword if  '${TEST STATUS}' == 'FAIL' and '${TEST MESSAGE}' != 'AssertionError' and '${TEST MESSAGE}' != 'Difference in table found'
    ...  Result to Master  master_result_file=${MasterResultFile}  crf_version=${CRF_VERSION_ID}     
    ...  study_name=${MEDS_STUDY}  table_name=${table_name}
    ...  exception=${TEST MESSAGE}


    