### resources/mongo_resource_keywords.robot
*** Settings ***
Resource    ../pageobject/mongodb_variables.robot

*** Keywords ***
Initialize MongoDB Connection
    [Documentation]    Établit la connexion à MongoDB
    Log To Console    Connexion établie avec ${MONGODB_CONFIG['connection']}

Clean Test Data
    ${filter}=    Create Dictionary    title=${VALID_PRODUCT['title']}
    ${results}=    Find    ${MONGODB_CONFIG}    ${filter}
    ${results_list}=    Convert To List    ${results}
    FOR    ${doc}    IN    @{results_list}
        ${doc_dict}=    Evaluate    ast.literal_eval("""${doc}""")    ast
        DeleteOneByID    ${MONGODB_CONFIG}    ${doc_dict['_id']}
    END

Get Product By Title
    [Arguments]    ${title}
    ${filter}=    Create Dictionary    title=${title}
    ${results}=    Find    ${MONGODB_CONFIG}    ${filter}
    ${results_list}=    Convert To List    ${results}
    ${is_empty}=    Evaluate    len(${results_list}) == 0
    Run Keyword If    ${is_empty}    Return From Keyword    ${None}
    ${product}=    Evaluate    ast.literal_eval("""${results_list[0]}""")    ast
    RETURN    ${product}

Safe Update Product
    [Arguments]    ${product_id}    ${update_data}
    ${result}=    Update    ${MONGODB_CONFIG}    ${product_id}    ${update_data}
    ${status}=    Set Variable If
    ...    "${result}" == "UPDATED SUCCESS"    PASS
    ...    "${result}" == "DATA NOT FOUND"    FAIL
    ...    FAIL
    RETURN    ${result}    ${status}

Safe Delete Product
    [Arguments]    ${product_id}
    ${result}=    DeleteOneByID    ${MONGODB_CONFIG}    ${product_id}
    ${status}=    Set Variable If
    ...    "${result}" == "DELETED SUCCESS"    PASS
    ...    "${result}" == "DATA NOT FOUND"    FAIL
    ...    FAIL
    RETURN    ${result}    ${status}
