*** Settings ***
Documentation    Contains Variables and Keywords for Login
Library          AppiumLibrary

*** Variables ***
${open_workspace}           //*[@text='Join our open workspace']
${login_path}               //*[@text='Login']
${email_id}                 //*[@text='Username or email'][2]
${password_mobile}          //*[@text='Password'][2]
${login_button_mobile}      //android.widget.TextView[@content-desc="Login"]
${open_Space_Btn}           //*[@resource-id="new-server-view-open"]
${login_Btn}                //*[@resource-id="workspace-view-login"]
${username_Field}           //*[@content-desc="Username or email"]
${password_Field}           //*[@content-desc="Password"]
${submit_btn}               //*[@resource-id="login-view-submit"]
${error_msg}                //*[@resource-id="android:id/message"]
${REMOTE_URL}               https://${username_cloud}:${access_key}@hub-cloud.browserstack.com/wd/hub

*** Keywords ***
Go to Login Page c
    AppiumLibrary.wait until element is visible   ${open_workspace}    20s
    AppiumLibrary.click element           ${open_workspace}
    AppiumLibrary.wait until element is visible   ${login_path}     20s
    AppiumLibrary.click element           ${login_path}

Login with Registered Account c
    AppiumLibrary.wait until element is visible   ${email_id}      20s
    AppiumLibrary.input text        ${email_id}         ${user_email}
    AppiumLibrary.input text        ${password_mobile}         ${user_password}
    AppiumLibrary.click element     ${login_button_mobile}

login with credientials
    [Arguments]     ${username}=appiumtesting7@gmail.com     ${password}=appiumtesting7
    AppiumLibrary.wait until element is visible   ${open_Space_Btn}   15s
    AppiumLibrary.click element   ${open_Space_Btn}
    AppiumLibrary.wait until element is visible   ${login_Btn}   15s
    AppiumLibrary.click element   ${login_Btn}
    AppiumLibrary.wait until element is visible   ${username_Field}   15s
    AppiumLibrary.input text  ${username_Field}   ${username}
    AppiumLibrary.wait until element is visible   ${password_Field}   15s
    AppiumLibrary.input text  ${password_Field}   ${password}
    AppiumLibrary.wait until element is visible   ${submit_btn}   15s
    AppiumLibrary.click element   ${submit_btn}


Open app in CLOUD APK
    open application    app=${app_id_cloud}   remote_url=${REMOTE_URL}    device=${device_name_cloud}   name=Automating_robot_app   build=browserstack-robot-framework
    sleep   5s
