***Keywords***
#This is the keyword defined for validating mWarehouse counts response by validating the count values with the values available in mwarehouse database(SE,SEC,SES Endpoints)
mWarehouse_Counts  
  [Arguments]   ${Queryvalue}    ${response}   
  @{MyList}  Create List
  &{dict} =  set variable  ${response.json()}
  ${items}     Get Dictionary Items   ${dict['subject_enrollment_status']['actual']}
  FOR    ${key}    ${value}    IN    @{items}
    Append To List    ${MyList}  ${value}
  END
  ${query}  Set Variable  select actual_completed_subjects_count, actual_in_screening_subjects_count, actual_early_terminated_subjects_count, actual_enrolled_subjects_count, actual_screen_failed_subjects_count, actual_screened_subjects_count from mwh_presentation.v_metric_subject_status_site_daily where ${Queryvalue} and last_refresh_date = (SELECT MAX(last_refresh_date) FROM mwh_presentation.v_metric_subject_status_site_daily WHERE ${Queryvalue})
  @{queryResults}	   MW.query   ${query}
  Comparing Lists    ${MyList}    @{queryResults}

#This is the keyword defined for validating mWarehouse Rates response by validating the rate values with the values available in mwarehouse database(SE,SEC,SES Endpoints)
mWarehouse_Rates  
  [Arguments]   ${Queryvalue}    ${response}   
  @{MyListforrate}  Create List
  Set Test Variable  ${MyListforrate}
  &{dict} =  set variable  ${response.json()}
  ${items}     Get Dictionary Items   ${dict['subject_enrollment_rate']['actual']}
  FOR    ${key}    ${value}    IN    @{items}
    Run keyword if  '${value}' == 'None'
    ...   Append To List    ${MyListforrate}   ${zero}
    ...   ELSE              Rounding off to one decimal place  ${value}    
  END
  ${query}  Set Variable  select ROUND(COALESCE(early_terminated_rate_pct, 0),1), ROUND(COALESCE(actual_enrolled_subjects_per_30day, 0),1), ROUND(COALESCE(screen_failure_rate_pct, 0),1) from mwh_presentation.v_metric_subject_status_site_daily a where ${Queryvalue} and last_refresh_date = (SELECT MAX(last_refresh_date) FROM mwh_presentation.v_metric_subject_status_site_daily WHERE ${Queryvalue})
  @{queryResults}	   MW.query   ${query}
  Comparing Lists    ${MyListforrate}    @{queryResults}

#This is the keyword defined for validating mWarehouse Timeseries response by validating the timeseries values with the values available in mwarehouse database(SE,SEC,SES Endpoints)
mWarehouse_Timeseries
  [Arguments]   ${Queryvalue}    ${response}
  @{MyList}  Create List
  @{MyList2}  Create List
  @{MyList3}  Create List
  &{dict} =  set variable  ${response.json()}
  ${cnt}=    Get length    ${dict['subject_enrollment_status_count_timeseries']['actual']['enrolled']}
  FOR  ${items}    IN RANGE    0    ${cnt}
    ${key}=  get value from json    ${response.json()}  subject_enrollment_status_count_timeseries.actual.enrolled[${items}].[count]
    Append To List    ${MyList}  ${key}
  END   
  FOR    ${row}    IN    @{MyList}
    Append To List    ${MyList2}    ${row[0]}
  END
  ${query}  Set Variable  SELECT SUM(actual_enrolled_subjects_count) AS actual_enrolled_subjects_count,CASE WHEN TO_CHAR(MAX(calendar_date), 'mm') = TO_CHAR(CURRENT_DATE, 'mm') AND TO_CHAR(MAX(calendar_date), 'yyyy') = TO_CHAR(CURRENT_DATE, 'yyyy') THEN MAX(calendar_date) ELSE LAST_DAY(MAX(calendar_date)) END AS calendar_date FROM mwh_presentation.vw_agg_subject_status_site_daily WHERE ${Queryvalue} GROUP BY TO_CHAR(calendar_date, 'yyyy mm') ORDER BY calendar_date DESC
  @{queryResults}	   MW.query   ${query}
  FOR  ${items}    IN RANGE    0   ${cnt}
    ${key}=  set variable  ${queryResults[${items}][0]}
    Append To List    ${MyList3}  ${key}
  END  
  Comparing Lists    ${MyList2}    ${MyList3}

