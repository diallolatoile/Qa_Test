*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${URL}     https://robotcode.io/

*** Test Cases ***
CAS_TEST_1
    Ouverture Navigateur 
    Aller a la page Get started
    Verifier qu'on est bien sur la page Requirement
    Fermer le navigateur

*** Keywords ***
Ouverture Navigateur    
    Open Browser    ${URL}    chrome
    Sleep    3

Aller a la page Get started
    Click Element    xpath=//*[@id="VPContent"]/div/div[1]/div/div[1]/div/div[2]/a
    Sleep    3

Verifier qu'on est bien sur la page Requirement
    Page Should Contain    Requirements
    Sleep    10

Fermer le navigateur
    Close Browser