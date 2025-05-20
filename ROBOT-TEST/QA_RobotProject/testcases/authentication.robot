*** Settings ***
Resource          ../resources/authentication.robot

*** Test Cases ***
Cas 1 - Identifiants incorrects
    [Tags]    smoke    authentification
    Obtenir la langue du navigateur
    ${expected_msg}=    Set Variable    ${INVALID_CREDENTIALS_MSG_${LANG}}
    Exécuter scénario   admin    mauvais_mot_de_passe    ${expected_msg}

Cas 2 - Utilisateur ou mot de passe invalides
    [Tags]    smoke    authentification
    Obtenir la langue du navigateur
    ${expected_msg}=    Set Variable    ${INVALID_CREDENTIALS_MSG_${LANG}}
    Exécuter scénario   invalid_user    invalid_pass    ${expected_msg}

Cas 3 - Champs vides
    [Tags]    smoke    authentification
    Obtenir la langue du navigateur
    ${expected_msg}=    Set Variable    ${EMPTY_FIELD_MSG_${LANG}}
    Exécuter scénario   ${EMPTY}    ${EMPTY}    ${expected_msg}







Cas 4 - Identifiants valides
    [Tags]    sanity    authentification
    Obtenir la langue du navigateur
    ${expected_msg} =    Set Variable    ${VALID_CREDENTIALS_MSG_${LANG}}
    Exécuter scénario valide   admin    @P@$$Jenkins2025    ${expected_msg}