#This is the keyword defined for validating latest subject visit date endpoint response by validating the value available in MEDS DB.
Latest_subject_visit_date
  [Arguments]  ${Queryvalue}  ${response}
  @{MyList2}  Create List
  @{MyList3}  Create List
  ${MyList}=  get value from json    ${response.json()}  latest_visit_date
  ${MyListString}  Convert to string  ${MyList}
  ${MyListString}=  Remove string  ${MyListString}  T00:00:00Z  [  ]  '
  Append to list  ${MyList2}  ${MyListString}
  ${query}  Set Variable  select max(svstdtc) as visit_date from meds.meds_clin_sv where stu_site_uuid = (select stu_site_uuid from meds.stu_site where ${Queryvalue} )
  @{queryResults}	   MEDS.query   ${query}
  ${key}=  set variable  ${queryResults[0]}
  Append to list  ${MyList3}  ${key}
  Comparing Lists    ${MyList2}    @{MyList3}

#This is the keyword defined for validating data reference queries endpoint response by validating the value available in MEDS DB.
Data_Reference_Queries
  [Arguments]  ${Queryvalue}  ${response}
  ${MyList}=  get value from json  ${response.json()}  reference_open_query_count
  ${Query}  Catenate  SELECT Count(DISTINCT cqh.crf_query_uuid) AS reference_open_query_count FROM meds.query_action_type qat INNER JOIN meds.crf_query cqh ON qat.query_actiontype_id = cqh.cur_query_actiontype_id INNER JOIN meds.stu_sbj_itm_data sbjitm ON cqh.stu_uuid = sbjitm.stu_uuid AND cqh.stu_sbj_itm_uuid = sbjitm.stu_sbj_itm_uuid INNER JOIN meds.stu_sbj_frm_data frmdata ON sbjitm.stu_uuid = frmdata.stu_uuid AND sbjitm.stu_sbj_frm_data_uuid = frmdata.stu_sbj_frm_data_uuid AND frmdata.stu_uuid = sbjitm.stu_uuid INNER JOIN meds.stu_site_sbj sitesbj ON sitesbj.stu_uuid = frmdata.stu_uuid AND sitesbj.stu_sbj_uuid = frmdata.stu_sbj_uuid AND sitesbj.stu_uuid = frmdata.stu_uuid INNER JOIN meds.stu_site ssi ON sitesbj.stu_site_uuid = ssi.stu_site_uuid
  ...  AND cqh.stu_uuid = ssi.stu_uuid AND ssi.stu_uuid = sbjitm.stu_uuid INNER JOIN meds.stu stu ON stu.stu_uuid = ssi.stu_uuid INNER JOIN meds.clidiv cd ON cd.clidiv_uuid = stu.clidiv_uuid INNER JOIN meds.crf_query_action cqa ON cqa.stu_uuid = cqh.stu_uuid AND cqa.crf_query_uuid = cqh.crf_query_uuid AND cqa.stu_uuid = ssi.stu_uuid INNER JOIN meds.app_user_acct usr ON cqa.user_uuid = usr.user_uuid WHERE  upper(qat.query_action_type_name) IN ( 'OPEN', 'ANSWERED', 'FORWARDED' )
  ...  AND ${Queryvalue} AND upper(usr.login) != 'SYSTEM' AND usr.login NOT LIKE '%systemuser%'
  @{queryResults}	   MEDS.query   ${query}
  Comparing Lists    ${MyList}    @{queryResults}

