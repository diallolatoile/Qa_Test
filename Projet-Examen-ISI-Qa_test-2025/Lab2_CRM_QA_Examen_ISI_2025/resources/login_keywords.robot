### resources/login_keywords.robot

*** Settings ***
Library     SeleniumLibrary
Variables   ../pageobject/locator.py
Variables   ../pageobject/variables.py
Variables   ../pageobject/testdata.py

*** Keywords ***
Navigate To Login Page
    [Documentation]    Clique sur le lien Login depuis la homepage
    Click Element    ${LOGIN_LINK}
    Wait Until Page Contains Element    ${LOGIN_EMAIL}    10s

Vérifier message de réussite login
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message de succès attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    ${CUSTOMERS_PAGE_TEXT}
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${VALID_MSG_CUSTOMERS_PAGE_en}' in '${page_text}'    Log    Message trouvé en anglais : ${VALID_MSG_CUSTOMERS_PAGE__en}    console=True
    ...    ELSE IF    '${VALID_MSG_CUSTOMERS_PAGE_fr}' in '${page_text}'    Log    Message trouvé en français : ${VALID_MSG_CUSTOMERS_PAGE__fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${VALID_MSG_CUSTOMERS_PAGE_en}', '${VALID_MSG_CUSTOMERS_PAGE__fr}') n'a été trouvé.

#TC-1002
Enter Valid Credentials
    [Documentation]    Saisit des identifiants valides
    Input Text    ${LOGIN_EMAIL}    ${VALID_USERNAME_AUTOMATION}
    Input Password    ${LOGIN_PASSWORD}    ${VALID_PASSWORD_AUTOMATION}

#TC-1003-1
Vérifier message d'échec login
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message d'échec attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    ${LOGIN_PAGE_TEXT}
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${INVALID_MSG_LOGIN_en}' in '${page_text}'    Log    Message trouvé en anglais : ${INVALID_MSG_LOGIN_en}    console=True
    ...    ELSE IF    '${INVALID_MSG_LOGIN_fr}' in '${page_text}'    Log    Message trouvé en français : ${INVALID_MSG_LOGIN_fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${INVALID_MSG_LOGIN_en}', '${INVALID_MSG_LOGIN_fr}') n'a été trouvé.

Verify Required Fields Enforcement
    [Documentation]    Vérifie que les champs obligatoires bloquent la soumission
    # Vérifie les attributs HTML5 required
    Element Attribute Value Should Be    ${LOGIN_EMAIL}    required    true
    Element Attribute Value Should Be    ${LOGIN_PASSWORD}    required    true
    
    # Vérifie que le formulaire n'est pas soumis
    Wait Until Element Is Visible    ${LOGIN_FORM}    5s

#TC-1003-2
Enable Remember Me
    [Documentation]    Coche la case "Remember me"
    Select Checkbox    ${REMEMBER_ME}

Logout User
    [Documentation]    Effectue la déconnexion
    Click Element    ${LOGOUT_LINK}
    
Vérifier message de réussite logout
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message de succès attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    ${LOGOUT_SUCCESS_TEXT}
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${VALID_MSG_POST_LOGOUT_en}' in '${page_text}'    Log    Message trouvé en anglais : ${VALID_MSG_POST_LOGOUT_en}    console=True
    ...    ELSE IF    '${VALID_MSG_POST_LOGOUT_fr}' in '${page_text}'    Log    Message trouvé en français : ${VALID_MSG_POST_LOGOUT_fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${VALID_MSG_POST_LOGOUT_en}', '${VALID_MSG_POST_LOGOUT_fr}') n'a été trouvé.

Verify Email Persistence
    [Documentation]    Vérifie que l'email est pré-rempli
    ${stored_email}=    Get Value    ${PERSISTED_EMAIL}
    Should Be Equal    ${stored_email}    ${VALID_USERNAME_AUTOMATION}

Submit Login Form
    [Documentation]    Soumet le formulaire et vérifie la redirection
    Click Element    ${LOGIN_SUBMIT_BUTTON}
    Wait Until Page Contains Element    ${CONTACTS_TABLE}    15s    # Attente allongée pour la redirection
