*** Settings ***
Documentation    This robot files includes keywords of login page of rocket chat in web.
Library          SeleniumLibrary
Library          Collections

*** Variables ***
#${STATUS}                   Busy
#${NEW_CHANNEL_NAME}         Rajaji12341115
#${CUSTOM_STATUS_TEXT}       NHK NHK
${profile}                  //*[@class='rcx-avatar__element rcx-avatar__element--x24']
${status_symbol}            //div[@class='rcx-box rcx-box--full rcx-css-1ymtx1o']/span[1]
${title_status}             title
${custom_status}            //li[@class='rcx-option'][5]/div/div[2]
${status_message_box}       //input[@type='text']
${save_button}              //button[contains(@class,'primary rcx-button')]
${current_status}           //div[contains(@class,'rcx-css-1te28na')]
${create_new_button}        //*[contains(@class,'rcx-icon--name-edit-rounded')]
${channel_option}           //li[@class='rcx-option'][1]
${channel_name_box}         //input[@placeholder='Channel Name']
${create_button}            //button[@data-qa-type='create-channel-confirm-button']
${list_channels}            //div[@class='rc-box rcx-box--full rcx-sidebar-item__container rcx-sidebar-item__content ']/div[1]/div[2]
${call_messages_path}       //div[@class='rcx-message']/div[2]/div[2]/div[2]/div/div/span/span/em
${all_message_path}         //div[@class='rcx-message']/div[2]/div[2]/div[1]/p
${buttons_list}             //button[@type='button']
${ongoing_call_text}        Is calling.
${all_message_container}    //*[@class='rcx-box rcx-box--full rcx-message-container']

*** Keywords ***
Go to profile section and check status
    SeleniumLibrary.wait until element is visible               ${profile}
    SeleniumLibrary.click element                                ${profile}
    SeleniumLibrary.wait until element is visible               ${status_symbol}
    Element Attribute Value Should Be            ${status_symbol}               ${title_status}          ${STATUS}
    SeleniumLibrary.Capture Page Screenshot

Go to profile section and select custom status
    SeleniumLibrary.wait until element is visible               ${profile}                     15s
    SeleniumLibrary.click element                                ${profile}
    SeleniumLibrary.click element                                ${custom_status}
    SeleniumLibrary.Capture Page Screenshot

Enter custom status and save it
    SeleniumLibrary.input text                                   ${status_message_box}          ${CUSTOM_STATUS_TEXT}
    SeleniumLibrary.click element                                ${save_button}

Verify the correct status is displayed
    SeleniumLibrary.wait until element is visible               ${profile}           20s
    SeleniumLibrary.click element                                ${profile}
    SeleniumLibrary.Capture Page Screenshot
    SeleniumLibrary.Element Text Should Be                       ${current_status}              ${CUSTOM_STATUS_TEXT}
    SeleniumLibrary.Capture Page Screenshot

Select Create new option and add a channel
    SeleniumLibrary.wait until element is visible               ${create_new_button}           10s
    SeleniumLibrary.click element                                ${create_new_button}
    SeleniumLibrary.wait until element is visible                  ${channel_option}
    SeleniumLibrary.click element                                ${channel_option}
    SeleniumLibrary.input text                                   ${channel_name_box}            ${NEW_CHANNEL_NAME}
    SeleniumLibrary.Double click element                         ${create_button}
    sleep       2s

Check if the channel is created or not
    SeleniumLibrary.wait until element is visible      ${list_channels}           15s
    @{channels_name} =   Create List
    @{channels}         SeleniumLibrary.Get WebElements        ${list_channels}
    FOR       ${channel}    IN      @{channels}
        Log   ${channel.text}
        Append To List            ${channels_name}                 ${channel.text}
    END
    list should contain value     ${channels_name}                 ${new_channel_name}
    SeleniumLibrary.Capture Page Screenshot

Go To Profile and Verify the Custom Status and icon
    SeleniumLibrary.wait until element is visible               ${profile}
    SeleniumLibrary.click element                                ${profile}
    SeleniumLibrary.wait until element is visible               ${status_symbol}
    Element Attribute Value Should Be            ${status_symbol}               ${title_status}          ${status}
    SeleniumLibrary.Element Text Should Be                       ${current_status}              ${CUSTOM_STATUS_TEXT}
    SeleniumLibrary.Capture Page Screenshot

Open chat for channel or Direct Message
    [Arguments]             ${channel_or_direct_msg}=${DIRECT_MESSAGE_NAME}
    SeleniumLibrary.wait until element is visible      ${list_channels}           15s
    @{channels}         SeleniumLibrary.Get WebElements        ${list_channels}
    FOR       ${channel}    IN      @{channels}
        log   ${channel.text}
        IF   '${channel.text}' == '${channel_or_direct_msg}'
            SeleniumLibrary.click element     ${channel}
            Exit For Loop
        END
    END

Verify Incomming Call Mesage
    SeleniumLibrary.wait until element is visible      ${call_messages_path}           15s
    @{call_messages_list}         SeleniumLibrary.Get WebElements        ${call_messages_path}
    @{message_list} =   Create List
    FOR       ${message}    IN      @{call_messages_list}
        ${txt}=     SeleniumLibrary.get text        ${message}
        Append To List              ${message_list}           ${txt}
    END
    list should contain value     ${message_list}                 ${ongoing_call_text}

Verify Last Mesage
    [Arguments]         ${message_text_to_verify}
    SeleniumLibrary.wait until element is visible      ${all_message_path}           15s
    @{all_message_list}         SeleniumLibrary.Get WebElements        ${all_message_path}
    @{message_list_mobile} =    Create List
    FOR       ${message_txt}    IN      @{all_message_list}
        ${txt}=     SeleniumLibrary.get text        ${message_txt}
        Append To List              ${message_list_mobile}           ${txt}
    END
    reverse list                ${message_list_mobile}
    should be equal      ${message_list_mobile}[0]              ${message_text_to_verify}

Check Text is available in String or Not
    [Arguments]             ${text}                 ${string}
    ${status}=      Run Keyword And Return Status          Should Contain      ${string}       ${text}
    Return From Keyword    ${status}

Verify Reaction on Message
    [Arguments]             ${text_1}                 ${text_2}=${EMPTY}
    Set Test Variable     ${keyword_flag}     ${False}
    SeleniumLibrary.wait until element is visible      ${all_message_container}           15s
    @{all_message_container_list}         SeleniumLibrary.Get WebElements        ${all_message_container}
    FOR       ${msg_element}    IN      @{all_message_container_list}
        ${txt}=     SeleniumLibrary.get text        ${msg_element}
#        Log       ${txt}
        ${found_message}=    Check Text is available in String or Not        ${text_1}          ${txt}
#        log     ${found_message}
        IF     ${found_message}
            ${found_emoji}=    Check Text is available in String or Not      ${text_2}          ${txt}
#            log     ${found_emoji}
            IF    ${found_emoji}
                Set Test Variable     ${keyword_flag}     ${True}
                Exit For Loop
            END
        END
    END
    Should Be True        ${keyword_flag}
