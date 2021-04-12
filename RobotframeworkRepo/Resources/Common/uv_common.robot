*** Variables ***
#Data_Preparation
${BROWSER}                          gc
${create_new_study}                 True
${common_status}                    True
${study_name}                       RF_test_study_27082020163537
${site_name}                        RF_test_study_27082020163537
${draft_name}                       RF_test_draft
${sbj_count}                        2
${edc_sbj_name}                     SBJ


#Cloud Admin
${url_ca}                          https://login-sandbox.imedidata.net/login
${ca_user}                         userid
${ca_password}                     password
${ca_user_textfield}               session_username
${ca_pass_textfield}               session_password
${ca_submit_button}                create_session_link
${ca_sg_search_box}                study_groups_search_term
${ca_sg_search_button}             study_groups_search_submit
${ca_study_group_name}             CoderMedsCD01
${ca_ca_APP_Link}                  Rave EDC
${ca_study_page_heading}           All Studies
${ca_Action_span}                  xpath=//span[contains(text(),'Actions')]
${ca_Admin_Link}                   xpath=//a[contains(text(),'Admin')]
${ca_create_study_link}            Create Study
${ca_protocolID_text_field}        study_protocol_id
${ca_Phase_dropdown}               select2-study_phase_uuid-container
${ca_common_search_box}            xpath=/html/body/span/span/span[1]/input
${ca_Phase_term}                   Phase 0
${ca_common_search_option_highlighted}  xpath=//*[@class='select2-results__option select2-results__option--highlighted']
${ca_Primary_Indication}           select2-primary_indication-container
${ca_Primary_Indication_term}      027.2: Pasteurellosis
${ca_create_study_submit_button}   create-study-submit
${ca_edit_study_button}            Edit Study
${ca_manage_sites}                 manage-sites-link
${ca_add_new_site_dropdown}        study-environment-sites-add
${ca_add_site}                     xpath=/html/body/div[3]/div/div[2]/div[2]/div/div[2]/div/ul/li[1]/a
${ca_site_name_input}              xpath=/html/body/div[3]/div/div[2]/div[2]/div/div[2]/div[1]/div/div[1]/div/input
${ca_add_new_site_link}            xpath=/html/body/div[3]/div/div[2]/div[2]/div/div[2]/div[2]/p/a
${ca_cd_org_id}                    txtClientDivisionSiteNumber
${ca_use_site_num_checkbox}        xpath=/html/body/div[3]/div/div[2]/div[2]/div/div[1]/div/div/div[2]/div[2]/fieldset[1]/div/div/div[3]/div/label/input
${ca_select_env_dropdown}          selSelectedEnvironment
${ca_env_name}                     Production 
${ca_select_country}               xpath=/html/body/div[3]/div/div[2]/div[2]/div/div[1]/div/div/div[2]/div[2]/div[1]/fieldset/div/div/div[1]/div/span/span[1]/span/span[2]/b
${ca_country_name}                 xpath=/html/body/span/span/span[2]/ul/li[3]
${ca_address1_input}               txtAddress1
${ca_address_city}                 NYC
${ca_city_input}                   txtCity
${ca_select_state}                 xpath=/html/body/div[3]/div/div[2]/div[2]/div/div[1]/div/div/div[2]/div[2]/div[1]/fieldset/div/div/div[5]/div/span/span[1]/span/span[1]
${ca_state_name}                   xpath=/html/body/span/span/span[2]/ul/li[2]
${ca_postal_code_input}            txtPostalCode
${ca_postal_code}                  12345
${ca_add_site_to_prod}             xpath=/html/body/div[3]/div/div[2]/div[2]/div/div[1]/div/div/div[2]/div[2]/div[2]/button

#Login setting
${LP_HomeImage}                     xpath=//*[@id="mcc-header"]/ul[1]/li/a/span[1]
${LP_UserSettingsLink}              name
${LP_Logout}                        logout

#Architect
${rave}                             hgsbxrave252
${url_arc}                          https://{rave}.mdsol.com/
${arc_user}                         userid
${arc_password}                     password
${arc_user_textfield}               UserLoginBox
${arc_pass_textfield}               UserPasswordBox
${arc_submit_button}                LoginButton
${arc_architect_link}               Architect
${arc_upload_draft_link}            Upload Draft
${arc_upload_input_element}         CtrlDraftFile
${arc_upload_button}                Upload
${arc_upload_success_message}       Save successful
${arc_CRF_Version_text_box}         _ctl0_Content_TxtCRFVersion
${arc_CRF_publish_button}           _ctl0_Content_BtnPublish
${arc_active_proj_table}            xpath=//*[@id="_ctl0_Content_ProjectGrid"]/tbody/tr
${arc_upload_draft_back_bbutton}    _ctl0:Content:BackBtn
${arc_draft_push_link}              xpath=//*[@id="_ctl0_Content_VersionsGrid"]/tbody/tr[1]/td[3]/a
${arc_draft_study_env_dropdown}     _ctl0:Content:StudyDDL
${arc_draft_study_env}              Prod
${arc_draft_study_env_push_button}  _ctl0_Content_PushBTN
${arc_home_link}                    _ctl0_PgHeader_HeaderImage
${arc_user_setting_link}            _ctl0_PgHeader_HomeLink
${arc_logout_link}                  _ctl0_PgHeader_LogoutLink
${arc_draft_name_after_publish}     xpath=//*[@id="_ctl0_Content_VersionGrid"]/tbody/tr[2]/td[1]


