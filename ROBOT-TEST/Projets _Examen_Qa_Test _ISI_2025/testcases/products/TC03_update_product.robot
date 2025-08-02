*** Settings ***
Suite Setup     Connect To MongoDB
Suite Teardown  Disconnect From MongoDB
Resource        ../../resources/mongo_setup.robot
Resource        ../../resources/products_keywords.robot
Resource        ../../resources/test_data.robot

*** Test Cases ***
Update Product - Valid Data
    [Tags]    Update    Positive
    ${product_id}=    Insert Product    ${VALID_PRODUCT}
    ${updated_fields}=    Create Dictionary    price=49.99
    Update Product By ID    ${product_id}    ${updated_fields}

Update Product - Invalid Price
    [Tags]    Update    Negative
    ${product_id}=    Insert Product    ${VALID_PRODUCT}
    ${invalid_update}=    Create Dictionary    price=-100
    Run Keyword And Expect Error    *    Update Product By ID    ${product_id}    ${invalid_update}

Update Product - Non-existent ID
    [Tags]    Update    Negative
    ${fields}=    Create Dictionary    price=59.99
    Run Keyword And Expect Error    *    Update Product By ID    ${NON_EXISTENT_ID}    ${fields}
