*** Settings ***
Documentation           Create the channel in Application
Resource                ../../Resources/PageObjects/API/AllAPI.robot
Resource                ../../Resources/Setup.robot
Resource                ../../Resources/PageObjects/Web/LoginWebPage.robot
Resource                ../../Resources/PageObjects/Web/StatusWebPage.robot
Variables               ../../Constants/Constants.py
Library                 SeleniumLibrary
Resource                ../../Resources/PageObjects/Mobile/LoginMobilePage.robot
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


# robot -d Report --loglevel TRACE Tests/CrossPlatform/VerifyChannelExists_Test.robot

*** Test Cases ***
Status Change Through API and Confirming in Web and Mobile

        # verifying the same on Web
        GO TO       ${URL}
        Login using email and password
        Select Create new option and add a channel
        Check if the channel is created or not

        # verifying the same on Mobile
        Go to Login Page
        Login with Registered Account
        Verify Newly Created Channel

        # API Creates the Channel
        Verifying channel exist via API











