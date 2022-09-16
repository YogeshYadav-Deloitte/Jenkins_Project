*** Settings ***
Documentation           Change the Status in Application
Resource                ../../Resources/PageObjects/API/AllAPI.robot
Resource                ../../Resources/Setup.robot
Resource                ../../Resources/PageObjects/Web/LoginWebPage.robot
Resource                ../../Resources/PageObjects/Web/StatusWebPage.robot
Variables               ../../Constants/Constants.py
Resource                ../../Resources/PageObjects/Mobile/LoginMobilePage.robot
Resource                ../../Resources/PageObjects/Mobile/StatusMobilePage.robot
Suite Setup             Run Keywords
...                     Create Appium Session with BrowserStack
...         AND         Open chrome browser
...         AND         GO TO       ${URL}
...         AND         Lauch the API Session
Suite Teardown          Close Browser


# robot -d Report --loglevel TRACE Tests/Cloud/ChangeStatusCloud_Test.robot

*** Test Cases ***
Status change through API and confirming the same in Web and Mobile
        # Updates the Status via API
        Updating Status Text and Status via API

        # verifying the same on Web
        GO TO       ${URL}
        Login using email and password
        Go To Profile and Verify the Custom Status and icon

        # verifying the same on mobile
        Go to Login Page
        Login with Registered Account
        Open Menu
        Check Status

