*** Settings ***
Documentation    Contains Variables and Keywords for Status of User
Library          AppiumLibrary

*** Variables ***
${menu_path}                //android.view.ViewGroup[@resource-id='rooms-list-view-sidebar']
${edit_status}              //*[@class='android.view.ViewGroup'][3]/*[@text][3]
${actual_status_text_path}  //*[@bounds='[138,313][633,359]']
${status_value}             //android.widget.EditText[@content-desc='What are you doing right now?']
${status_online}            //android.view.ViewGroup[@resource-id='status-view-online']
${status_away}              //android.view.ViewGroup[@resource-id='status-view-away']/*[@text][2]
${status_busy}              //android.widget.TextView[contains(@text,"Busy")]
${save_status}              //*[@text='Done']

*** Keywords ***
Open Menu
    AppiumLibrary.wait until element is visible   ${menu_path}    10s
    AppiumLibrary.click element           ${menu_path}

Check Status
    AppiumLibrary.wait until element is visible       ${actual_status_text_path}
    ${actual_status_text}=          AppiumLibrary.get text       ${actual_status_text_path}
    Should Be Equal      ${CUSTOM_STATUS_TEXT}      ${actual_status_text}
