*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}                localhost:7272
${BROWSER}               Chrome
${DELAY}                 0
${VALID USER}            demo
${VALID PASSWORD}        mode
${LOGIN URL}             http://${SERVER}/
${WELCOME URL}           http://${SERVER}/welcome.html
${ERROR URL}             http://${SERVER}/error.html
${FORM URL}              http://${SERVER}/Form.html
${Complete URL}          http://${SERVER}/Complete.html
${CHROME_BROWSER_PATH}   /usr/bin/google-chrome
${CHROME_DRIVER_PATH}    /usr/bin/chromedriver

                        

*** Keywords ***
Open Browser To Login Page
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Set Variable          ${chrome_options.binary_location}    ${CHROME_BROWSER_PATH}
    Call Method           ${chrome_options}    add_argument    --no-sandbox

    ${service}=           Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path="${CHROME_DRIVER_PATH}")    sys
    Create Webdriver      Chrome    options=${chrome_options}    service=${service}

    Go To                 ${LOGIN URL}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Open Browser To Form Page
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Set Variable          ${chrome_options.binary_location}    ${CHROME_BROWSER_PATH}
    Call Method           ${chrome_options}    add_argument    --no-sandbox

    ${service}=           Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path="${CHROME_DRIVER_PATH}")    sys
    Create Webdriver      Chrome    options=${chrome_options}    service=${service}

    Go To                 ${FORM URL}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Form Page Should Be Open


Login Page Should Be Open
    Title Should Be    Login Page

Form Page Should Be Open
    Title Should Be    Customer Inquiry

Input Username
    [Arguments]    ${username}
    Input Text    id=username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    id=password_field    ${password}

Submit Credentials
    Click Button    id=login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be       Welcome Page

Input FirstName
    [Arguments]    ${fname}
    Input Text    id=firstname    ${fname}

Input LastName
    [Arguments]    ${lname}
    Input Text    id=lastname    ${lname}

Input Destination 
    [Arguments]    ${destination}
    Input Text    id=destination    ${destination}

Input ContactPerson
    [Arguments]    ${contactperson}
    Input Text    id=contactperson    ${contactperson}

Input Relationship
    [Arguments]    ${relationship}
    Input Text    id=relationship    ${relationship}

Input Email
    [Arguments]    ${email}
    Input Text    id=email    ${email}

Input PhoneNumber
    [Arguments]    ${phone}
    Input Text    id=phone    ${phone}

Submit SubmitBtn
    Click Button    id=submitButton 

Complete Page Should Be Open
    ${current_url}=    Get Location
    Log                Current URL: ${current_url}
    ${base_url}=       Evaluate    "${current_url}".split('?')[0]
    Should Be Equal As Strings    ${base_url}    ${COMPLETE_URL}
    Title Should Be               Completed
    Page Should Contain           Our agent will contact you shortly.
    Page Should Contain           Thank you for your patient.



