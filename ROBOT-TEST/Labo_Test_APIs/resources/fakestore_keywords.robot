*** Settings ***
Library    RequestsLibrary
Library    Collections
Variables  ../pageobject/variables.py
Library    OperatingSystem

*** Keywords ***
Disable SSL Warnings
    # Use requests' method to disable warnings
    Evaluate    requests.packages.urllib3.disable_warnings()    modules=requests

Suite Setup
    Disable SSL Warnings
    Create Session To FakeStore

Create Session To FakeStore
    Log To Console    ${BASE_URL}
    Create Session    fakestore    ${BASE_URL}    headers=${HEADERS}    verify=True

Get All Products
    ${response}=    GET On Session    fakestore    /products
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Add New Product
    [Arguments]    ${product_data}
    ${response}=    POST On Session    fakestore    /products    json=${product_data}
    Log    Response: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Get Single Product
    [Arguments]    ${product_id}
    ${response}=    GET On Session    fakestore    /products/${product_id}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Update Product
    [Arguments]    ${product_id}    ${product_data}
    ${response}=    PUT On Session    fakestore    /products/${product_id}    json=${product_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Delete Product
    [Arguments]    ${product_id}
    ${response}=    DELETE On Session    fakestore    /products/${product_id}
    Should Be Equal As Strings    ${response.status_code}    200

# -- Carts --

Get All Carts
    Get All Products
    ${response}=    GET On Session    fakestore    /carts
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Add New Cart
    [Arguments]    ${cart_data}
    ${response}=    POST On Session    fakestore    /carts    json=${cart_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Get Single Cart
    [Arguments]    ${cart_id}
    ${response}=    GET On Session    fakestore    /carts/${cart_id}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Update Cart
    [Arguments]    ${cart_id}    ${cart_data}
    ${response}=    PUT On Session    fakestore    /carts/${cart_id}    json=${cart_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Delete Cart
    [Arguments]    ${cart_id}
    ${response}=    DELETE On Session    fakestore    /carts/${cart_id}
    Should Be Equal As Strings    ${response.status_code}    200

# -- Users --

Get All Users
    Get All Products
    ${response}=    GET On Session    fakestore    /users
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Add New User
    [Arguments]    ${user_data}
    ${response}=    POST On Session    fakestore    /users    json=${user_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Get Single User
    [Arguments]    ${user_id}
    ${response}=    GET On Session    fakestore    /users/${user_id}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Update User
    [Arguments]    ${user_id}    ${user_data}
    ${response}=    PUT On Session    fakestore    /users/${user_id}    json=${user_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Delete User
    [Arguments]    ${user_id}
    ${response}=    DELETE On Session    fakestore    /users/${user_id}
    Should Be Equal As Strings    ${response.status_code}    200
