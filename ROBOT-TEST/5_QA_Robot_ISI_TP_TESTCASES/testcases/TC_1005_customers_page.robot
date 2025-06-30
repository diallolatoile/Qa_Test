### testcases/login.robot

*** Settings ***
Documentation     TC-1005 - Customers Table Should Display Correct Data
Resource          ../resources/home_page_keywords.robot
Resource          ../resources/login_keywords.robot
Resource          ../resources/customers_keywords.robot

Suite Setup       Préparer environnement test
Suite Teardown    Fermer le navigateur proprement
Test Teardown     Capture Screenshot If Test Failed

*** Test Cases ***
TC-1005 Customers Table Should Display Correct Data
    [Documentation]    Vérifie la structure et les données du tableau clients
    [Tags]    CRITICAL    smoke    customers    data-validation
    # Setup et login
    Navigate To Login Page
    Enter Valid Credentials
    Submit Login Form
    
    # Vérification principale
    Verify Table Structure
    
    # Vérification secondaire
    ${row_count}=    Get Element Count    ${TABLE_ROWS}
    Should Be True    ${row_count} > 0    msg=La table doit contenir des données clients

    ${customers}=    Get Customer Data
    Length Should Be    ${customers}    6    # Vérifie le nombre exact de lignes
    
    # Exemple de vérification de données spécifiques
    Dictionary Should Contain Item    ${customers}[0]    FirstName    Mark
    Dictionary Should Contain Item    ${customers}[4]    Username    aaron_butler
    
    ${customers}=    Get Customer Data
    Length Should Be    ${customers}    ${EXPECTED_CUSTOMER_COUNT}
    
    # Vérification des données spécifiques
    Should Be Equal    ${customers}[0][Number]    1
    Should Be Equal    ${customers}[1][FirstName]    Ashley
    Should Be Equal    ${customers}[5][Username]    cab79

    # Test pagination
    Verify Pagination Navigation