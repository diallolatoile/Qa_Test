*** Settings ***
Resource          ../resources/ebay_api_keywords.robot

# Initialiser les sessions API avant l'exécution de la suite
Suite Setup       Setup Test Environment

*** Keywords ***
Setup Test Environment
    Authenticate To eBay API FOR Inventory
    Authenticate To eBay API FOR Buy
    Authenticate To eBay API FOR Fulfillment


*** Test Cases ***

# -------------------------------
# TC_0001 - Création produit
# -------------------------------
TC_0001 Création De Produits - Success
    [Tags]    inventory    create    positive
    Create A Product - Test Product
    Create Product - Apple AirPods Pro 2
    Create Product - Logitech MX Master 3S
    Create Product - Samsung S23 Ultra

TC_0002 Création De Produit - Fail
    [Tags]    inventory    create    negative    regression
    Create A Product - Test Product - Fail

#TC_0003 Suppression De Produits
#    [Tags]    inventory    delete    positive
#    Delete All Products

TC_0003 Créer et Activer un lieu eBay à Dakar
    [Tags]    inventory    location    positive
    Créer et Activer un lieu eBay à Dakar

# -------------------------------
# TC_0003 - Création offre
# -------------------------------
TC_0003 Création D’Offre
    [Tags]    inventory    offer    positive
    Create An Offer

TC_0003 Publication D’Offre et Delete All Offers
    [Tags]    inventory    offer    publish    positive
    Handle Offers For SKU    ${APPLE_SKU}

# ------------------------------------------------------------------
# TC_1001 : Test de récupération de toutes les commandes (GET /order)
# ------------------------------------------------------------------
TC_1001 Get Orders - Success
    [Tags]    getorders    api    positive    smoke
    Get Orders Successfully

TC_1002 Get Order - Fail (Invalid ID)
    [Tags]    getorder    api    negative    regression
    Get Order With Invalid ID

# ---------------------------
# ISSUE REFUND
# ---------------------------

TC_1003 Issue Refund - Success
    [Tags]    issuerefund    api    positive    critical
    Issue Refund Successfully

TC_1003 Issue Refund - Fail (Invalid Payload)
    [Tags]    issuerefund    api    negative    regression
    Issue Refund With Invalid Payload