#This is the keyword defined for validating Open SAE and Monitoring Log SAE endpoint response by validating the value available in MEDS DB.
Open and Monitoring SAE
  [Arguments]  ${Queryvalue}  ${response}  ${EndpointName}
  @{MyList}  Create List
  @{queryresuktsnew}  Create List
  ${length}=  get length  ${response.json()} 
  FOR  ${i}   IN RANGE    0   ${length} 
    ${Key}  get value from json   ${response.json()}  [${i}].study_subject_number
    ${list_value1}  get from list  ${Key}  0
    Append to list  ${MyList}  ${list_value1}
    ${Key}  get value from json   ${response.json()}  [${i}].occurred_date_original
    ${list_value2}  get from list  ${Key}  0
    Append to list  ${MyList}  ${list_value2}
  END
  ${Query}=  Set Variable if  '${EndpointName}' == 'Open_SAE'   select stu_sbj_num,aestdtc from meds.meds_clin_ae where stu_site_uuid = (select stu_site_uuid from meds.stu_site where ${Queryvalue} ) and UPPER(aeser) IN('YES','Y','SERIOUS') AND aeendtc IS NULL order by stu_sbj_num asc
  ...  SELECT ae.stu_sbj_num,ae.aestdtc FROM meds.meds_clin_ae ae JOIN meds.stu_site site ON site.stu_uuid = ae.stu_uuid AND site.stu_site_uuid = ae.stu_site_uuid JOIN meds.stu_sbj_frm_data frm ON ae.stu_uuid = frm.stu_uuid AND ae.stu_sbj_frm_data_uuid = frm.stu_sbj_frm_data_uuid JOIN meds.stu_sbj_frm_fact fct ON fct.stu_uuid = frm.stu_uuid AND fct.stu_sbj_frm_data_uuid = frm.stu_sbj_frm_data_uuid WHERE ${Queryvalue}     
  @{queryResults}	   MEDS.query   ${query}
  FOR    ${row}    IN    @{queryResults}
    Append To List    ${queryresuktsnew}    ${row[0]}
    Append To List    ${queryresuktsnew}    ${row[1]}
  END
  Comparing Lists    ${MyList}    ${queryresuktsnew}

