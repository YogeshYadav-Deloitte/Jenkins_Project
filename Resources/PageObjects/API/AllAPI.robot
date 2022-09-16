*** Settings ***
Documentation           Login
Library                 RequestsLibrary
Library                 JSONLibrary
Library                 Collections
Library                 ../../../Libraries/CustomKeyword.py
Variables               ../../../Libraries/ReadConfig.py
Variables               ../../../Constants/Constants.py
Resource                ../../../Resources/PageObjects/Web/StatusWebPage.robot


*** Variables ***

${payload_create_channel}            {"name":"${NEW_CHANNEL_NAME}","members":[],"readOnly":false,"extraData":{"description":"","broadcast":false,"encrypted":false,"federated":false}}
${call_payload}                      {"roomId": "78tYkCQGHSadokM5ZQne5rerbycRdcWDqy", "allowRinging": true}
${boolean_react_payload}             {"messageId": "4D6n96FnGo7BjiL3c", "emoji": "headdesk", "shouldReact": true }



*** Keywords ***
# Login to Application with email and password
Login to Application via API
    [Arguments]             ${platform}=appium
    IF        "${platform}" == "appium"
    ${response}=        POST                  ${login_url}        json=${login payload}     expected_status=200
    ELSE
     ${response}=        POST                  ${login_url}        json=${login payload2}     expected_status=200
    END
    ${userID_API}=      user id from response   ${response.json()}
    Set Global Variable         ${userID_API}
    ${authToken_API}=    token from response     ${response.json()}
    Set Global Variable         ${authToken_API}



# Login to Application by using userName and password
Login to Application with UserName via API
    ${response}=        POST                  ${login_url}        json=${login_username_payload}     expected_status=200
    ${userID_API}=      user id from response   ${response.json()}
    Set Global Variable         ${userID_API}
    ${authToken_API}=    token from response     ${response.json()}
    Set Global Variable         ${authToken_API}

# Update Status API
Updating Status Text and Status via API
    ${str}=         convert to lower case            ${STATUS}
    &{payload_status}=     Create Dictionary        message=${CUSTOM_STATUS_TEXT}          status=${str}
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    ${response}=        POST                  ${Status_url}        data=${payload_status}    headers=${headers}      expected_status=200

# Create Channel API
Creating new Channel via API
    &{create_channel_payload}=        payload to dict2       ${payload_create_channel}
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    ${response}=        POST                  ${create_channel_url}        json=${create_channel_payload}    headers=${headers}      expected_status=200
    ${channel_id_api}=    channelID from response         ${response.json()}
    Set Global Variable         ${channel_id_api}

# Verify channel name
Verifying channel exist via API
     &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
     ${response}=        GET                  ${verify_channel_url}${NEW_CHANNEL_NAME}          headers=${headers}      expected_status=200
     ${exists_channel}=     Get From dictionary             ${response.json()}             exists
     Should be equal as strings            ${exists_channel}           True

# Delete Channel API
Deleting new Channel via API
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    &{sdata}=        Create Dictionary          roomId=${channel_id_api}
    ${response}=        POST                  ${delete_channel_url}        json=${sdata}    headers=${headers}      expected_status=200

# Update User Name API
Update username via API
    &{sdata}=        payload to dict      UpdateUserName
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    ${response}=        POST                  ${update_username_url}        json=${sdata}    headers=${headers}      expected_status=200


Call in Application via API
    &{sdata}=        payload to dict2       ${call_payload}
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    ${response}=        POST                  ${call_directChat_url}        json=${sdata}    headers=${headers}      expected_status=200
    ${response_checker}=        call paylaod verifier           ${response.json()}
    Should be equal as strings            ${response_checker}           True

Send Chat in Channel via API
    &{post_chat_channel_payload}=           Create Dictionary      channel=${channel_id_api}  text=${POST CHAT IN CHANNEL}
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    ${response}=        POST                  ${chat_postInChannel_url}        json=${post_chat_channel_payload}    headers=${headers}      expected_status=200
    ${messageID_api}=           messageId from payload              ${response.json()}
    Set Global Variable         ${messageID_api}


Update Chat in channel via API
    &{update_chat_channel_payload}=           Create Dictionary        roomId=${channel_id_api}         msgId=${messageID_api}       text=${UPDATE CHAT IN CHANNEL}
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    ${response}=        POST                  ${update_chatInChannel_url}        json=${update_chat_channel_payload}    headers=${headers}      expected_status=200


React emoji in channel chat via API
    ${bool}=     Convert To Boolean           true
    &{update_chat}=           Create Dictionary         messageId=${messageID_api}          emoji=${EMOJI NAME}             shouldReact=${bool}
    &{headers}=      Create Dictionary        X-Auth-Token=${authToken_API}     X-User-Id=${userID_API}
    ${response}=        POST              ${chat react url}         data=${update_chat}       headers=${headers}               expected_status=200
    ${chat_success}=            chat emoji success              ${response.json()}
    Should be equal as strings              ${chat_success}                 True
