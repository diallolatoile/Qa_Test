*** Settings ***
Library    Collections
Variables  ../pageobject/locator.py

*** Keywords ***
Insert Product
    [Arguments]    ${product}
    ${result}=    Evaluate    ${db}["${PRODUCTS_COLLECTION}"].insert_one(${product})
    Should Not Be Empty    ${result.inserted_id}
    RETURN    ${result.inserted_id}

Find Product By ID
    [Arguments]    ${product_id}
    ${ObjectId}=    Evaluate    __import__('bson').ObjectId("${product_id}")
    ${product}=    Evaluate    ${db}["${PRODUCTS_COLLECTION}"].find_one({"_id": ${ObjectId}})
    Should Not Be Empty    ${product}
    RETURN    ${product}

Update Product By ID
    [Arguments]    ${product_id}    ${fields_to_update}
    ${ObjectId}=    Evaluate    __import__('bson').ObjectId("${product_id}")
    ${result}=    Evaluate    ${db}["${PRODUCTS_COLLECTION}"].update_one({"_id": ${ObjectId}}, {"$set": ${fields_to_update}})
    Should Be Equal As Integers    ${result.matched_count}    1
    Should Be Equal As Integers    ${result.modified_count}    1

Delete Product By ID
    [Arguments]    ${product_id}
    ${ObjectId}=    Evaluate    __import__('bson').ObjectId("${product_id}")
    ${result}=    Evaluate    ${db}["${PRODUCTS_COLLECTION}"].delete_one({"_id": ${ObjectId}})
    Should Be Equal As Integers    ${result.deleted_count}    1
