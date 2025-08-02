### testcases/TC_1001_crud_products.robot
*** Settings ***
Resource    ../resources/crud_operations_keywords.robot
Suite Setup    Run Keywords    Initialize MongoDB Connection    AND    Clean Test Data
Suite Teardown    Clean Test Data

*** Test Cases ***
# CREATE
Create Product - Valid
    ${msg}=    InsertOne    ${MONGODB_CONFIG}    ${VALID_PRODUCT}
    Log To Console    PRODUCT: ${VALID_PRODUCT}
    Log To Console    INSERT RESULT: ${msg}
    Should Be Equal    ${msg}    INSERTED SUCCESS
    
Create Product - Missing Title
    ${msg}=    InsertOne    ${MONGODB_CONFIG}    ${MISSING_TITLE}
    Log To Console    PRODUCT: ${MISSING_TITLE}
    Log To Console    INSERT RESULT (Missing Title): ${msg}
    Should Not Be Equal    ${msg}    INSERTED SUCCESS
    Should Be Equal    ${msg}    INSERTED ERROR

Create Product - Invalid Price
    ${msg}=    InsertOne    ${MONGODB_CONFIG}    ${INVALID_PRICE}
    Log To Console    INSERT RESULT (Invalid Price): ${msg}
    Should Not Be Equal    ${msg}    INSERTED SUCCESS
    Should Be Equal    ${msg}    INSERTED ERROR

# READ
Read Product - Existing
    ${product}=    Get Product By Title    ${VALID_PRODUCT['title']}
    Log To Console    PRODUCT FETCHED: ${product}
    Should Not Be Equal    ${product}    ${None}
    Should Be Equal    ${product['title']}    ${VALID_PRODUCT['title']}

Read Product - Nonexistent Title
    ${product}=    Get Product By Title    Nonexistent Product XYZ
    Log To Console    NONEXISTENT PRODUCT RESULT: ${product}
    Should Be Equal    ${product}    ${None}

Read Product - Empty Title
    ${product}=    Get Product By Title    ${EMPTY}
    Log To Console    EMPTY TITLE RESULT: ${product}
    Should Be Equal    ${product}    ${None}

# UPDATE
Update Product - Valid
    ${product}=    Get Product By Title    ${VALID_PRODUCT['title']}
    Log To Console    PRODUCT TO UPDATE: ${product}
    Should Not Be Equal    ${product}    ${None}
    ${product_id}=    Set Variable    ${product['_id']}
    &{update_data}=    Create Dictionary    price=${899.99}
    Log To Console    UPDATE DATA: ${update_data}
    ${result}    ${status}=    Safe Update Product    ${product_id}    ${update_data}
    Log To Console    UPDATE RESULT: ${result}
    Log To Console    UPDATE STATUS: ${status}
    Should Be Equal    ${status}    PASS
    Should Be Equal    ${result}    UPDATED SUCCESS

Update Product - Wrong ID
    ${invalid_id}=    Set Variable    000000000000000000000000
    &{update_data}=   Create Dictionary    price=${10.00}
    Log To Console    UPDATE DATA (Wrong ID): ${update_data}
    ${result}    ${status}=    Safe Update Product    ${invalid_id}    ${update_data}
    Log To Console    UPDATE RESULT (Wrong ID): ${result}
    Log To Console    UPDATE STATUS (Wrong ID): ${status}
    Should Be Equal    ${result}    DATA NOT FOUND
    Should Be Equal    ${status}    FAIL

Update Product - Empty Data
    ${product}=    Get Product By Title    ${VALID_PRODUCT['title']}
    Log To Console    PRODUCT TO UPDATE (Empty Data): ${product}
    ${product_id}=    Set Variable    ${product['_id']}
    &{update_data}=    Create Dictionary
    Log To Console    UPDATE DATA (Empty): ${update_data}
    ${result}    ${status}=    Safe Update Product    ${product_id}    ${update_data}
    Log To Console    UPDATE RESULT (Empty): ${result}
    Log To Console    UPDATE STATUS (Empty): ${status}
    Should Be Equal    ${status}    FAIL

# DELETE
Delete Product - Valid
    ${product}=    Get Product By Title    ${VALID_PRODUCT['title']}
    Log To Console    PRODUCT TO DELETE: ${product}
    Should Not Be Equal    ${product}    ${None}
    ${product_id}=    Set Variable    ${product['_id']}
    ${result}    ${status}=    Safe Delete Product    ${product_id}
    Log To Console    DELETE RESULT: ${result}
    Log To Console    DELETE STATUS: ${status}
    Should Be Equal    ${status}    PASS
    Should Be Equal    ${result}    DELETED SUCCESS

Delete Product - Already Deleted
    ${product}=    Get Product By Title    ${VALID_PRODUCT['title']}
    Log To Console    PRODUCT ALREADY DELETED: ${product}
    Should Be Equal    ${product}    ${None}
    ${result}    ${status}=    Safe Delete Product    invalid_id_123
    Log To Console    DELETE RESULT (Already Deleted): ${result}
    Log To Console    DELETE STATUS (Already Deleted): ${status}
    Should Be Equal    ${status}    FAIL

Delete Product - Invalid ID
    ${result}    ${status}=    Safe Delete Product    invalid_object_id
    Log To Console    DELETE RESULT (Invalid ID): ${result}
    Log To Console    DELETE STATUS (Invalid ID): ${status}
    Should Be Equal    ${status}    FAIL
