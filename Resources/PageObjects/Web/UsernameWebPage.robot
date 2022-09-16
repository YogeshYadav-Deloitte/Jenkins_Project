*** Settings ***
Documentation    This robot files includes keywords of useranme page of rocket chat in web.
Library          SeleniumLibrary

*** Variables ***
#${NEW_NAME}                 CustomUsername123
${attribute_value}          value
${my_account}               //li[@class='rcx-option'][6]/div/div[2]
${username_box}             //div[contains(@class,'rcx-css-1mtti08')]/div[2]/span/label/input

*** Keywords ***
Go to profile section and select my account
    SeleniumLibrary.wait until element is visible                ${profile}                     15s
    SeleniumLibrary.click element                                ${profile}
    SeleniumLibrary.click element                                ${my_account}
Check and verify the username
    SeleniumLibrary.wait until element is visible                 ${username_box}
    SeleniumLibrary.Element Attribute Value Should Be             ${username_box}              ${attribute_value}          ${NEW_NAME}


