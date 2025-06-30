### resources/home_page_keywords.robot

*** Settings ***
Documentation     Ressources pour le test Selenium Practice - formulaire.
Library           SeleniumLibrary
Variables         ../pageobject/locator.py
Variables         ../pageobject/variables.py
Variables         ../pageobject/testdata.py

*** Keywords ***
Exécuter scénario
    [Arguments]    ${expected_msg}
    Afficher informations testeur
    Vérifier message de réussite    ${expected_msg}

Préparer environnement test
    [Documentation]    Prépare le navigateur et configure les délais.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed       0.5s
    Set Selenium Timeout    10s
    ${language}=    Execute Javascript    return navigator.language || navigator.userLanguage;
    ${lang_code}=   Evaluate    '${language.split("-")[0]}'.lower()
    Set Suite Variable    ${LANG}    ${lang_code}

Vérifier message de réussite
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message de succès attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    ${HOME_PAGE_TEXT}
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${VALID_MSG_HOME_en}' in '${page_text}'    Log    Message trouvé en anglais : ${VALID_MSG_HOME_en}    console=True
    ...    ELSE IF    '${VALID_MSG_HOME_fr}' in '${page_text}'    Log    Message trouvé en français : ${VALID_MSG_HOME_fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${VALID_MSG_HOME_en}', '${VALID_MSG_HOME_fr}') n'a été trouvé.

Afficher informations testeur
    [Documentation]    Affiche les informations du testeur dans la console.
    Log     Testeur: ${TESTER_FIRSTNAME} ${TESTER_LASTNAME}    console=True

Fermer le navigateur proprement
    [Documentation]    Ferme proprement le navigateur.
    Close Browser

Capture Screenshot If Test Failed
    [Documentation]    Capture une capture d'écran si le test échoue.
    Run Keyword If Test Failed    Capture Page Screenshot
    Run Keyword If Test Failed    Log Source
