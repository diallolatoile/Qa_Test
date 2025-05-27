*** Settings ***
Library    Collections
Resource    ../resources/fakestore_keywords.robot

Suite Setup    Create Session To FakeStore

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

*** Test Cases ***

TC01 - Get List Of All Products
    ${products}=    Get All Products
    ${length}=      Get Length    ${products}
    Should Be True  ${length} > 0

TC02 - Add New Product
    ${new_product}=    Add New Product    ${TEST_PRODUCT}
    Should Contain    ${new_product}    id
    Set Suite Variable    ${NEW_PRODUCT_ID}    ${new_product['id']}

TC03 - Get Single Product
    ${product}=    Get Single Product    1
    Should Be Equal As Strings    ${product['title']}    ${TEST_PRODUCT['title']}

TC04 - Update Product
    ${updated_product}=    Update Product    ${NEW_PRODUCT_ID}    ${TEST_PRODUCT_UPDATE}
    Should Be Equal As Strings    ${updated_product['title']}    ${TEST_PRODUCT_UPDATE['title']}

TC05 - Delete Product
    Delete Product    ${NEW_PRODUCT_ID}

TC06 - Get All Carts
    ${carts}=    Get All Carts
    ${length}=    Get Length    ${carts}
    Should Be True    ${length} > 0

TC07 - Add New Cart
    ${new_cart}=    Add New Cart    ${TEST_CART}
    Should Be Equal As Strings    ${new_cart['userId']}    ${TEST_CART['userId']}
    Should Be Equal As Strings    ${new_cart['id']}        ${TEST_CART['id']}
    Set Suite Variable    ${NEW_CART_ID}    ${new_cart['id']}

TC08 - Get Single Cart
    ${cart}=    Get Single Cart    1
    Should Be Equal As Integers    ${cart['userId']}    1  

TC09 - Update Cart
    ${updated_cart}=    Update Cart    ${NEW_CART_ID}    ${TEST_CART_UPDATE}
    Should Contain    ${updated_cart}    products

TC10 - Delete Cart
    Delete Cart    ${NEW_CART_ID}

TC11 - Get All Users
    ${users}=    Get All Users
    ${length}=    Get Length    ${users}
    Should Be True    ${length} > 0

TC12 - Add New User
    ${new_user}=    Add New User    ${TEST_USER_2}
    Should Contain    ${new_user}    id 
    Should Be Equal As Strings    ${new_user['id']}    ${TEST_USER_2['id']}
    
TC13 - Get Single User
    ${user}=    Get Single User    1
    Should Be Equal As Strings    ${user['username']}    ${TEST_USER['username']}

TC14 - Update User
    ${updated_user}=    Update User    1    ${TEST_USER_UPDATE}
    Should Be Equal As Strings    ${updated_user['username']}    ${TEST_USER_UPDATE['username']}

TC15 - Delete User
    Delete User    1
