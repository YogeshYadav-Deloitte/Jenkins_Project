*** Settings ***
Documentation            Change the UserName in Application via mobile and verifying the same in web and API
Resource                ../../Resources/PageObjects/API/AllAPI.robot
Resource                ../../Resources/Setup.robot
Resource                ../../Resources/PageObjects/Web/LoginWebPage.robot
Resource                ../../Resources/PageObjects/Web/UsernameWebPage.robot
Variables               ../../Constants/Constants.py
Resource                ../../Resources/PageObjects/Mobile/LoginMobilePage.robot
Resource                ../../Resources/PageObjects/Mobile/ProfilePage.robot
Resource                ../../Resources/PageObjects/Mobile/StatusMobilePage.robot
Suite Setup             Run Keywords
...                     Start Appium
...         AND         Create Appium Session
...         AND         Open chrome browser
...         AND         GO TO       ${URL}
Suite Teardown          Run Keywords
...                     Close appium server
...         AND         Close Browser

# robot -d Report --loglevel TRACE Tests/CrossPlatform/ChangeUserName_Test.robot

*** Test Cases ***
Change the UserName in Application via mobile and verifying the same in web and API
        # Change the userName in Mobile
        Go to Login Page
        Login with Registered Account
        Open Menu
        Go To Profile Page
        Update Name In Profile

        # verifying the same thing in Web
         GO TO       ${URL}
        Login using email and password
        Go to profile section and select my account
        Check and verify the username

        # verifying the same in API
        Login to Application with UserName via API