#This is the keyword defined for validating Subject Triggers endpoint response by validating the value available in MEDS DB.
Subject_Triggers
  [Arguments]  ${Queryvalue}  ${response}
  @{MyList}  Create List
  @{MyList2}  Create List
  @{MyList3}  Create List
  @{MyList4}  Create List
  ${length}=  get length  ${response.json()}
  FOR  ${i}   IN RANGE    0   ${length} 
    ${Key}  get value from json   ${response.json()}  [${i}].trigger_date
    ${list_value1}  get from list  ${Key}  0
    Append to list  ${MyList}  ${list_value1}
  END
  ${MyListString}  Convert to string  ${MyList}
  ${MyListString}=  Remove string  ${MyListString}  T00:00:00Z
  Append to list  ${MyList2}  ${MyListString}
  ${Query}  Catenate  SELECT * FROM (WITH cte AS (SELECT cd.src_uuid client_division_uuid,se.src_uuid study_environment_uuid,site.src_uuid study_site_uuid,ssts.stu_sbj_sts_code,ssts.stu_sbj_sts_dat,Min(prf_evt.prf_dat) OVER (partition BY sitesub.stu_site_uuid) first_subject_first_visit,Rank() OVER (partition BY ssts.stu_sbj_sts_code,ssts.stu_sbj_uuid ORDER BY ssts.stu_sbj_sts_code DESC) rea_rank FROM meds.stu_sbj sub JOIN meds.clidiv cd ON cd.clidiv_uuid = sub.clidiv_uuid JOIN meds.stu_env se ON se.stu_uuid = sub.stu_uuid AND se.clidiv_uuid = cd.clidiv_uuid AND se.stu_env_uuid = sub.stu_env_uuid JOIN meds.stu_site_sbj sitesub ON sub.stu_uuid = sitesub.stu_uuid AND sub.stu_sbj_uuid = sitesub.stu_sbj_uuid AND sitesub.clidiv_uuid = cd.clidiv_uuid JOIN meds.stu_site site ON sitesub.stu_uuid = site.stu_uuid AND sitesub.stu_site_uuid = site.stu_site_uuid JOIN meds.stu_sbj_prf_evt prf_evt ON prf_evt.stu_uuid = sub.stu_uuid AND prf_evt.clidiv_uuid = sub.clidiv_uuid AND prf_evt.stu_sbj_uuid = sub.stu_sbj_uuid LEFT JOIN meds.stu_sbj_sts ssts ON ssts.stu_uuid = sub.stu_uuid AND ssts.clidiv_uuid = cd.clidiv_uuid AND ssts.stu_sbj_uuid = sub.stu_sbj_uuid
  ...  WHERE ${Queryvalue})SELECT client_division_uuid,stu_sbj_sts_code,study_environment_uuid,study_site_uuid,first_subject_first_visit, Min(stu_sbj_sts_dat) min_sts_dat FROM cte WHERE rea_rank = 1 GROUP BY client_division_uuid,stu_sbj_sts_code,study_environment_uuid,study_site_uuid,first_subject_first_visit, stu_sbj_sts_code) PIVOT (min(min_sts_dat) FOR stu_sbj_sts_code IN ('SCRN' AS first_subject_screened,'RANDM' AS first_subject_randomized,'ENRL' AS first_subject_enrolled,'IFC' AS informed_consent_date))
  @{queryResults}	   MEDS.query   ${query}
  FOR  ${items}    IN RANGE    3  8
    ${key}=  set variable  ${queryResults[0][${items}]}
    ${date} =	Convert Date	${key}  result_format=%Y-%m-%d
    Append To List    ${MyList3}  ${date}
  END  
  ${MyListString}  Convert to string  ${MyList3}
  Append to list    ${MyList4}    ${MyListString}
  Comparing Lists   ${MyList2}    ${MyList4}

#The following keyword is defined for validating All Subjects endpoint response by validating the value available in MEDS DB.
All_Subjects_Endpoint
  [Arguments]  ${Queryvalue}  ${response}
  @{MyList}  Create List
  @{MyList2}  Create List
  &{dict} =  set variable  ${response.json()}
  ${length}=    Get length    ${dict['subjects_list']}
  FOR  ${items}    IN RANGE    0    ${length}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].study_subject_number
    Append To List    ${MyList}  ${key}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].subject_informed_consent_date
    Append To List    ${MyList}  ${key}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].subject_screened_date
    Append To List    ${MyList}  ${key}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].subject_screen_failed_date
    Append To List    ${MyList}  ${key}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].subject_enrolled_date
    Append To List    ${MyList}  ${key}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].subject_randomized_date
    Append To List    ${MyList}  ${key}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].subject_withdrawn_date
    Append To List    ${MyList}  ${key}
    ${key}=  get value from json    ${response.json()}  subjects_list[${items}].subject_completed_date
    Append To List    ${MyList}  ${key}
  END   
  ${MyList}  Convert to string  ${MyList}
  ${MyList}=  Remove string  ${MyList}  T00:00:00Z  [  ]  '
  @{MyList}=    Convert To List    ${MyList}
  ${Query}  Catenate  (SELECT * FROM ((SELECT stusub.stu_sbj_num,stsh.stu_sbj_sts_code,Max(CASE WHEN stsh.row_eff_at = stsh.row_exp_at THEN NULL ELSE TO_CHAR(stsh.stu_sbj_sts_dat,'YYYY-MM-DD') END) keep(dense_rank last ORDER BY stsh.row_eff_at) stat_dat FROM meds.stu_sbj_sts_h stsh INNER JOIN meds.stu stu ON stu.stu_uuid = stsh.stu_uuid INNER JOIN meds.clidiv cd ON cd.clidiv_uuid = stu.clidiv_uuid INNER JOIN meds.stu_site_sbj sitesub ON stsh.stu_uuid = sitesub.stu_uuid AND sitesub.stu_sbj_uuid = stsh.stu_sbj_uuid
  ...  INNER JOIN meds.stu_sbj stusub ON sitesub.stu_sbj_uuid = stusub.stu_sbj_uuid INNER JOIN meds.stu_site site ON site.stu_uuid = sitesub.stu_uuid AND sitesub.stu_site_uuid = site.stu_site_uuid AND site.stu_uuid = stu.stu_uuid
  ...  WHERE ${Queryvalue} GROUP BY stsh.stu_sbj_sts_code, stusub.stu_sbj_num ORDER BY stsh.stu_sbj_uuid,stsh.stu_sbj_sts_code ) PIVOT ( max ( stat_dat ) FOR stu_sbj_sts_code IN ( 'IFC' AS ifc,'SCRN' AS scr,'SCRFL' AS sfl,'ENRL' AS enrl,'RANDM' AS rand,'DISCNT' AS et,'COMPL' AS eos))))
  @{queryResults}	   MEDS.query   ${Query}
  ${queryResults}  Convert to string  ${queryResults}
  ${queryResults}=  Remove string  ${queryResults}  T00:00:00Z  [  ]  '  (  )
  @{queryResults}=    Convert To List    ${queryResults}
  Comparing Lists   ${MyList}    ${queryResults}


