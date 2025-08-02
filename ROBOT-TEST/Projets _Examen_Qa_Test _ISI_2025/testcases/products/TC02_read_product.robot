*** Settings ***
Suite Setup     Connect To MongoDB
Suite Teardown  Disconnect From MongoDB
Resource        ../../resources/mongo_setup.robot
Resource        ../../resources/products_keywords.robot
Resource        ../../resources/test_data.robot

*** Test Cases ***
Read Product - Valid ID
    [Tags]    Read    Positive
    ${product_id}=    Insert Product    ${VALID_PRODUCT}
    ${product}=    Find Product By ID    ${product_id}
    Should Be Equal    ${product['title']}    ${VALID_PRODUCT['title']}

Read Product - Non-existent ID
    [Tags]    Read    Negative
    Run Keyword And Expect Error    *    Find Product By ID    ${NON_EXISTENT_ID}

Read Product - Invalid ID Format
    [Tags]    Read    Negative
    Run Keyword And Expect Error    *    Find Product By ID    ${INVALID_ID}
