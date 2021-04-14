*** Keywords ***
Navigate to RaveEDC App and Choose Admin Role
    Search For  ${ca_study_group_name}  ${ca_sg_search_box}  ${ca_sg_search_button}
    Verify and click  Link  ${ca_ca_APP_Link}
    Wait For  ${ca_study_page_heading}
    Verify and click  Element  ${ca_Action_span} 
    Verify and click  Element  ${ca_Admin_Link}

Add New Study
    Wait For  ${ca_create_study_link}
    Verify and click  Link  ${ca_create_study_link}
    Get Artifacts  ${study_name}  ${draft_name}  ${current_draft_path}  True
    Verify and Input  ${ca_protocolID_text_field}  ${study_name}
    Verify and click  Element  ${ca_Phase_dropdown}
    Verify and Input  ${ca_common_search_box}  ${ca_Phase_term}
    Verify and click  Element  ${ca_common_search_option_highlighted}
    Verify and click  Element  ${ca_Primary_Indication}
    Verify and Input  ${ca_common_search_box}  ${ca_Primary_Indication_term}
    Verify and click  Element  ${ca_common_search_option_highlighted}
    Verify and click  Button  ${ca_create_study_submit_button}
    Wait For  ${ca_edit_study_button}
    Verify and click  Element  ${ca_Action_span} 
    Verify and click  Element  ${ca_Admin_Link}
    Take Screenshot  ${study_name}.png

Add New Site
    Verify and click  Element  ${ca_manage_sites}
    Verify and click  Button  ${ca_add_new_site_dropdown}
    Verify and click  Element  ${ca_add_site}
    Verify and Input  ${ca_site_name_input}  ${site_name}
    Verify and click  Element  ${ca_add_new_site_link}
    Verify and Input  ${ca_cd_org_id}  ${site_name}
    Verify and click  Element  ${ca_use_site_num_checkbox}
    Select Item From Dropdown by  Label  ${ca_select_env_dropdown}  ${ca_env_name}
    Verify and click  Element  ${ca_select_country} 
    Verify and click  Element  ${ca_country_name}
    Verify and Input  ${ca_address1_input}  ${site_name}
    Verify and Input  ${ca_city_input}  ${site_name}
    Verify and click  Element  ${ca_select_state}  
    Verify and click  Element  ${ca_country_name}
    Verify and Input  ${ca_postal_code_input}  ${ca_postal_code}
    Verify and click  Button  ${ca_add_site_to_prod}

Add Clinical Data
    Include logline forms
    Add data for non-log forms
    Add subject enrollment
    Add Adverse Event log form
    Add and verify Concomitant Medications with multiple log forms
    Add End Of Study Event
    Navigate to Subjects home page
    


Navigate to RaveEDC App and Choose study_name
    Search For  ${ca_study_group_name}  ${ca_sg_search_box}  ${ca_sg_search_button}
    Verify and click  Link  ${ca_ca_APP_Link}
    Wait For  ${ca_study_page_heading}
    Search For  ${study_name}  ${edc_stu_site_search_box}  ${edc_stu_site_search_button}
    Verify and click  Element   ${first_element_search_result}

Select a study site
    Search For  ${site_name}  ${edc_stu_site_search_box}  ${edc_stu_site_search_button}
    Verify and click  Element  ${first_element_search_result}

Add Subject
    [Arguments]  ${sbj_name}
    Verify and click  Element  ${edc_add_sbj}
    Verify and Input  ${edc_sbj_id}  ${sbj_name}
    Verify and click  Element  ${edc_save_button}

Include logline forms
    Verify and click  Element  ${edc_sbj_admin}
    Select Item From Dropdown by  Label  ${edc_add_form_dropdown}  ${edc_form_list_1}
    Verify and click  Element  ${edc_add_form}
    Select Item From Dropdown by  Label  ${edc_add_form_dropdown}  ${edc_form_list_2}
    Verify and click  Element  ${edc_add_form}
    Verify and click  Element  ${edc_sbj_home_2}

Add data for non-log forms
    Verify and click  Element  ${edc_screening_folder}
    Verify and click  Element  ${edc_scr_vst}
    Verify and click  Button  ${edc_save_button}

Add subject enrollment
    Verify and click  Element  ${edc_sbj_enroll}
    Verify and click  Button  ${edc_save_button}

Add Adverse Event log form
    Verify and click  Element  ${edc_ae_form}
    Verify and click  Button  ${edc_add_logform}
    Verify and click  Button  ${edc_save_button}

Add and verify Concomitant Medications with multiple log forms
    Verify and click  Element  ${edc_cm_form}
    Verify and click  Button  ${edc_add_logform}
    Verify and click  Button  ${edc_save_button}
    Verify and click  Button  ${edc_verify_all_fields}
    Verify and click  Element  ${edc_sbj_home_1}

Add End Of Study Event
    Verify and click  Element  ${edc_add_evt_dropdown}  
    Verify and click  Element  ${edc_evt_eos} 
    Verify and click  Element  ${edc_add_evt_button}
    Verify and click  Element  ${edc_add_sbj_cmpl}
    Verify and click  Button  ${edc_save_button}

Navigate to Subjects home page
    Verify and click  Element  ${edc_sbj_home_1}
    Verify and click  Element  ${edc_site_span}
    Verify and click  Element  ${edc_allsites_link}