#RaveEDC
${edc_stu_site_search_box}          search-term
${edc_stu_site_search_button}       search-list-submit
${first_element_search_result}      xpath=//*[@id="main"]/div/div[2]/table/tbody/tr/td
${edc_add_sbj}                      xpath=/html/body/div[3]/div/div/div[1]/div[2]/a/span
${edc_sbj_id}                       xpath=//*[@id="field-control-area"]/div[2]/div/portrait-form-view/div/div[3]/div/div/div/div/span/span/input
${edc_save_button}                  save-button
${edc_site_span}                    xpath=//*[@id="study_environment_sites_menu"]/span[1]
${edc_allsites_link}                xpath=//*[@id="study_environment_sites"]/ul/li[2]/ul/li[2]/a
${edc_sbj_admin}                    xpath=/html/body/div[3]/div/div/div[2]/div/subject-overview/div[2]/div[2]/div/div[1]/a[2]
${edc_add_form_dropdown}            crfForms
${edc_form_list_1}                  Adverse Events
${edc_form_list_2}                  Concomitant Medications
${edc_add_form}                     addForm
${edc_screening_folder}             xpath=//*[@id="main"]/div[1]/div/div[2]/ul/ul/li/a/span[2]/span
${edc_scr_vst}                      xpath=/html/body/div[3]/div/div/div[1]/div/div[2]/ul/ul/li/ul/li[1]/a/span[2]
${edc_sbj_enroll}                   xpath=/html/body/div[3]/div/div/div[1]/div/div[2]/ul/ul/li/ul/li[7]/a/span[2]
${edc_sbj_home_1}                   xpath=/html/body/div[3]/div/div/div[2]/div/datapage/div/form/div/div[2]/form-header/div/div[1]/h6/a/span
${edc_sbj_home_2}                   xpath=/html/body/div[3]/div/div/div/div/subject-admin/div[1]/div[1]/h3/a
${edc_ae_form}                      xpath=/html/body/div[3]/div/div/div[1]/div/div[2]/ul/li[1]/a/span[2]
${edc_cm_form}                      xpath=/html/body/div[3]/div/div/div[1]/div/div[2]/ul/li[2]/a/span[2]
${edc_add_logform}                  xpath=/html/body/div[3]/div/div/div[2]/div/datapage/div/form/div/div[2]/div/div/div[2]/ul/li[3]/div/button[1]
${edc_verify_all_fields}            xpath=/html/body/div[3]/div/div/div[2]/div/datapage/div/form/div/div[2]/form-header/div/form-level-controls/div/div[2]/button[1]
${edc_add_evt_dropdown}             xpath=/html/body/div[3]/div/div/div[2]/div/subject-overview/div[2]/div[2]/subject-event/div/div/div/div[1]/span
${edc_evt_eos}                      xpath=/html/body/div[3]/div/div/div[2]/div/subject-overview/div[2]/div[2]/subject-event/div/div/div/ul/li/div[4]/span/div
${edc_add_evt_button}               xpath=/html/body/div[3]/div/div/div[2]/div/subject-overview/div[2]/div[2]/subject-event/div/div/span[2]
${edc_add_sbj_cmpl}                 xpath=/html/body/div[3]/div/div/div[2]/div/subject-overview/div[3]/subject-overview-grid/div/div/div[1]/div/table/tbody[2]/tr[10]/td[4]/div/ul/li/a/span



# MEDSAPI related
&{proxies}                    https=https://127.0.0.1:9090
${Session_Name}               MEDSAPI
${disable_warnings}           1
${ValidUserStatusCode}        200
${InValidUserStatusCode}      404
${InvalidURLStatusCode}       422
${zero}  ${0.0}

#MEDS schemas
${MEDS}                     MEDS
${MEDS_LOOKUP_SCHEMA}       MEDS_CORE

#RAVETORODS
${CRF_VERSION_ID}             447

#RODSTOMEDS
${RAVE_URL}                   ${rave}
${IMEDIDATA_SCHEMA_NAME}      imedidata_sandbox
${SUBJECT_SCHEMA_NAME}        Subjects_sandbox
${MEDS_STUDY}                 ${study_name}
${MEDS_ENV_ID}                363
${DEFAULT_LOCALE}             'eng'
@{Default_Tag}                Regression

#DALTON
${USER_UUID}            6f2c17d7-cef8-4faa-b8a1-83dd3c04f3ce

