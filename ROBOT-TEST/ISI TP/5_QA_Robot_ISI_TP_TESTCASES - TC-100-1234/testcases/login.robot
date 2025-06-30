### testcases/login.robot

*** Settings ***
Documentation     TC-1002 - Login should succeed with valid credentials
Resource          ../resources/home_page_keywords.robot
Resource          ../resources/login_keywords.robot

Suite Setup       Préparer environnement test
Suite Teardown    Fermer le navigateur proprement
Test Teardown     Capture Screenshot If Test Failed

*** Test Cases ***
TC-1002 Valid Login Should Redirect To Contacts Page
    [Documentation]    Vérifie que le login fonctionne avec des identifiants valides
    [Tags]    smoke    login    security
    Navigate To Login Page
    Enter Valid Credentials
    Submit Login Form
    ${expected_msg}=    Set Variable    ${VALID_MSG_POST_LOGIN_${LANG}}
    Vérifier message de réussite login    ${expected_msg}
    