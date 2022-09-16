*** Settings ***
Documentation    Contains Variables and Keywords for All Channels List
Library          AppiumLibrary
Library          Collections

*** Variables ***
${channel_dynamic_path}        //*[@text='${NEW_CHANNEL_NAME}']
${incomming_call_message}      //*[@text='Is calling.']
${incomming_call_path}         //*[@text='Join call']
${last_message_path}           //android.widget.ScrollView[@resource-id='room-view-messages']/*[@class='android.view.ViewGroup']/*[@class='android.view.ViewGroup']/*[@class='android.view.ViewGroup']/*[@class='android.widget.TextView']
${emoji_path}                  //*[@resource-id='message-reaction-:${EMOJI_NAME}:']
${channel_dynamic_path}        //*[@text='${NEW_CHANNEL_NAME}']


*** Keywords ***
Verify Newly Created Channel
    AppiumLibrary.wait until element is visible       ${channel_dynamic_path}      10s
    AppiumLibrary.page should contain element         ${channel_dynamic_path}

Click on Direct Meassage or Created Channel mobile
    [Arguments]         ${channel_name}=${DIRECT_MESSAGE_NAME}
    AppiumLibrary.wait until element is visible       //*[@text='${channel_name}']      10s
    AppiumLibrary.click element        //*[@text='${channel_name}']
#    AppiumLibrary.click element        //*[@text='${channel_name}']

Verify Incomming Call
    AppiumLibrary.wait until element is visible       ${incomming_call_message}           10s
    AppiumLibrary.page should contain element         ${incomming_call_message}
    AppiumLibrary.page should contain element         ${incomming_call_path}

Verify Last Message Display
    [Arguments]         ${message_to_verify}
    AppiumLibrary.wait until element is visible       ${last_message_path}         10s
    @{message_list_mob} =         Create List
    @{last_message_list}=         AppiumLibrary.Get WebElements        ${last_message_path}
    FOR       ${messages_elements}    IN      @{last_message_list}
        ${txt}=    AppiumLibrary.get text         ${messages_elements}
        Append To List              ${message_list_mob}           ${txt}
    END
    list should contain value      ${message_list_mob}              ${message_to_verify}

Verify Reaction on Message Mobile
    AppiumLibrary.wait until element is visible        ${emoji_path}
    AppiumLibrary.element should be enabled            ${emoji_path}
