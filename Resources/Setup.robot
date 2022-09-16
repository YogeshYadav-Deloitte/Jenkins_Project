*** Settings ***
Documentation    Generic Methods for all Tests
Library          Process
Library          AppiumLibrary
Library          OperatingSystem
Variables        ../Libraries/ReadConfig.py
Library          ../Libraries/WebDriverSync.py
Library          ../Libraries/CustomKeyword.py
Resource         ../Resources/PageObjects/API/AllAPI.robot

*** Variables ***
${REMOTE_URL}               https://${username_cloud}:${access_key}@hub-cloud.browserstack.com/wd/hub

*** Keywords ***
Create Appium Session
    AppiumLibrary.open application    ${Port Address}    platformName=${Platform Name}	    deviceName=${Device Name}       app=${CURDIR}${/}..${/}TestData/ApkFiles/${App Name}    appPackage=${Package Name}   appActivity=${Activity Name}

Create Appium Session with BrowserStack
    AppiumLibrary.open application    app=${app_id_cloud}   remote_url=${REMOTE_URL}    device=${device_name_cloud}   name=Automating_robot_app   build=browserstack-robot-framework

Start Appium
    ${os_name} =        get os
    IF    '${os_name}' == 'win'
        Start Process       ${CURDIR}${/}../TestData/BatFiles/StartAppium.bat
    ELSE
        Start Process       sh       ${CURDIR}${/}../TestData/BatFiles/StartAppium.sh      shell=yes
       # Start Process       sh       ${CURDIR}${/}../TestData/BatFiles/StartAndriod.sh      shell=yes
    END

Close appium server
    ${os_name} =        get os
    IF    '${os_name}' == 'win'
        Start Process       ${CURDIR}${/}../TestData/BatFiles/CloseAppium.bat
    ELSE
        Start Process       sh       ${CURDIR}${/}../TestData/BatFiles/CloseAppium.sh      shell=yes
    END

Open chrome browser
    ${web_driver_path}=     Get Driver Path
    SeleniumLibrary.Create Webdriver    Chrome      executable_path=${web_driver_path}
    SeleniumLibrary.maximize browser window

Lauch the API Session
    [Arguments]             ${platform}=appium
    Login to Application via API            ${platform}

Open Chrome with block notifications
    ${web_driver_path}=     Get Driver Path
    &{prefs}=      Create Dictionary       download.default_directory=${EXECDIR}${/}TestDownloads
    ${options}=    Evaluate  sys.modules['selenium.webdriver.chrome.options'].Options()    sys,selenium.webdriver
    Built In.Call Method     ${options}    add_experimental_option    prefs     ${prefs}
    Built In.Call Method     ${options}    add_argument    --disable-notifications
    Built In.Call Method     ${options}    add_argument    --use-fake-ui-for-media-stream
  #  Built In.Call Method     ${options}    add_argument    --use-fake-device-for-media-stream

    SeleniumLibrary.Create Webdriver    Chrome      executable_path=${web_driver_path}      options=${options}
    SeleniumLibrary.maximize browser window
