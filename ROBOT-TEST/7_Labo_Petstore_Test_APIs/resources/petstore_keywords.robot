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
    #Disable SSL Warnings
    Create Session To PetStore

Create Session To PetStore
    [Documentation]    Creates HTTP session to PetStore API
    ...                - Base URL: ${BASE_URL}
    ...                - Headers: ${HEADERS}
    ...                - SSL Verification: Enabled
    
    # Verify connection parameters before creating session
    Should Not Be Empty    ${BASE_URL}    msg=Base URL not configured
    Should Contain    ${BASE_URL}    https://    msg=Insecure HTTP protocol
    Should Contain    ${BASE_URL}    /v2    msg=Missing API version path
    
    Log To Console    Creating session to: ${BASE_URL}
    ${session}=    Create Session    petstore    ${BASE_URL}    headers=${HEADERS}    verify=True
    
    RETURN    ${session}

Add New Pet
    [Arguments]    ${pet_data}
    
    ${json_string}=    Evaluate    json.dumps(${pet_data})    json
    #Log To Console  Correct payload: ${json_string}    level=DEBUG
    
    ${response}=    POST On Session    petstore    /pet
    ...    data=${json_string}
    ...    headers=${HEADERS}
    ...    expected_status=200
    
    #Log To Console  ${response.json()}

    Should Be Equal As Strings    ${response.status_code}    200
    
    RETURN    ${response.json()}

Get Pet By ID
    [Arguments]    ${pet_id}
    ${response}=    GET On Session    petstore    /pet/${pet_id}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Update Pet
    [Arguments]    ${pet_data}
    ${json_data}=    Evaluate    json.dumps(${pet_data})    json
    ${response}=    PUT On Session    petstore    /pet    data=${json_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}

Delete Pet
    [Arguments]    ${pet_id}
    ${response}=    DELETE On Session    petstore    /pet/${pet_id}
    Should Be Equal As Strings    ${response.status_code}    200


