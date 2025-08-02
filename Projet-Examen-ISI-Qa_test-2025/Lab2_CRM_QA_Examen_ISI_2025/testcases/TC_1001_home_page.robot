### testcases/home_page.robot

*** Settings ***
Documentation     TC-1001 - Home page should load correctly with required content.
Resource          ../resources/home_page_keywords.robot

Suite Setup       Préparer environnement test
Suite Teardown    Fermer le navigateur proprement
Test Teardown     Capture Screenshot If Test Failed

*** Test Cases ***
TC-1001 Home Page Should Load Correctly
    [Documentation]    Vérifie que la page d'accueil est accessible et que le contenu attendu est présent.
    [Tags]    smoke    home
    ${expected_msg}=    Set Variable    ${VALID_MSG_HOME_${LANG}}
    Exécuter scénario    ${expected_msg}

