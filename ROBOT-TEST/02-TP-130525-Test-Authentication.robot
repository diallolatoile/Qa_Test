*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                  http://18.201.83.167:8080/jenkins
${BROWSER}              chrome

${USERNAME_FIELD}       id=j_username
${PASSWORD_FIELD}       id=j_password
${LOGIN_BUTTON}         xpath=//button[@class='jenkins-button jenkins-button--primary' and @name='Submit']

${EMPTY}                __EMPTY__  # Pour identifier les champs vides

# Langue par défaut
${LANG}                 en

# Messages d'erreur pour chaque langue
# Anglais
${INVALID_CREDENTIALS_MSG_en}  xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), 'Invalid username or password')]
#${EMPTY_FIELD_MSG_en}          xpath=//div[contains(text(), 'Please enter a valid code')]
#${BLOCKED_ACCOUNT_MSG_en}      xpath=//span[contains(text(), 'Account blocked')]

# Français
${INVALID_CREDENTIALS_MSG_fr}  xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), "Nom d'utilisateur ou mot de passe incorrect")]
#${EMPTY_FIELD_MSG_fr}          xpath=//div[contains(text(), 'Taper un code valide')]
#${BLOCKED_ACCOUNT_MSG_fr}      xpath=//span[contains(text(), 'compte bloqué')]

# Sélectionner les messages en fonction de la langue
#${INVALID_CREDENTIALS_MSG_${LANG}}
#${EMPTY_FIELD_MSG_${LANG}}
#${BLOCKED_ACCOUNT_MSG_${LANG}}

*** Test Cases ***
Tester tous les scénarios d'authentification
    [Tags]    authentification
    Obtenir la langue du navigateur

    FOR    ${username}    ${password}    IN
    ...    admin    mauvais_mot_de_passe    # Cas1
    ...    invalid_user    invalid_pass     # Cas2
    ...    ${EMPTY}        ${EMPTY}         # Cas3
    ...    admin           correct_pass     # Cas4
        ${expected_msg}=    Set Variable    ${INVALID_CREDENTIALS_MSG_${LANG}}
        Exécuter scénario   ${username}      ${password}    ${expected_msg}
    END

*** Keywords ***
Exécuter scénario
    [Arguments]    ${username}    ${password}    ${expected_msg}
    Ouvrir le navigateur
    Saisir identifiants    ${username}    ${password}
    Cliquer sur connexion
    # Vérifier le cas où les champs sont vides
    IF    '${username}' == '' and '${password}' == ''
        Vérifier champs vides
    ELSE
        Vérifier message    ${expected_msg}
    END
    Fermer le navigateur

Ouvrir le navigateur
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5

Obtenir la langue du navigateur
    Open Browser    about:blank    ${BROWSER}
    ${language}=    Execute Javascript    return navigator.language || navigator.userLanguage;
    ${lang_code}=   Evaluate    '${language.split("-")[0]}'.lower()
    Set Suite Variable    ${LANG}    ${lang_code}
    Close Browser

Saisir identifiants
    [Arguments]    ${username}    ${password}
    IF    '${username}' != '${EMPTY}'
        Input Text    ${USERNAME_FIELD}    ${username}
    END
    IF    '${password}' != '${EMPTY}'
        Input Password    ${PASSWORD_FIELD}    ${password}
    END

Cliquer sur connexion
    Click Button    ${LOGIN_BUTTON}

Vérifier message
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5
    Element Should Be Visible        ${locator}

Vérifier champs vides
    ${username_val}=    Get Value    ${USERNAME_FIELD}
    Should Be Empty     ${username_val}
    ${password_val}=    Get Value    ${PASSWORD_FIELD}
    Should Be Empty     ${password_val}

Fermer le navigateur
    Close Browser
