*** Settings ***
Documentation            Create a channel API with and we verify the same in web and mobile
Resource                ../../Resources/PageObjects/API/AllAPI.robot
Resource                ../../Resources/Setup.robot
Resource                ../../Resources/PageObjects/Web/LoginWebPage.robot
Resource                ../../Resources/PageObjects/Web/UsernameWebPage.robot
Variables               ../../Constants/Constants.py
Resource                ../../Resources/PageObjects/Mobile/LoginMobilePage.robot
Resource                ../../Resources/PageObjects/Mobile/ProfilePage.robot
Resource                ../../Resources/PageObjects/Mobile/StatusMobilePage.robot
Resource                ../../Resources/PageObjects/Mobile/AllChannelsPage.robot
Resource                ../../Resources/PageObjects/Cloud/LoginPageCloud.robot


#Suite Setup             Run Keywords
#...                     Open chrome browser
#...         AND         Open app in CLOUD APK
#...         AND         GO TO       ${URL}
##...         AND         Lauch the API Session
#Suite Teardown          Run Keywords
#...                     Close Browser
##...         AND         Deleting new Channel via API


# robot -d Report --loglevel TRACE Tests/Cloud/Cloud.robot

*** Test Cases ***
Verify create a channel API with and we verify the same in web and mobile
        Open app in CLOUD APK
        login with credientials













