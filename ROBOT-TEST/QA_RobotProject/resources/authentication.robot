*** Settings ***
Library           SeleniumLibrary
Variables         ../pageobject/locator.py
Variables         ../pageobject/variables.py

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
