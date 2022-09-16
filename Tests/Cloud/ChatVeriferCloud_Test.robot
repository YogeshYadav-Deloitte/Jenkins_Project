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
...                     Create Appium Session with BrowserStack
...         AND         Open chrome browser
...         AND         GO TO       ${URL}
...         AND         Lauch the API Session
Suite Teardown          Close Browser


# robot -d Report --loglevel TRACE Tests/Cloud/ChatVeriferCloud_Test.robot

*** Test Cases ***
Verify create a channel API with and we verify the same in web and mobile
    # Post a chat in channel via API
    Login to Application via API
    Creating new Channel via API
    Verifying channel exist via API
    Send Chat in Channel via API

    # Verify the chat in Web
    Login using email and password
    Check if the channel is created or not
    Open chat for channel or Direct Message             ${NEW_CHANNEL_NAME}
    Verify Last Mesage                                  ${POST_CHAT_IN_CHANNEL}

    # Verify the chat in mobile
    Go to Login Page
    Login with Registered Account
    Click on Direct Meassage or Created Channel mobile         ${NEW_CHANNEL_NAME}
    Verify Last Message Display         ${POST_CHAT_IN_CHANNEL}

    # update the chat via API
    Update Chat in channel via API

    sleep  1s
     # Verify the updated chat in Web
    Open chat for channel or Direct Message                 ${NEW_CHANNEL_NAME}
    Verify Last Mesage                                      ${UPDATE_CHAT_IN_CHANNEL}

    # Verify the chat in moble
    Verify Last Message Display                             ${UPDATE_CHAT_IN_CHANNEL}
