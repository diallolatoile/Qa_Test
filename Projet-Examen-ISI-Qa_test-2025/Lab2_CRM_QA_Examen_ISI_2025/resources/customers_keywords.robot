### resources/customers_keywords.robot

*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     OperatingSystem

Resource          ../resources/login_keywords.robot

*** Keywords ***
Verify Table Structure
    [Documentation]    Vérifie les 5 en-têtes exacts du tableau
    # Liste COMPLÈTE des en-têtes attendus (doit correspondre exactement à votre HTML)
    @{expected_headers}=    Create List    \#    First Name    Last Name    Username    ${EMPTY}
    
    # Debug crucial
    #Log To Console    \n=== DEBUG ACTUAL HEADERS ===
    ${actual_headers}=    Get WebElements    ${TABLE_HEADERS}
    #FOR    ${index}    ${header}    IN ENUMERATE    @{actual_headers}
    #    ${text}=    Get Text    ${header}
    #    Log To Console    ${index}: '${text}'
    #END
    
    # Validation
    Should Be Equal As Integers    ${actual_headers.__len__()}    5
    ...    msg=Doit avoir exactement 5 colonnes
    
    FOR    ${index}    IN RANGE    0    5
        ${expected}=    Set Variable    ${expected_headers}[${index}]
        ${actual}=    Get Text    ${actual_headers}[${index}]
        Should Be Equal As Strings    ${actual.strip()}    ${expected.strip()}
        ...    msg=En-tête ${index} incorrect. Attendu: '${expected}' | Trouvé: '${actual}'
    END
 
Get Customer Data
    [Documentation]    Extrait les données avec XPath absolus dynamiques
    @{customers}=    Create List
    ${row_count}=    Get Element Count    xpath=/html/body/div/div/table/tbody/tr
    
    FOR    ${i}    IN RANGE    1    ${row_count}+1
        ${customer}=    Create Dictionary
        
        # Extraction des données avec XPath absolus
        ${customer}[Number]=    Get Text    xpath=/html/body/div/div/table/tbody/tr[${i}]/td[1]
        ${customer}[FirstName]=    Get Text    xpath=/html/body/div/div/table/tbody/tr[${i}]/td[2]
        ${customer}[LastName]=    Get Text    xpath=/html/body/div/div/table/tbody/tr[${i}]/td[3]
        ${customer}[Username]=    Get Text    xpath=/html/body/div/div/table/tbody/tr[${i}]/td[4]
        
        Collections.Append To List    ${customers}    ${customer}
        
        #Log    Client ${i}: ${customer}[FirstName] ${customer}[LastName]    level=INFO
    END
    RETURN    @{customers}

Verify Pagination Navigation
    [Documentation]    Teste la navigation entre pages
    Element Should Be Visible    ${PAGINATION}
    Click Element    ${PAGE_NEXT}
    Wait Until Location Contains    ${NEXT_PAGE}    5s

Navigate To Add Customer Page
    Click Element    ${NEW_CUSTOMER_BTN}
    Wait Until Page Contains Element    ${ADD_CUSTOMER_PAGE_TEXT}    5s

Add New Customer
    [Arguments]    ${email}    ${first_name}    ${last_name}    ${city}    ${state}    ${gender}    ${promo}
    Navigate To Login Page
    Enter Valid Credentials
    Submit Login Form
    
    Navigate To Add Customer Page
    ${expected_msg}=    Set Variable    ${VALID_MSG_ADD_CUSTOMER_${LANG}}
    Vérifier message page ajout client    ${expected_msg}
    
    Fill Customer Form    ${email}    ${first_name}    ${last_name}    ${city}    ${state}    ${gender}    ${promo}
    Submit Customer Form

Fill Customer Form
    [Arguments]    ${email}    ${first_name}    ${last_name}    ${city}    ${state}    ${gender}    ${accept_promo}=${False}
    Input Text    ${EMAIL_FIELD}    ${email}
    Input Text    ${FIRST_NAME_FIELD}    ${first_name}
    Input Text    ${LAST_NAME_FIELD}    ${last_name}
    Input Text    ${CITY_FIELD}    ${city}
    
    Select From List By Value    ${STATE_DROPDOWN}    ${state}
    
    Run Keyword If    '${gender}' == 'male'    Click Element    ${GENDER_MALE}
    ...    ELSE IF    '${gender}' == 'female'    Click Element    ${GENDER_FEMALE}
    
    Run Keyword If    ${accept_promo}    Select Checkbox    ${PROMO_CHECKBOX}

Submit Customer Form
    Click Element    ${SUBMIT_BTN}
    Wait Until Page Contains Element    ${ADD_CUSTOMER_SUCCESS_PAGE_TEXT}    15s

Cancel Adding Customer
    Click Element    ${CANCEL_BTN}
    Wait Until Page Contains Element    ${CONTACTS_TABLE}    15s

Vérifier message page ajout client
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    ${ADD_CUSTOMER_PAGE_TEXT}
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${VALID_MSG_ADD_CUSTOMER_en}' in '${page_text}'    Log    Message trouvé en anglais : ${VALID_MSG_ADD_CUSTOMER_en}    console=True
    ...    ELSE IF    '${VALID_MSG_ADD_CUSTOMER_fr}' in '${page_text}'    Log    Message trouvé en français : ${VALID_MSG_ADD_CUSTOMER_fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${VALID_MSG_ADD_CUSTOMER_en}', '${VALID_MSG_ADD_CUSTOMER_fr}') n'a été trouvé.

Vérifier message de réussite ajout client
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message de succès attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    ${ADD_CUSTOMER_SUCCESS_PAGE_TEXT}
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${VALID_MSG_ADD_CUSTOMER_SUCCESS_en}' in '${page_text}'    Log    Message trouvé en anglais : ${VALID_MSG_ADD_CUSTOMER_SUCCESS_en}    console=True
    ...    ELSE IF    '${VALID_MSG_ADD_CUSTOMER_SUCCESS_fr}' in '${page_text}'    Log    Message trouvé en français : ${VALID_MSG_ADD_CUSTOMER_SUCCESS_fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${VALID_MSG_ADD_CUSTOMER_SUCCESS_en}', '${VALID_MSG_ADD_CUSTOMER_SUCCESS_fr}') n'a été trouvé.

Vérifier message retour page customers
    [Arguments]    ${expected_msg}
    [Documentation]    Vérifie si le message attendu est présent, sinon vérifie la version alternative.
    
    ${page_text}=    Get Text    ${CUSTOMERS_PAGE_TEXT}
    Run Keyword If    '${expected_msg}' in '${page_text}'    Log    Message attendu trouvé : ${expected_msg}    console=True
    ...    ELSE IF    '${VALID_MSG_CUSTOMERS_PAGE_en}' in '${page_text}'    Log    Message trouvé en anglais : ${VALID_MSG_CUSTOMERS_PAGE__en}    console=True
    ...    ELSE IF    '${VALID_MSG_CUSTOMERS_PAGE_fr}' in '${page_text}'    Log    Message trouvé en français : ${VALID_MSG_CUSTOMERS_PAGE__fr}    console=True
    ...    ELSE    Fail    Aucun des messages attendus ('${expected_msg}', '${VALID_MSG_CUSTOMERS_PAGE_en}', '${VALID_MSG_CUSTOMERS_PAGE__fr}') n'a été trouvé.
