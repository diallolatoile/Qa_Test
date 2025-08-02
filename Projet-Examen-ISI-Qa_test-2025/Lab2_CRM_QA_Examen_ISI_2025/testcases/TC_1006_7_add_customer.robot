*** Settings ***
Documentation     TC-1006 & TC-1007 - Should be able to add all customers from test data dynamically - Should be able to cancel adding new customer.
Resource          ../resources/home_page_keywords.robot
Resource          ../resources/customers_keywords.robot

Suite Setup       Préparer environnement test
Suite Teardown    Fermer le navigateur proprement
Test Teardown     Run Keywords
...               Capture Screenshot If Test Failed
...               AND    Logout User  # Nettoyage même si le test échoue

*** Test Cases ***
TC-1007 Adding New Customer
    [Documentation]    Ajoute un client spécifique depuis la liste des clients.
    [Tags]    functional    add    customers
    ${customer}=    Get From List    ${CUSTOMERS}    0
    Add New Customer
    ...    ${customer['email']}    
    ...    ${customer['firstname']}    
    ...    ${customer['lastname']}    
    ...    ${customer['city']}    
    ...    ${customer['state']}    
    ...    ${customer['gender']}    
    ...    ${customer['active']}
    Logout User

TC-1007 Cancel Adding New Customer
    [Documentation]    Vérifie que l'utilisateur peut annuler l'ajout d'un client et revenir à la liste des clients.
    [Tags]    functional    cancel    customers
    Navigate To Login Page
    Enter Valid Credentials
    Submit Login Form
    
    Navigate To Add Customer Page
    ${expected_msg}=    Set Variable    ${VALID_MSG_ADD_CUSTOMER_${LANG}}
    Vérifier message page ajout client    ${expected_msg}
    Cancel Adding Customer
    ${expected_msg}=    Set Variable    ${VALID_MSG_CUSTOMERS_PAGE_${LANG}}
    Vérifier message retour page customers    ${expected_msg}