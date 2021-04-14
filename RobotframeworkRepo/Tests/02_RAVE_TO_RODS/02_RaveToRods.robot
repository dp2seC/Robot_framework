*** Settings ***
Resource  ../../setting_references.robot
Library  DataDriver  ../../EX_Files/Queries/R2R_Query.xlsx   sheet_name=SRC_RAVE
Suite Setup  Run Keywords  Connect to  RAVE  
...                   AND  Connect to  RODS  
Suite Teardown  Run Keywords  DB Disconnect  RAVE  
...                      AND  DB Disconnect  RODS
Test Teardown  Test Case Error Handling
Test Template  Test Scenarios

# Command: robot -d Results/R2R_Results Tests/02_RAVE_TO_RODS/02_RaveToRods.robot
# use for debug: robot -d Results/R2R_Results -L DEBUG Tests/02_RAVE_TO_RODS/02_RaveToRods.robot
# use to run parallel: pabot -d Results/R2R_Results Tests/02_RAVE_TO_RODS/02_RaveToRods.robot
# use when no tags: robot -d Results/R2R_Results -r NONE -l NONE -o NONE  Tests/02_RAVE_TO_RODS/02_RaveToRods.robot
# use for tag: robot -d Results/R2R_Results -r NONE -l NONE -o NONE -v Default_Tag:Smoke  Tests/02_RAVE_TO_RODS/02_RaveToRods.robot

*** Test Cases ***
Validation of source as RODS



*** Keywords ***
Test Scenarios
    [Arguments]  ${doc}  ${table_name}  ${tag}  ${mapping_db}  ${lookup_db}  ${target_db}  ${mapping_query}  ${manual_count}
    ...  ${merge_col}  ${lookup_query}  ${data_structure}  ${source_col_for_target}  ${target_query}  
    ...  ${sort_value}  ${result_file_name}
 
    Set Test Variable  ${result_path}  ${main_result_path}R2R_Results/
    Set Test Variable  ${diff_csv_path}  ${main_result_path}R2R_Results/Error_Tables/
    Set Test Variable  ${MasterResultFile}  ${result_path}${result_file_name}
    Set Test Variable  ${table_name}
    Set Test Documentation  ${doc}
    Set Tags  ${tag}
    Run Keyword If  $tag in $Default_Tag and ${common_status} == True
    ...  Run Keywords
    ...  Execute Mapping Query  ${mapping_query}  ${merge_col}  ${mapping_db}  ${table_name}
    ...  AND  Should Be Equal As Integers  ${M_len}  ${manual_count}  msg=Mismatch in Rave count found
    ...  AND  Execute Lookup Query   ${lookup_db}  ${lookup_query}  ${source_col_for_target}  ${table_name}
    ...  AND  Execute Target Query   ${target_db}  ${target_query}  ${table_name}
    ...  AND  Validate Source and Target  ${table_name}  ${sort_value}  ${data_structure}  ${result_path}  ${diff_csv_path}
