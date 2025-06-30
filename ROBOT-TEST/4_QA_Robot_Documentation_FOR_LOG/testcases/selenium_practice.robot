### testcases/selenium_practice.robot

*** Settings ***
Documentation     Scénario de test de remplissage et soumission de formulaire Selenium Practice.
Resource          ../resources/selenium_practice.robot

Suite Setup       Ouvrir le navigateur
Suite Teardown    Fermer le navigateur
Test Teardown     Capture Screenshot If Test Failed

*** Test Cases ***
Test Remplissage Et Soumission Du Formulaire
    [Documentation]    Ce test vérifie que le formulaire peut être rempli correctement et qu'un message valide est affiché.
    [Tags]    smoke    sanity    selenium_practice
    ${expected_msg}=    Set Variable    ${VALID_MSG_${LANG}}
    Exécuter scénario    ${expected_msg}
