*** Settings ***
Documentation     valid_Form.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Valid FieldForm
    Open Browser To Form Page
    Input FirstName       Somsong
    Input LastName        Sandee
    Input Destination     Europe
    Input ContactPerson   Sodsai Sandee
    Input Relationship    Mother
    Input Email           somsong@kkumail.com
    Input PhoneNumber     081-111-1234
    Submit SubmitBtn
    Complete Page Should Be Open
    [Teardown]    Close Browser
