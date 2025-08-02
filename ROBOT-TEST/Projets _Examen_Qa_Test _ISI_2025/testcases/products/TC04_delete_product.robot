*** Settings ***
Suite Setup     Connect To MongoDB
Suite Teardown  Disconnect From MongoDB
Resource        ../../resources/mongo_setup.robot
Resource        ../../resources/products_keywords.robot
Resource        ../../resources/test_data.robot

*** Test Cases ***
Delete Product - Valid ID
    [Tags]    Delete    Positive
    ${product_id}=    Insert Product    ${VALID_PRODUCT}
    Delete Product By ID    ${product_id}

Delete Product - Already Deleted
    [Tags]    Delete    Negative
    ${product_id}=    Insert Product    ${VALID_PRODUCT}
    Delete Product By ID    ${product_id}
    Run Keyword And Expect Error    *    Delete Product By ID    ${product_id}

Delete Product - Invalid ID Format
    [Tags]    Delete    Negative
    Run Keyword And Expect Error    *    Delete Product By ID    ${INVALID_ID}
