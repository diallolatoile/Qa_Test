#testcases/mobile.robot

*** Settings ***
Library           AppiumLibrary

Variables        ../po/variables.py
Resource         ../resources/common.robot


Suite Setup    Run Keyword    Open Application MyApp

*** Variables ***
&{TEST_PRODUCT}    
...    title=Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops
...    price=109.95
...    description=Your perfect pack for everyday use and walks in the forest...
...    category=men's clothing
...    image=https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg

&{TEST_PRODUCT_UPDATE}
...    title=Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops
...    price=110

@{PRODUCTS}    Create List    ${{ {"productId": 101, "quantity": 2} }}
&{TEST_CART}    
...    id=11    
...    userId=1
...    products=@{PRODUCTS}

&{TEST_CART_UPDATE}
...    products=[{'productId':101,'quantity':5}]

&{TEST_USER}
...    username=johnd
...    email=johnd@gmail.com
...    password=m38rmF

&{TEST_USER_2}    
...    id=11
...    email=jane.smith@example.com
...    username=janesmith
...    password=securePass123!

&{TEST_USER_UPDATE}
...    email=upjane.smith@example.com
...    username=upjanesmith
...    password=upsecurePass123!

&{NEW_PRODUCT_ID}    = null
&{NEW_CART_ID}    = null

*** Test Cases ***
Open Application and Login
    [Tags]     "init"
    Enter username
    Enter password
    Log In


TC16 - Fill Form To Add Product
    [Documentation]    Test filling out the product form and submitting it
    [Tags]    product    form
    
    # Wait for form page to be visible
    Wait Until Element Is Visible    ${PAGE_FORM}    10
    
    Fill in product details    ${TEST_PRODUCT['title']}    ${TEST_PRODUCT['price']}    ${TEST_PRODUCT['description']}    ${TEST_PRODUCT['category']}    ${TEST_PRODUCT['image']}
    
    # Submit the form
    Click Add Product Button
    
    # Verify successful submission (adjust based on your app's behavior)
    Wait Until Element Is Visible    ${PRODUCTS_LIST_PAGE}    10
