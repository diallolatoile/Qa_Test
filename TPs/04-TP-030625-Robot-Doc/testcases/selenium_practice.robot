*** Settings ***
Resource          ../resources/selenium_practice.robot

*** Test Cases ***
Test Remplissage Et Soumission Du Formulaire
    [Tags]    sanity    selenium_practice
    Obtenir la langue du navigateur
    ${expected_msg} =    Set Variable    ${VALID_MSG_${LANG}}
    Exécuter scénario    ${expected_msg}
