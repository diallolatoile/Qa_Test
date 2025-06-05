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
    [Arguments]    ${expected_msg}
    Ouvrir le navigateur
    Remplir le formulaire
    Soumettre le formulaire
    Vérifier message de réussite    ${expected_msg}
    Fermer le navigateur

Ouvrir le navigateur
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5

Vérifier message de réussite
    [Arguments]    ${expected_msg}
    Set Browser Implicit Wait  5
    Page Should Contain    ${expected_msg}

Remplir le formulaire
    Input Text    ${NAME_FIELD}    Mamadou Bobo DIALLO
    Select From List By Value    ${SELECT_DROPDOWN}    item2
    Click Element    ${CHECKBOX_1}
    Click Element    ${CHECKBOX_3}
    Input Text    ${DATE_PICKER}    ${DATE}

Soumettre le formulaire
    Click Button    ${SUBMIT_BUTTON}

Fermer le navigateur
    Close Browser