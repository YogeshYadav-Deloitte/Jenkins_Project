*** Settings ***
Documentation    Contains Variables and Keywords for Login
Library          AppiumLibrary


*** Variables ***
${open_workspace}           //*[@text='Join our open workspace']
${login_path}               //*[@text='Login']
${email_id}                 //*[@text='Username or email'][2]
${password_mobile}          //*[@text='Password'][2]
${login_button_mobile}      //android.widget.TextView[@content-desc="Login"]

*** Keywords ***
Go to Login Page
    AppiumLibrary.wait until element is visible   ${open_workspace}    20s
    AppiumLibrary.click element           ${open_workspace}
    AppiumLibrary.wait until element is visible   ${login_path}     20s
    AppiumLibrary.click element           ${login_path}

Login with Registered Account
    AppiumLibrary.wait until element is visible   ${email_id}      20s
    AppiumLibrary.input text        ${email_id}         ${user_email}
    AppiumLibrary.input text        ${password_mobile}         ${user_password}
    AppiumLibrary.click element     ${login_button_mobile}