#The following keyword is defined for validating Visit Activity Data Point Endpoint response by validating the value available in MEDS DB.
Visit_Activity_Data_Point_Endpoint
  [Arguments]  ${Queryvalue}  ${response}
  @{MyList}  Create List
  @{MyList2}  Create List
  @{MyList3}  Create List
  
  FOR  ${items}    IN RANGE    4    6
    ${key}=  get value from json    ${response.json()}  [${items}].count_a
    Append To List    ${MyList}  ${key}
  END   
  ${MyList}  Convert to string  ${MyList}
  ${MyList}=  Remove string  ${MyList}  [  ]  ,
  Append to list  ${MyList2}  ${MyList}

  ${Query}  Catenate  select count(*) from meds.stu_sbj_frm_data where sdv_cpl_dat is not null and stu_sbj_uuid in ((select stu_sbj_uuid from meds.stu_site_sbj where stu_site_uuid =(select stu_site_uuid from meds.stu_site where 
  ...  ${Queryvalue} UNION ALL select count(*) from meds.stu_sbj_frm_data where stu_sbj_frm_data_uuid in (select stu_sbj_frm_data_uuid from meds.stu_sbj_itm_data where itm_req_ver = 1 and stu_sbj_uuid in
  ...  (select stu_sbj_uuid from meds.stu_site_sbj where stu_site_uuid =(select stu_site_uuid from meds.stu_site where ${Queryvalue}
  ${queryResults}	   MEDS.query   ${Query}
  
  ${queryResults}  Convert to string  ${queryResults}
  ${queryResults}=  Remove string  ${queryResults}  (  )  ,  [  ]
  Append to list  ${MyList3}  ${queryResults}
  Comparing Lists   ${MyList2}    ${MyList3}

#The following keyword is defined to compare Lists
Comparing Lists
    [Arguments]  ${List1}  ${List2}
    Log   ${List1}
    Log   ${List2}
    ${Status} = 	Run Keyword And Return Status  Lists should be equal  ${List1}  ${List2}
    Run Keyword If 	 '${Status}' == 'True'   
    ...                           Log to console   Validation of DB and API was successful
    ...     ELSE                  Log to console   Validation of DB and API was not successful


#The following keyword is defined to round off values in a List to one decimal place(API Results)
Rounding off to one decimal place
    [Arguments]  ${value}
    ${roundoff}=  Convert to Number  ${value}  1 
    Append To List    ${MyListforrate}  ${roundoff}