*** Settings ***
Documentation               This robot files includes keywords of Chat page of rocket chat in web.
Library                     SeleniumLibrary
Library                     ../../../Libraries/CustomKeyword.py
Library                     String
Library                     OperatingSystem

*** Variables ***
${mic_icon}                 //*[name()='svg'][@class='rc-icon rc-input__icon-svg rc-input__icon-svg--mic']
${mic_record_timer}         //div[@class='rc-message-box__audio-message-timer']
${done_record}              //div[@class='rc-message-box__icon rc-message-box__audio-message-done js-audio-message-done']
${done_record2}             //div[@class='rc-message-box__icon rc-message-box__audio-message-done js-audio-message-done']//*[name()='svg']
${audio_name_form}          //form[contains(@class,'rcx-box rcx-box--full rcx-css-ogq2n4')]
${audio_filename_name}       (//span[@class="rcx-box rcx-box--full rcx-field__row"]/input)[1]
${audio_description}        //input[@placeholder='Description']
${save_form_button}         //button[normalize-space()='Send']
${download_button_path}     //*[@class='rcx-box rcx-box--full rcx-message-container']/div[3]/div[2]
${audio_player}             //div//audio[@preload='metadata']
${download_path_relative}   /a/i

*** Keywords ***
Record and save audio
    SeleniumLibrary.Wait Until Element Is Visible           ${mic_icon}           10s
    SeleniumLibrary.click element           ${mic_icon}
    SeleniumLibrary.Wait Until Element Is Visible           ${mic_record_timer}             10s
    text to speech          ${TEXT TO SPEAK}
    SeleniumLibrary.click element               ${done_record}
    SeleniumLibrary.Wait Until Element Is Visible          ${audio_name_form}
    SeleniumLibrary.Wait Until Element Is Visible          ${audio_filename_name}
    SeleniumLibrary.click element             ${audio_filename_name}
    SeleniumLibrary.Input Text                locator=${audio_filename_name}         text=${AUDIO FILE NAME}           clear=True
    SeleniumLibrary.Input Text                locator=${audio_description}           text=${AUDIO FILE NAME}
    SeleniumLibrary.click element                ${save_form_button}

Check Text
    [Arguments]             ${text}                 ${string}
    ${status}=      Run Keyword And Return Status          Should Contain      ${string}       ${text}
    Return From Keyword    ${status}

Verify Message and Download Audio
    [Arguments]             ${text}=${EMPTY}
    SeleniumLibrary.wait until element is visible      ${audio_player}           15s
    ${index}=    Evaluate       0
    Set Test Variable     ${keyword_flag}     ${False}
    SeleniumLibrary.wait until element is visible      ${download_button_path}           15s
    @{download_button_list}         SeleniumLibrary.Get WebElements        ${download_button_path}
    FOR       ${msg_element}    IN      @{download_button_list}
        ${index}=    Evaluate       ${index} + 1
        ${txt}=     SeleniumLibrary.get text        ${msg_element}
        ${found_message}=    Check Text        ${text}          ${txt}
        IF     ${found_message}
            ${final_path}=     Catenate    SEPARATOR=    (     ${download_button_path}
            ${final_path}=     Catenate    SEPARATOR=    ${final_path}     ${download_path_relative}
            ${final_path}=     Catenate    SEPARATOR=    ${final_path}     )[
            ${final_path}=     Catenate    SEPARATOR=    ${final_path}     ${index}
            ${final_path}=     Catenate    SEPARATOR=    ${final_path}     ]
            SeleniumLibrary.click element        ${final_path}
            sleep       5s
            ${os_name} =        get os
            Set Test Variable     ${keyword_flag}     ${True}
            Exit For Loop
        END
    END
    Should Be True        ${keyword_flag}

Load Audio File and Verify the text
    [Arguments]             ${AUDIO FILE NAME}
    ${os_name} =        get os
    IF    '${os_name}' == 'win'
            ${audio_path}=     Set Variable     ${CURDIR}
            ${path1}	${dir} =	        Split Path	            ${audio_path}
            ${path2}	${dir1} =	        Split Path	            ${path1}
            ${path3}	${dir2} =	        Split Path	            ${path2}
            ${speech_text_audio}=           mpTHREE to text                 ${path3}${/}TestDownloads${/}${AUDIO_FILE_NAME}
    ELSE
            ${audio_path}=     Set Variable     ${CURDIR}
            ${path1}	${dir} =	        Split Path	            ${audio_path}
            ${path2}	${dir1} =	        Split Path	            ${path1}
            ${path3}	${dir2} =	        Split Path	            ${path2}
            @{all_files}=             List Files In Directory                 ${path3}${/}TestDownloads             pattern=*com.google.Chrome*
            FOR       ${file_name}    IN      @{all_files}
            Set Global Variable         ${file_name}
            END
            Set Global Variable              ${path3}
            Move file          ${path3}${/}TestDownloads${/}${file_name}                ${path3}${/}TestDownloads${/}${AUDIO FILE NAME}
            ${speech_text_audio}=       mpTHREE to text                         ${path3}${/}TestDownloads${/}${AUDIO FILE NAME}
             FOR       ${file_name}    IN      @{all_files}
                 Remove File        ${path3}${/}TestDownloads${/}${file_name}
             END
             @{all_files_mp3}=             List Files In Directory                 ${path3}${/}TestDownloads             pattern=*.mp3*
             FOR       ${file_name}    IN      @{all_files_mp3}
                 Remove File        ${path3}${/}TestDownloads${/}${file_name}
             END

    END

    log to console               ${speech_text_audio}


