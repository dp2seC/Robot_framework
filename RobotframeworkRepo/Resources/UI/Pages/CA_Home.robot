*** Keywords ***
Open Medidata and Login
    Load Website  ${url_ca}
    Login to Website  ${ca_user}  ${ca_password}  
    ...  ${ca_user_textfield}  ${ca_pass_textfield}  ${ca_submit_button}
