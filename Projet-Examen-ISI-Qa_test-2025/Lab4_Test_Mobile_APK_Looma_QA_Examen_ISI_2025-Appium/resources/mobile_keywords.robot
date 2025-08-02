#resources/common.robot

*** Settings ***
Library           AppiumLibrary

Variables        ../po/variables.py
Variables        ../po/locator_v1.py


*** Keywords ***
Open Application MyApp
    Open Application       ${REMOTE_URL}   platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    noReset=true
    
Enter username
    Wait Until Element Is Visible    ${USERNAME}    5
    Click Element    ${USERNAME}
    Input Text    ${USERNAME}    johnd
    
Enter password
    Wait Until Element Is Visible    ${PASSWORD}    5
    Click Element    ${PASSWORD}
    Input Password    ${PASSWORD}    m38rmF$

Log In
    Wait Until Element Is Visible    ${LOGIN}    5
    Click Element    ${LOGIN}
    Wait Until Page Contains Element    ${PAGE_FORM}


Fill in product details
    [Arguments]    ${TEST_PRODUCT['title']}    ${TEST_PRODUCT['price']}    ${TEST_PRODUCT['description']}    ${TEST_PRODUCT['category']}    ${TEST_PRODUCT['image']}
    Input Product Title    ${TEST_PRODUCT['title']}
    Input Product Price    ${TEST_PRODUCT['price']}
    Input Product Description    ${TEST_PRODUCT['description']}
    Input Product Category    ${TEST_PRODUCT['category']}
    Input Product Image URL    ${TEST_PRODUCT['image']}

Input Product Title
    [Arguments]    ${title}
    Wait Until Element Is Visible    ${FORM_TITLE}    5
    Click Element    ${FORM_TITLE}
    Clear Text    ${FORM_TITLE}
    Input Text    ${FORM_TITLE}    ${title}

Input Product Price
    [Arguments]    ${price}
    Wait Until Element Is Visible    ${FORM_PRICE}    5
    Click Element    ${FORM_PRICE}
    Clear Text    ${FORM_PRICE}
    Input Text    ${FORM_PRICE}    ${price}

Input Product Description
    [Arguments]    ${description}
    Wait Until Element Is Visible    ${FORM_DESCRIPTION}    5
    Click Element    ${FORM_DESCRIPTION}
    Clear Text    ${FORM_DESCRIPTION}
    Input Text    ${FORM_DESCRIPTION}    ${description}

Input Product Category
    [Arguments]    ${category}
    Wait Until Element Is Visible    ${FORM_CATEGORIE}    5
    Click Element    ${FORM_CATEGORIE}
    Clear Text    ${FORM_CATEGORIE}
    Input Text    ${FORM_CATEGORIE}    ${category}

Input Product Image URL
    [Arguments]    ${url}
    Wait Until Element Is Visible    ${FORM_URL}    5
    Click Element    ${FORM_URL}
    Clear Text    ${FORM_URL}
    Input Text    ${FORM_URL}    ${url}

Click Add Product Button
    Wait Until Element Is Visible    ${FORM_BUTTON_ADD}    5
    Click Element    ${FORM_BUTTON_ADD}

Verify Product Is Displayed
    [Arguments]    ${product_title}
    [Documentation]    Vérifie que le produit avec le titre donné est visible dans la liste et clique dessus
    Wait Until Element Is Visible    ${ADDED_PRODUCT_PAGE}    10

    Click Element    ${ADDED_PRODUCT_PAGE}
    
    Wait Until Element Is Visible    ${PRODUCT_CARD}    10
    
    ${product_locator} =    Set Variable    ${NEW_ADDED_PRODUCT}
    Wait Until Element Is Visible    ${product_locator}    10
    Log To Console    Produit trouvé avec le titre : ${product_title}
    
    Log To Console    Produit affiché correctement : ${product_title}

    Click Element    ${CLOSE_BUTTON}


