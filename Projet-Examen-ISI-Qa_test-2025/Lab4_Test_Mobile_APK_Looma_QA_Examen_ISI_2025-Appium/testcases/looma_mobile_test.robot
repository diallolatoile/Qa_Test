#testcases/mobile.robot

*** Settings ***
Library           AppiumLibrary

Variables        ../po/variables.py
Resource         ../resources/mobile_keywords.robot


Suite Setup    Run Keyword    Open Application MyApp

*** Variables ***
&{TEST_PRODUCT}
...    title=John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet\n695 $
...    price=695
...    description=From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.
...    category=jewelery
...    image=https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg

&{NEW_PRODUCT_ID}    = null
&{NEW_CART_ID}    = null

*** Test Cases ***
TC01 - Open Application and Login
    [Tags]     "init"
    Enter username
    Enter password
    Log In


TC02 - Fill Form To Add Product
    [Documentation]    Test filling out the product form and submitting it
    [Tags]    product    form
    
    # Wait for form page to be visible
    Wait Until Element Is Visible    ${PAGE_FORM}    10
    
    Fill in product details    ${TEST_PRODUCT['title']}    ${TEST_PRODUCT['price']}    ${TEST_PRODUCT['description']}    ${TEST_PRODUCT['category']}    ${TEST_PRODUCT['image']}
    
    # Submit the form
    Click Add Product Button
    
    # Verify successful submission (adjust based on your app's behavior)
    Wait Until Element Is Visible    ${PRODUCTS_LIST_PAGE}    10

TC03 - Vérification affichage produit
    [Documentation]    Vérifie que le produit ajouté est bien visible dans la liste
    [Tags]    validation    display    product    mobile
    Log To Console    ${TEST_PRODUCT['title']}
    Verify Product Is Displayed    ${TEST_PRODUCT['title']}
