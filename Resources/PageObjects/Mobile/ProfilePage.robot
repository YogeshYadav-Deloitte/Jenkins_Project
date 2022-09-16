*** Settings ***
Documentation    Contains Variables and Keywords for All Channels List
Library          AppiumLibrary

*** Variables ***
${profile_path_mobile}        //*[@bounds='[138,604][633,650]']
${name_path_mobile}           //android.widget.EditText[@content-desc='Username']
${save_changes_mobile}        //*[@text='Save Changes']


*** Keywords ***
Go To Profile Page
    AppiumLibrary.wait until element is visible      ${profile_path_mobile}     10s
    AppiumLibrary.click element                      ${profile_path_mobile}
    AppiumLibrary.click element                      ${profile_path_mobile}

Update Name In Profile
    AppiumLibrary.wait until element is visible      ${name_path_mobile}
    AppiumLibrary.input text           ${name_path_mobile}        ${NEW_NAME}
    AppiumLibrary.click element                      ${save_changes_mobile}
