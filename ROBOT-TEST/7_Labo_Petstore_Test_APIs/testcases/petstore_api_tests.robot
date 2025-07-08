*** Settings ***
Library    Collections
Resource    ../resources/petstore_keywords.robot
Variables    ../pageobject/testdata.py

Suite Setup    Suite Setup

*** Variables ***
# Données de test pour un animal (Pet) - Format exact JSON
&{TEST_PET_DOG}
    ...    id=${DOG_ID}
    ...    name=${DOG_NAME}
    ...    category=${DOG_CATEGORY}
    ...    photoUrls=${DOG_PHOTO_URLS}
    ...    tags=${DOG_TAGS}
    ...    status=${DOG_STATUS}

# Données de mise à jour
&{TEST_PET_DOG_UPDATE}
    ...    id=${DOG_ID}
    ...    name=${DOG_NAME_UPDATE}
    ...    category=${DOG_CATEGORY}
    ...    photoUrls=${DOG_PHOTO_URLS}
    ...    tags=${DOG_TAGS}
    ...    status=${DOG_STATUS_UPDATE}

&{TEST_PET_CAT}
    ...    id=${CAT_ID}
    ...    name=${CAT_NAME}
    ...    category=${CAT_CATEGORY}
    ...    photoUrls=${CAT_PHOTO_URLS}
    ...    tags=${CAT_TAGS}
    ...    status=${CAT_STATUS}

# Données de mise à jour
&{TEST_PET_CAT_UPDATE}
    ...    id=${CAT_ID}
    ...    name=${CAT_NAME_UPDATE}
    ...    category=${CAT_CATEGORY}
    ...    photoUrls=${CAT_PHOTO_URLS}
    ...    tags=${CAT_TAGS}
    ...    status=${CAT_STATUS_UPDATE}

*** Test Cases ***

TC00 - Verify API Connection
    Create Session To PetStore
    ${response}=    GET On Session    petstore    /swagger.json
    Should Be Equal As Strings    ${response.status_code}    200
    Should Contain    ${response.text}    Petstore

TC001 - Debug API Connection
    Create Session To PetStore
    ${response}=    GET On Session    petstore    /swagger.json
    Log    API Status: ${response.status_code}
    Log    API Response: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    200

TC01 - Add New Pet
    ${new_pet}=    Add New Pet    ${TEST_PET_DOG}
    Should Be Equal As Integers    ${new_pet['id']}    ${TEST_PET_DOG['id']}
    Should Be Equal As Strings    ${new_pet['name']}    ${TEST_PET_DOG['name']}

TC001 - Add New Pet
    ${new_pet}=    Add New Pet    ${TEST_PET_CAT}
    Should Be Equal As Integers    ${new_pet['id']}    ${TEST_PET_CAT['id']}
    Should Be Equal As Strings    ${new_pet['name']}    ${TEST_PET_CAT['name']}

TC02 - Get Pet By ID
    ${pet}=    Get Pet By ID    ${TEST_PET_DOG['id']}
    Should Be Equal As Strings    ${pet['name']}    ${TEST_PET_DOG['name']}

TC002 - Get Pet By ID
    ${pet}=    Get Pet By ID    ${TEST_PET_CAT['id']}
    Should Be Equal As Strings    ${pet['name']}    ${TEST_PET_CAT['name']}

TC03 - Update Pet
    ${updated_pet}=    Update Pet    ${TEST_PET_DOG_UPDATE}
    Should Be Equal As Strings    ${updated_pet['name']}    ${TEST_PET_DOG_UPDATE['name']}
    Should Be Equal As Strings    ${updated_pet['status']}    ${TEST_PET_DOG_UPDATE['status']}

TC003 - Update Pet
    ${updated_pet}=    Update Pet    ${TEST_PET_CAT_UPDATE}
    Should Be Equal As Strings    ${updated_pet['name']}    ${TEST_PET_CAT_UPDATE['name']}
    Should Be Equal As Strings    ${updated_pet['status']}    ${TEST_PET_CAT_UPDATE['status']}

TC04 - Delete Pet
    Delete Pet    ${TEST_PET_DOG['id']}
    
TC004 - Delete Pet
    Delete Pet    ${TEST_PET_CAT['id']}