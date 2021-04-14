*** Settings ***
Documentation  This script contains the common keywords used across the projects
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    RAVE
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    RODS
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    RODS MASTER
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    MEDS
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    IMEDIDATA
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    SUBJECTS
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    DALTON
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    MH
Library  ../../Custom_Lib/DatabaseLibraryExtend.py  WITH NAME    MW

*** Keywords  ***
Connect to
    [Arguments]  ${DB}
    Run Keyword If  '${DB}' == 'RAVE'  RAVE.Connect to Database Using Custom Params  pymssql  ${RAVE_DbConString}
    ...    ELSE IF  '${DB}' == 'RODS'  RODS.Connect to Database Using Custom Params  cx_Oracle  ${RODS_DbConString}
    ...    ELSE IF  '${DB}' == 'RODS MASTER'  RODS MASTER.Connect to Database Using Custom Params  cx_Oracle  ${RODSMSTR_DbConString}   
    ...    ELSE IF  '${DB}' == 'MEDS'  MEDS.Connect to Database Using Custom Params  cx_Oracle  ${MEDS_DbConString}
    ...    ELSE IF  '${DB}' == 'IMEDIDATA'  IMEDIDATA.Connect to Database Using Custom Params  pymysql  ${IMEDI_DbConString}
    ...    ELSE IF  '${DB}' == 'SUBJECTS'  SUBJECTS.Connect to Database Using Custom Params  pymysql  ${SBJ_DbConString}
    ...    ELSE IF  '${DB}' == 'DALTON'  DALTON.Connect to Database Using Custom Params  psycopg2  ${DALTON_DbConString}
    ...    ELSE IF  '${DB}' == 'MH'    MH.Connect to Database Using Custom Params  cx_Oracle  ${MH_DbConString}
    ...    ELSE IF  '${DB}' == 'MW'    MW.Connect to Database Using Custom Params  psycopg2   ${MW_DbConString}

DB Disconnect
    [Arguments]  ${DB}
    Run Keyword If  '${DB}' == 'RAVE'  RAVE.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'RODS'  RODS.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'RODS MASTER'  RODS MASTER.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'MEDS'  MEDS.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'IMEDIDATA'  IMEDIDATA.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'SUBJECTS'  SUBJECTS.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'DALTON'  DALTON.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'MH'    MH.Disconnect From Database
    ...    ELSE IF  '${DB}' == 'MW'    MW.Disconnect From Database


Get StudyID and STU_UUID
    #[Arguments]  ${RAVE_URL}  ${MEDS_STUDY}  ${MEDS_ENV_ID}
    ${stu_id_query}=  catenate  select Distinct stu_id,UUID
                                ...  from ${RAVE_URL}.t_stu ts
                                ...  inner join 
                                ...  (
                                ...  select distinct prj_id from ${RAVE_URL}.t_proj tp
                                ...  join ${RAVE_URL}.t_loc_data_strings tloc
                                ...  on tp.prj_name=tloc.string_id
                                ...  where tloc.data_string='${MEDS_STUDY}') prj
                                ...  on ts.prj_id=prj.prj_id
                                ...  where env_name_id=${MEDS_ENV_ID}
    @{stu_id_result} =  RODS.Query  ${stu_id_query}
    @{stu_id_result}=  Convert To List  ${stu_id_result[0]}
    ${stu_id_gv}=  Set Variable  ${stu_id_result[0]}
    ${stu_src_uuid_gv}=  Set Variable  ${stu_id_result[1]}
    Set global Variable  ${stu_src_uuid_gv}
    Set global Variable  ${stu_id_gv}
    ${stu_uuid_query}=  catenate  select RAWTOHEX(stu_uuid) as stu_uuid from meds_core.stu_env where src_uuid = '${stu_id_result[1]}'
    ${stu_uuid_gv} =  MEDS.Query  ${stu_uuid_query}
    Set global Variable  ${stu_uuid_gv}
    #[Return]  ${stu_id_gv}
    ${stu_src_uuid_query}=  catenate  select src_uuid from meds_core.stu where stu_uuid=  ${stu_uuid_gv}
    ${stu_src_uuid_query} =  Replace String  ${stu_src_uuid_query}  [('  ('
    ${stu_src_uuid_query} =  Replace String  ${stu_src_uuid_query}  ',)]  ')
    ${STU_SRC_UUID}=  MEDS.Query  ${stu_src_uuid_query}
    Set global Variable  ${STU_SRC_UUID}
    #[Return]  ${STU_SRC_UUID}
    ${clidiv_src_uuid_query}=  catenate  select tu.src_uuid from meds_core.tu tu 
                                ...  join meds_core.stu s on tu.tu_uuid=s.clidiv_uuid
                                ...  where s.stu_uuid=  ${stu_uuid_gv}
    ${clidiv_src_uuid_query} =  Replace String  ${clidiv_src_uuid_query}  [('  ('
    ${clidiv_src_uuid_query} =  Replace String  ${clidiv_src_uuid_query}  ',)]  ')
    ${p_CLIDIV_SRC_UUID}=  MEDS.Query  ${clidiv_src_uuid_query}
    Set global Variable  ${p_CLIDIV_SRC_UUID}
    #[Return]  ${p_CLIDIV_SRC_UUID}
