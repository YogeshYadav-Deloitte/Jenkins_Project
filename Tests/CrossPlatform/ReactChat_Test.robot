*** Settings ***
Documentation           Post a chat in channel via API and verify the same in mobile and web and update the chat via API and verify the same
Resource                ../../Resources/PageObjects/API/AllAPI.robot
Resource                ../../Resources/Setup.robot
Resource                ../../Resources/PageObjects/Web/LoginWebPage.robot
Resource                ../../Resources/PageObjects/Web/UsernameWebPage.robot
Variables               ../../Constants/Constants.py
Resource                ../../Resources/PageObjects/Mobile/LoginMobilePage.robot
Resource                ../../Resources/PageObjects/Mobile/ProfilePage.robot
Resource                ../../Resources/PageObjects/Mobile/StatusMobilePage.robot
Resource                ../../Resources/PageObjects/Mobile/AllChannelsPage.robot
Suite Setup             Run Keywords
...                     Start Appium
...         AND         Create Appium Session
...         AND         Open chrome browser
...         AND         GO TO       ${URL}
...         AND         Lauch the API Session
Suite Teardown          Run Keywords
...                     Close appium server
...         AND         Close Browser
...         AND         Deleting new Channel via API


# robot -d Report --loglevel TRACE Tests/CrossPlatform/ReactChat_Test.robot

*** Test Cases ***
Verify create a channel API with and we verify the same in web and mobile
    # Post a chat in channel via API
    Login to Application via API
    Creating new Channel via API
    Verifying channel exist via API
    Send Chat in Channel via API

    # React to chat via API
    React emoji in channel chat via API


    # Verify the react chat in Web
    Login using email and password
    Check if the channel is created or not
    Open chat for channel or Direct Message             ${NEW_CHANNEL_NAME}
    Verify Last Mesage                                  ${POST_CHAT_IN_CHANNEL}
    Verify Reaction on Message      ${POST_CHAT_IN_CHANNEL}        ${EMOJI_NAME}


    # Verify the react chat in Mobile
    Go to Login Page
    Login with Registered Account
    Click on Direct Meassage or Created Channel mobile        ${NEW_CHANNEL_NAME}
    Verify Reaction on Message Mobile














