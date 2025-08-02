*** Settings ***
Suite Setup     Connect To MongoDB
Suite Teardown  Disconnect From MongoDB
Resource        ../../resources/mongo_setup.robot
Resource        ../../resources/products_keywords.robot
Resource        ../../resources/test_data.robot

*** Test Cases ***
Create Product - Valid Data
    [Tags]    Create    Positive
    ${product_id}=    Insert Product    ${VALID_PRODUCT}
    Log    Produit créé avec succès : ${product_id}

Create Product - Missing Title
    [Tags]    Create    Negative
    Run Keyword And Expect Error    *    Insert Product    ${INVALID_PRODUCT_NO_TITLE}

Create Product - Negative Price
    [Tags]    Create    Negative
    Run Keyword And Expect Error    *    Insert Product    ${INVALID_PRODUCT_NEGATIVE_PRICE}
