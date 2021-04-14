*** Variables ***
${BROWSER} =  gc

${URL} =  https://login-sandbox.imedidata.net/login

${DbConString} =  database='db_lab',user='postgres',password='postgres',host='127.0.0.1',port=51203


#Login page
${LP_LoginTextBox} =  id=session_username
${LP_PasswordTextBox} =  id=session_password
${LP_LoginButton} =  id=create_session_link
#${LP_LoginUserName} =  svarma+201@mdsol.com
${LP_LoginUserName} =  svarma+201
${LP_LoginPassword} =  myPassword
${LP_HomeImage} =  xpath=//*[@id="mcc-header"]/ul[1]/li/a/span[1]
${LP_UserSettingsLink} =  id=name
${LP_Logout} =  id=logout

#Home Page
${StudySecHeading} =  Studies
${HP_MEDSIngestorAppLink} =  xpath=//*[@id="app_3408"]/a

#MEDSIngestor Page
${MEDSIngestorHeading} =  MEDS Ingestor
${ImportJobLink} =  xpath=//*[@id="ingestion-job-list"]/table/tbody/tr/td/a[2]/span[contains(text(), '01DemoDataIntegration')]
#${ImportJobLink} =  xpath=//*[@id="ingestion-job-list"]/table/tbody/tr/td/a[2]/span[contains(text(), 'DemoDataIntegration')]
${ImportNewDataHeading} =  Imported Data
${ImportNewDataFile} =  xpath=//*[@id="main"]/div/div/div[3]/div/input
#${ImportFilePath} =  /Users/svarma/RobotFramework/RF_T93_POC/Files/
#${CSVFilePath} =  /Users/svarma/RobotFramework/RF_T93_POC/Results/EndResult.csv
#${ScreenhotFilePath} =  /Users/svarma/RobotFramework/RF_T93_POC/Results/
${ImportFilePath} =  ${CURDIR}/Files
${CSVFilePath} =  ${CURDIR}/Results/EndResult.csv
${ScreenhotFilePath} =  ${CURDIR}/Results/
${ImportFileMessageDiv} =  xpath=//*[@id="main"]/span/span/div[2]/span/div/div/div[2]/div[1]
${data_integration_version_uuid} =  'fe68d3e6-24d0-49f8-a194-f4e8bd006bbb'
#${data_integration_version_uuid} =  'e8470b00-ef86-4ca4-b755-ba3622255765'
${DB_Message}
