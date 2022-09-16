*** Settings ***
Documentation    This robot files includes keywords of login page of rocket chat in web.
Library          SeleniumLibrary

*** Variables ***
${email}            //input[@id='emailOrUsername']
${password}         //input[@id='pass']
${login_button}     //*[@class='rc-button rc-button--primary login']

*** Keywords ***
Login using email and password
    SeleniumLibrary.wait until element is visible      ${email}           30s
    SeleniumLibrary.input text       ${email}           ${user_email}
    SeleniumLibrary.input text       ${password}        ${user_password}
    SeleniumLibrary.click element   ${login_button}
    SeleniumLibrary.Capture Page Screenshot
