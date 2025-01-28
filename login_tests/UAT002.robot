*** Settings ***
Documentation     Empty Destination and Invalid Information Test Suite.
Suite Setup       Open Browser To Form Page
Suite Teardown    Close Browser
Test Template     EmptyInvalidField
Resource          resource.robot

*** Test Cases ***               FIRSTNAME        LASTNAME        DESTINATION        CONTACTPERSON        RELATIONSHIP        EMAIL                      PHONENUMBER
EmptyDestination                 Somsong          Sandee          ${EMPTY}           Sodsai Sandee        Mother              somsong@kkumail.com        081-111-1234
EmptyEmail                       Somsong          Sandee          Europe           Sodsai Sandee          Mother              ${EMPTY}                   081-111-1234
EmptyPhoneNumber                 Somsong          Sandee          Europe           Sodsai Sandee          Mother              somsong@kkumail.com        ${EMPTY}
InvalidEmail                     Somsong          Sandee          Europe           Sodsai Sandee          Mother              somsong@                   081-111-1234
InvalidPhoneNumber               Somsong          Sandee          Europe           Sodsai Sandee          Mother              somsong@kkumail.com        191

*** Keywords ***
EmptyInvalidField
    [Arguments]    ${fname}    ${lname}    ${destination}    ${contactperson}    ${relationship}    ${email}    ${phone}
    Wait Until Element Is Visible    id=firstname    timeout=5s
    Input FirstName       ${fname}
    Input LastName        ${lname}
    Input Destination     ${destination}
    Input ContactPerson   ${contactperson}
    Input Relationship    ${relationship}
    Input Email           ${email}
    Input PhoneNumber     ${phone}
    Submit SubmitBtn
    Validate Validation 

Validate Validation 
    ${current_url}=    Get Location
    Log                Current URL: ${current_url}
    Should Be Equal As Strings    ${current_url}    ${COMPLETE_URL}

