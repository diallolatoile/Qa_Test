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

${EMPTY_FIELD_MSG_en}          xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), 'Invalid username or password')] 
#xpath=//div[contains(text(), 'Please enter a valid code')]

${BLOCKED_ACCOUNT_MSG_en}      xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), 'Invalid username or password')]
#xpath=//span[contains(text(), 'Account blocked')]

# Français
${INVALID_CREDENTIALS_MSG_fr}  xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), "Nom d'utilisateur ou mot de passe incorrect")]

${EMPTY_FIELD_MSG_fr}          xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), "Nom d'utilisateur ou mot de passe incorrect")] 
#xpath=//div[contains(text(), 'Taper un code valide')]

${BLOCKED_ACCOUNT_MSG_fr}      xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), "Nom d'utilisateur ou mot de passe incorrect")] 
#xpath=//span[contains(text(), 'compte bloqué')]

# Sélectionner les messages en fonction de la langue
#${INVALID_CREDENTIALS_MSG_${LANG}}
#${EMPTY_FIELD_MSG_${LANG}}
#${BLOCKED_ACCOUNT_MSG_${LANG}}

*** Test Cases ***
Cas 1 - Identifiants incorrects
    [Tags]    authentification
    Obtenir la langue du navigateur
    ${expected_msg}=    Set Variable    ${INVALID_CREDENTIALS_MSG_${LANG}}
    Exécuter scénario   admin    mauvais_mot_de_passe    ${expected_msg}

Cas 2 - Utilisateur ou mot de passe invalides
    [Tags]    authentification
    Obtenir la langue du navigateur
    ${expected_msg}=    Set Variable    ${INVALID_CREDENTIALS_MSG_${LANG}}
    Exécuter scénario   invalid_user    invalid_pass     ${expected_msg}

Cas 3 - Champs vides
    [Tags]    authentification
    Obtenir la langue du navigateur
    ${expected_msg}=    Set Variable    ${EMPTY_FIELD_MSG_${LANG}}
    Exécuter scénario   ${EMPTY}    ${EMPTY}         ${expected_msg}

Cas 4 - Identifiants valides
    [Tags]    authentification
    Obtenir la langue du navigateur
    ${expected_msg}=    Set Variable    ${BLOCKED_ACCOUNT_MSG_${LANG}}
    Exécuter scénario   admin    correct_pass     ${expected_msg}

*** Keywords ***
Obtenir la langue du navigateur
    Open Browser    about:blank    ${BROWSER}
    ${language}=    Execute Javascript    return navigator.language || navigator.userLanguage;
    ${lang_code}=   Evaluate    '${language.split("-")[0]}'.lower()
    Set Suite Variable    ${LANG}    ${lang_code}
    Close Browser

Exécuter scénario
    [Arguments]    ${username}    ${password}    ${expected_msg}
    Ouvrir le navigateur
    Saisir identifiants    ${username}    ${password}
    Cliquer sur connexion
    Vérifier message d'échec    ${expected_msg}
    Fermer le navigateur

Ouvrir le navigateur
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5

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

Vérifier message d'échec
    [Arguments]    ${expected_msg}
    Wait Until Element Is Visible    ${expected_msg}    timeout=5
    Element Should Be Visible        ${expected_msg}

Fermer le navigateur
    Close Browser
