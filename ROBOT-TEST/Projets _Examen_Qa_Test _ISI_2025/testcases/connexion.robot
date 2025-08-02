*** Settings ***
Resource        ../resources/mongo_setup.robot
Resource        ../resources/products_keywords.robot
Resource        ../resources/test_data.robot

*** Test Cases ***
Test Connexion MongoDB
    [Tags]    Test Connexion    Positive
    Connect To MongoDB
    Disconnect From MongoDB
