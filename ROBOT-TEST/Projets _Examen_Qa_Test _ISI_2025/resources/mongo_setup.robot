*** Settings ***
Library           OperatingSystem
Library           String
Variables         ../pageobject/variables.py

*** Variables ***
${client}         None
${db}             None

*** Keywords ***
Connect To MongoDB
    [Documentation]    Connexion sécurisée MongoDB Atlas avec ServerApi via pymongo
    ${client}=    Evaluate    __import__('pymongo').MongoClient("${MONGO_CONNECTION_STRING}", server_api=__import__('pymongo').server_api.ServerApi('1'))
    Set Suite Variable    ${client}

    ${db}=    Evaluate    ${client}.get_database("${DATABASE_NAME}")
    Set Suite Variable    ${db}
    
    # Vérification de connexion
    TRY
        ${ping_result}=    Evaluate    ${client}.admin.command('ping')
        Log    ✅ Connexion MongoDB réussie : ${ping_result}
    EXCEPT
        Log    ❌ Échec de connexion à MongoDB
        Fail    Connexion impossible à la base de données MongoDB
    END

Disconnect From MongoDB
    [Documentation]    Ferme proprement la connexion MongoDB
    Run Keyword If    '${client}' != 'None'    Evaluate    ${client}.close()
    Log    🔌 Connexion MongoDB fermée


