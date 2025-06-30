### resources/selenium_practice.robot

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
    Remplir le formulaire
    Soumettre le formulaire
    Vérifier message de réussite    ${expected_msg}

Ouvrir le navigateur
    [Documentation]    Ouvre le navigateur et détecte la langue automatiquement via le navigateur.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    5
    Set Selenium Timeout          10
    ${language}=    Execute Javascript    return navigator.language || navigator.userLanguage;
    ${lang_code}=   Evaluate    '${language.split("-")[0]}'.lower()
    Set Suite Variable    ${LANG}    ${lang_code}

Remplir le formulaire
    [Documentation]    Remplit le formulaire avec les données de test.
    Input Text         ${NAME_FIELD}         ${TESTER_FIRSTNAME} ${TESTER_LASTNAME}
    Select From List By Value     ${SELECT_DROPDOWN}      item2
    Cocher Toutes Les Checkboxes
    Input Text         ${DATE_PICKER}       ${DATE_TEST}

Cocher Toutes Les Checkboxes
    [Documentation]    Coche toutes les cases spécifiées.
    FOR    ${CHECKBOX}    IN    @{CHECKBOX_IDS}
        Click Element    ${CHECKBOX}
    END

Soumettre le formulaire
    [Documentation]    Clique sur le bouton de soumission du formulaire.
    Click Button       ${SUBMIT_BUTTON}

Vérifier message de réussite
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message de succès attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    xpath=/html/body/form/div
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${VALID_MSG_en}' in '${page_text}'    Log    Message trouvé en anglais : ${VALID_MSG_en}    console=True
    ...    ELSE IF    '${VALID_MSG_fr}' in '${page_text}'    Log    Message trouvé en français : ${VALID_MSG_fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${VALID_MSG_en}', '${VALID_MSG_fr}') n'a été trouvé.

Afficher informations testeur
    [Documentation]    Affiche les informations du testeur dans la console.
    Log     Testeur: ${TESTER_FIRSTNAME} ${TESTER_LASTNAME}    console=True

Fermer le navigateur
    [Documentation]    Ferme proprement le navigateur.
    Close Browser

Capture Screenshot If Test Failed
    [Documentation]    Capture une capture d'écran si le test échoue.
    Run Keyword If Test Failed    Capture Page Screenshot
    Run Keyword If Test Failed    Log Source
