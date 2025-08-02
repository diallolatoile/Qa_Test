### testcases/login_negative.robot

*** Settings ***
Documentation     TC-1003-1-2 & TC-1004 - Login should fail with missing credentials - "Remember me" should persist email address - Should be able to log out
Resource          ../resources/home_page_keywords.robot
Resource          ../resources/login_keywords.robot

Suite Setup       Préparer environnement test
Suite Teardown    Fermer le navigateur proprement
Test Teardown     Run Keywords
...               Capture Screenshot If Test Failed
...               AND    Logout User  # Nettoyage même si le test échoue

*** Test Cases ***
TC-1003-1 Empty Credentials Should Prevent Submission
    [Documentation]    Vérifie que les champs required empêchent la soumission
    [Tags]    functional    login_validation
    
    # 1. Accès à la page de login
    Navigate To Login Page
    
    # 2. Tentative de soumission sans données
    Click Element    ${LOGIN_SUBMIT_BUTTON}

    # 3. Validations
    Verify Required Fields Enforcement
    ${expected_msg}=    Set Variable    ${INVALID_MSG_LOGIN_${LANG}}
    Vérifier message d'échec login    ${expected_msg}
    Page Should Not Contain Element    ${CONTACTS_TABLE}

TC-1003-2 Remember Me Should Persist Email
    [Documentation]    Vérifie la persistance de l'email avec "Remember me"
    [Tags]    functional    remember persistence
    # 1. Accès à la page de login
    Navigate To Login Page
    
    # 2. Login avec "Remember me"
    Enter Valid Credentials
    Enable Remember Me
    Submit Login Form
    
    # 3. Logout puis nouvelle tentative
    Logout User
    ${expected_msg}=    Set Variable    ${VALID_MSG_POST_LOGOUT_${LANG}}
    Vérifier message de réussite logout    ${expected_msg}
    Navigate To Login Page
    
    # 4. Vérification
    Enter Valid Credentials
    Verify Email Persistence

TC-1004 Should be able to log out
    [Documentation]    Vérifie que la déconnexion est normale
    [Tags]    functional    logout
    # 1. Accès à la page de login
    Navigate To Login Page
    
    # 2. Login avec "Remember me"
    Enter Valid Credentials
    Submit Login Form
    
    # 3. Logout puis nouvelle tentative
    Logout User
    ${expected_msg}=    Set Variable    ${VALID_MSG_POST_LOGOUT_${LANG}}
    Vérifier message de réussite logout    ${expected_msg}
    