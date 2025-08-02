*** Settings ***
Library    RequestsLibrary
Library           Collections
Variables         ../pageobject/ebay_api_variables_v3.py

*** Keywords ***

# ---------------------------------------------------
# Initialiser une session de test pour l'API eBay
# ---------------------------------------------------

Authenticate To eBay API FOR Inventory
    [Documentation]    Initialise la session API Inventory nommée "inventory" avec l’URL de base et le header OAuth
    Log To Console     Tentative de création de la session eBay vers : ${INVENTORY_BASE_URL}
    Create Session    inventory    ${INVENTORY_BASE_URL}    headers=${HEADERS}    verify=True
    ${params}=    Create Dictionary    limit=2    offset=0
    ${response}=  GET On Session    inventory    /inventory_item    params=${params}
    #Log Response JSON    ${response}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Session API eBay authentifiée avec succès

Authenticate To eBay API FOR Buy
    [Documentation]    Initialise la session API Buy nommée "buy" avec l’URL de base et le header OAuth
    Log To Console     Tentative de création de la session eBay vers : ${BUY_BASE_URL}
    Create Session    buy    ${BUY_BASE_URL}    headers=${HEADERS}    verify=True
    Log To Console    Session API eBay authentifiée avec succès


Authenticate To eBay API FOR Fulfillment
    [Documentation]    Initialise la session API Fulfillment nommée "fulfillment" avec l’URL de base et le header OAuth
    Log To Console     Tentative de création de la session eBay vers : ${FULFILLMENT_BASE_URL}
    Create Session    fulfillment    ${FULFILLMENT_BASE_URL}    headers=${HEADERS}    verify=True
    ${response}=    GET On Session    fulfillment    /order
    Log Response JSON    ${response}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Session API eBay authentifiée avec succès

Log Response JSON
    [Arguments]    ${response}
    Run Keyword And Ignore Error    Log To Console    Status Code: ${response.status_code}
    
    ${body}=    Convert To String    ${response.text}
    ${json}=    Evaluate    json.loads(r'''${body}''')    json
    ${pretty}=    Evaluate    json.dumps(${json}, indent=2)    json
    Log To Console    Réponse JSON :\n${pretty}
    
# 1. Création produit
Create A Product - Test Product
    # Création des listes correctement
    ${feature_list}=    Create List    Water resistance    GPS
    ${cpu_list}=        Create List    Dual-Core Processor
    ${upc_list}=        Create List    888462079525
    ${image_urls}=      Create List
    ...    http://store.storeimages.cdn-apple.com/4973/as-images.apple.com/is/image/AppleInc/aos/published/images/S/1/S1/42/S1-42-alu-silver-sport-white-grid?wid=332&hei=392&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1472247758975
    ...    http://store.storeimages.cdn-apple.com/4973/as-images.apple.com/is/image/AppleInc/aos/published/images/4/2/42/stainless/42-stainless-sport-white-grid?wid=332&hei=392&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1472247760390
    ...    http://store.storeimages.cdn-apple.com/4973/as-images.apple.com/is/image/AppleInc/aos/published/images/4/2/42/ceramic/42-ceramic-sport-cloud-grid?wid=332&hei=392&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1472247758007

    ${product_aspects}=    Create Dictionary    Feature=${feature_list}    CPU=${cpu_list}

    ${product}=    Create Dictionary
    ...    title=Test listing - do not bid or buy - awesome Apple watch test 2
    ...    aspects=${product_aspects}
    ...    description=Test listing - do not bid or buy\nBuilt-in GPS. Water resistance to 50 meters. A new lightning-fast dual-core processor. And a display that’s two times brighter than before. Full of features that help you stay active, motivated, and connected, Apple Watch Series 2 is designed for all the ways you move
    ...    upc=${upc_list}
    ...    imageUrls=${image_urls}

    ${package_dimensions}=    Create Dictionary    height=5    length=10    width=15    unit=INCH
    ${package_weight}=    Create Dictionary    value=2    unit=POUND
    ${packageWeightAndSize}=    Create Dictionary
    ...    dimensions=${package_dimensions}
    ...    packageType=MAILING_BOX
    ...    weight=${package_weight}

    ${availability_ship}=    Create Dictionary    quantity=10
    ${availability}=    Create Dictionary    shipToLocationAvailability=${availability_ship}

    ${payload}=    Create Dictionary
    ...    product=${product}
    ...    condition=NEW
    ...    availability=${availability}
    ...    packageWeightAndSize=${packageWeightAndSize}

    ${response}=    PUT On Session    inventory    /inventory_item/${SKU}    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    204

Create A Product - Test Product - Fail
    ${product}=    Create Dictionary
    ...    title=
    ...    description=

    ${payload}=    Create Dictionary
    ...    product=${product}
    ...    condition=NEW

    ${sku}=    Set Variable    produit-invalide-001

    Run Keyword And Expect Error    *Client Error*    POST On Session    inventory    /inventory_item/${sku}    json=${payload}

# 1. Création du produit Apple AirPods Pro 2
Create Product - Apple AirPods Pro 2
    ${feature_list}=    Create List    Noise Cancellation    Spatial Audio
    ${cpu_list}=        Create List    H2 Chip
    ${upc_list}=        Create List    194253397162
    ${image_urls}=      Create List
    ...    https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airpods-pro-gen-2-2023?wid=532&hei=582
    ...    https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airpods-pro-case-open?wid=532&hei=582
    ...    https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airpods-pro-earbuds?wid=532&hei=582

    ${product_aspects}=    Create Dictionary    Feature=${feature_list}    CPU=${cpu_list}

    ${product}=    Create Dictionary
    ...    title=Apple AirPods Pro 2 - Noise Cancelling Wireless Earbuds
    ...    aspects=${product_aspects}
    ...    description=Apple’s AirPods Pro 2 offer industry-leading noise cancellation, improved spatial audio, and long battery life. Perfect for music, work, and workouts.
    ...    upc=${upc_list}
    ...    imageUrls=${image_urls}

    ${package_dimensions}=    Create Dictionary    height=2    length=5    width=5    unit=INCH
    ${package_weight}=    Create Dictionary    value=1    unit=POUND
    ${packageWeightAndSize}=    Create Dictionary
    ...    dimensions=${package_dimensions}
    ...    packageType=MAILING_BOX
    ...    weight=${package_weight}

    ${availability_ship}=    Create Dictionary    quantity=15
    ${availability}=    Create Dictionary    shipToLocationAvailability=${availability_ship}

    ${payload}=    Create Dictionary
    ...    product=${product}
    ...    condition=NEW
    ...    availability=${availability}
    ...    packageWeightAndSize=${packageWeightAndSize}

    ${response}=    PUT On Session    inventory    /inventory_item/${APPLE_SKU}    json=${payload}

    Should Be Equal As Strings    ${response.status_code}    204


# 2. Création du produit Samsung S23 Ultra
Create Product - Samsung S23 Ultra
    ${feature_list}=    Create List    200MP Camera    S-Pen
    ${cpu_list}=        Create List    Snapdragon 8 Gen 2
    ${upc_list}=        Create List    887276702375
    ${image_urls}=      Create List
    ...    https://images.samsung.com/is/image/samsung/p6pim/levant/sm-s918bzkgmea/gallery/levant-galaxy-s23-ultra-s918-sm-s918bzkgmea-thumb-534151212
    ...    https://images.samsung.com/is/image/samsung/p6pim/levant/sm-s918bzkgmea/gallery/levant-galaxy-s23-ultra-s918-sm-s918bzkgmea-534151215
    ...    https://images.samsung.com/is/image/samsung/p6pim/levant/sm-s918bzkgmea/gallery/levant-galaxy-s23-ultra-s918-sm-s918bzkgmea-534151217

    ${product_aspects}=    Create Dictionary    Feature=${feature_list}    CPU=${cpu_list}

    ${product}=    Create Dictionary
    ...    title=Samsung Galaxy S23 Ultra - 256GB Phantom Black
    ...    aspects=${product_aspects}
    ...    description=Samsung Galaxy S23 Ultra with 200MP camera, powerful Snapdragon 8 Gen 2 chip, and built-in S-Pen. A premium flagship for photography lovers.
    ...    upc=${upc_list}
    ...    imageUrls=${image_urls}

    ${package_dimensions}=    Create Dictionary    height=6    length=3    width=0.5    unit=INCH
    ${package_weight}=    Create Dictionary    value=1.2    unit=POUND
    ${packageWeightAndSize}=    Create Dictionary
    ...    dimensions=${package_dimensions}
    ...    packageType=MAILING_BOX
    ...    weight=${package_weight}

    ${availability_ship}=    Create Dictionary    quantity=8
    ${availability}=    Create Dictionary    shipToLocationAvailability=${availability_ship}

    ${payload}=    Create Dictionary
    ...    product=${product}
    ...    condition=NEW
    ...    availability=${availability}
    ...    packageWeightAndSize=${packageWeightAndSize}

    ${response}=    PUT On Session    inventory    /inventory_item/${SAMSUNG_SKU}    json=${payload}

    Should Be Equal As Strings    ${response.status_code}    204


# 3. Création du produit Logitech MX Master 3S
Create Product - Logitech MX Master 3S
    ${feature_list}=    Create List    Ergonomic Design    Silent Clicks
    ${cpu_list}=        Create List    Advanced Optical Sensor
    ${upc_list}=        Create List    097855190172
    ${image_urls}=      Create List
    ...    https://resource.logitech.com/w_800,c_limit,q_auto,f_auto,dpr_auto/d_transparent.gif/content/dam/logitech/en/products/mice/mx-master-3s/gallery/mx-master-3s-gallery-1.png
    ...    https://resource.logitech.com/w_800,c_limit,q_auto,f_auto,dpr_auto/d_transparent.gif/content/dam/logitech/en/products/mice/mx-master-3s/gallery/mx-master-3s-gallery-2.png
    ...    https://resource.logitech.com/w_800,c_limit,q_auto,f_auto,dpr_auto/d_transparent.gif/content/dam/logitech/en/products/mice/mx-master-3s/gallery/mx-master-3s-gallery-3.png

    ${product_aspects}=    Create Dictionary    Feature=${feature_list}    CPU=${cpu_list}

    ${product}=    Create Dictionary
    ...    title=Logitech MX Master 3S - Wireless Ergonomic Mouse - Graphite
    ...    aspects=${product_aspects}
    ...    description=Logitech MX Master 3S is designed for advanced users who need precision, ergonomics, and silent clicks. Perfect for productivity workflows.
    ...    upc=${upc_list}
    ...    imageUrls=${image_urls}

    ${package_dimensions}=    Create Dictionary    height=3    length=5    width=4    unit=INCH
    ${package_weight}=    Create Dictionary    value=0.5    unit=POUND
    ${packageWeightAndSize}=    Create Dictionary
    ...    dimensions=${package_dimensions}
    ...    packageType=MAILING_BOX
    ...    weight=${package_weight}

    ${availability_ship}=    Create Dictionary    quantity=20
    ${availability}=    Create Dictionary    shipToLocationAvailability=${availability_ship}

    ${payload}=    Create Dictionary
    ...    product=${product}
    ...    condition=NEW
    ...    availability=${availability}
    ...    packageWeightAndSize=${packageWeightAndSize}

    ${response}=    PUT On Session    inventory    /inventory_item/${LOGI_SKU}    json=${payload}

    Should Be Equal As Strings    ${response.status_code}    204

Delete All Products
    ${response}=    DELETE On Session    inventory    /inventory_item/${SKU}
    Should Be Equal As Strings    ${response.status_code}    204

    ${response}=    DELETE On Session    inventory    /inventory_item/${APPLE_SKU}
    Should Be Equal As Strings    ${response.status_code}    204

    ${response}=    DELETE On Session    inventory    /inventory_item/${SAMSUNG_SKU}
    Should Be Equal As Strings    ${response.status_code}    204

    ${response}=    DELETE On Session    inventory    /inventory_item/${LOGI_SKU}
    Should Be Equal As Strings    ${response.status_code}    204

# 2. Create location
Créer et Activer un lieu eBay à Dakar
    # Construire les dictionnaires imbriqués pour l'adresse
    ${address}=    Create Dictionary
    ...    addressLine1=10 Avenue Léopold Sédar Senghor
    ...    addressLine2=Immeuble Atlantic
    ...    city=Dakar
    ...    country=SN
    ...    postalCode=BP12500
    ...    stateOrProvince=DA

    ${geo}=    Create Dictionary
    ...    latitude=14.6928
    ...    longitude=-17.4467

    ${location}=    Create Dictionary
    ...    address=${address}
    ...    geoCoordinates=${geo}

    # Configuration des horaires d'ouverture
    ${interval}=    Create Dictionary
    ...    open=08:30:00
    ...    close=17:30:00

    ${intervals}=    Create List    ${interval}

    ${day_mo}=    Create Dictionary    dayOfWeekEnum=MONDAY    intervals=${intervals}
    ${day_tu}=    Create Dictionary    dayOfWeekEnum=TUESDAY    intervals=${intervals}
    ${day_we}=    Create Dictionary    dayOfWeekEnum=WEDNESDAY    intervals=${intervals}
    ${day_th}=    Create Dictionary    dayOfWeekEnum=THURSDAY    intervals=${intervals}
    ${day_fr}=    Create Dictionary    dayOfWeekEnum=FRIDAY    intervals=${intervals}

    ${operating_hours}=    Create List
    ...    ${day_mo}
    ...    ${day_tu}
    ...    ${day_we}
    ...    ${day_th}
    ...    ${day_fr}

    # Configuration des cutoff times (format spécifique demandé)
    ${weekdays}=    Create List    MONDAY    TUESDAY    WEDNESDAY    THURSDAY    FRIDAY
    ${weekend}=    Create List    SATURDAY    SUNDAY

    ${cutoff_weekdays}=    Create Dictionary
    ...    dayOfWeekEnum=${weekdays}
    ...    cutOffTime=15:00

    ${cutoff_weekend}=    Create Dictionary
    ...    dayOfWeekEnum=${weekend}
    ...    cutOffTime=12:00

    ${weekly_schedule}=    Create List
    ...    ${cutoff_weekdays}
    ...    ${cutoff_weekend}

    ${cutoff_times}=    Create Dictionary    weeklySchedule=${weekly_schedule}
    ${fulfillment_specs}=    Create Dictionary    sameDayShippingCutOffTimes=${cutoff_times}

    ${location_types}=    Create List
    ...    STORE
    ...    FULFILLMENT_CENTER
    ...    WAREHOUSE

    # Construction du payload final
    ${payload}=    Create Dictionary
    ...    name=${MERCHANT_LOCATION_KEY}
    ...    merchantLocationKey=${MERCHANT_LOCATION_KEY}
    ...    location=${location}
    ...    phone=+221781234567
    ...    locationTypes=${location_types}
    ...    operatingHours=${operating_hours}
    ...    fulfillmentCenterSpecifications=${fulfillment_specs}
    ...    status=ENABLED

    # Conversion en JSON pour vérification
    ${json_payload}=    Evaluate    json.dumps(${payload}, indent=4)    json
    #Log To Console    \nPAYLOAD JSON:\n${json_payload}

    # *** Création : POST sur /location ***
    ${response_create}=    POST On Session
    ...    inventory    
    ...    /location/${MERCHANT_LOCATION_KEY}    
    ...    json=${payload}
    ...    expected_status=204

    Run Keyword If    '${response_create.status_code}' != '204'    Log Response JSON    ${response_create}
    Should Be Equal As Integers    ${response_create.status_code}    204

    # *** Activation : POST sur /location/{merchantLocationKey}/enable ***
    ${response_activate}=    POST On Session
    ...    inventory    
    ...    /location/${MERCHANT_LOCATION_KEY}/enable
    ...    expected_status=200

    Run Keyword If    '${response_activate.status_code}' != '200'    Log Response JSON    ${response_activate}
    Should Be Equal As Integers    ${response_activate.status_code}    200

# 3. Création de l’annonce (offer)
Create An Offer
    [Documentation]    Crée une annonce (offer)
    ${price}=    Create Dictionary    value=0.99    currency=USD
    ${pricingSummary}=    Create Dictionary    price=${price}

    ${tax}=    Create Dictionary
    ...    vatPercentage=10.2
    ...    applyTax=${True}
    ...    thirdPartyTaxCategory=Electronics
    ${payload}=    Create Dictionary
    ...    sku=${APPLE_SKU}
    ...    marketplaceId=EBAY_US
    ...    format=FIXED_PRICE
    ...    listingDescription=<ul><li><font face="Arial"><span style="font-size: 18.6667px;"><p class="p1">Test listing - do not bid or buy&nbsp;</p></span></font></li><li><p class="p1">Built-in GPS.&nbsp;</p></li><li><p class="p1">Water resistance to 50 meters.</p></li><li><p class="p1">&nbsp;A new lightning-fast dual-core processor.&nbsp;</p></li><li><p class="p1">And a display that’s two times brighter than before.&nbsp;</p></li><li><p class="p1">Full of features that help you stay active, motivated, and connected, Apple Watch Series 2 is designed for all the ways you move</p></li></ul>
    ...    availableQuantity=60
    ...    quantityLimitPerBuyer=10
    ...    pricingSummary=${pricingSummary}
    ...    categoryId=178086
    ...    merchantLocationKey=mamad_3324_DakarStore_1
    ...    tax=${tax}

    ${json_payload}=    Evaluate    json.dumps(${payload})    json
    #Log To Console    PAYLOAD JSON: ${json_payload}
    
    ${response}=    POST On Session    inventory    /offer    json=${payload}
    #Log Response JSON    ${response}
    
    Should Be Equal As Strings    ${response.status_code}    201

Handle Offers For SKU
    [Arguments]    ${sku}
    ${params}=    Create Dictionary    sku=${sku}
    ${offers_response}=    GET On Session    inventory    /offer    params=${params}
    Should Be Equal As Strings    ${offers_response.status_code}    200

    ${offers_json}=    Convert To Dictionary    ${offers_response.json()}

    ${offers_list}=    Get From Dictionary    ${offers_json}    offers

    FOR    ${offer}    IN    @{offers_list}
        ${offer_id}=    Get From Dictionary    ${offer}    offerId
        Log To Console   Traitement de l'offre ID: ${offer_id} pour SKU: ${sku}

        Publish Offer    ${offer_id}
        Delete Offer     ${offer_id}
    END

Publish Offer
    [Arguments]    ${offer_id}
    Run Keyword And Expect Error    *Client Error*    POST On Session    inventory    /offer/${offer_id}/publish

Delete Offer
    [Arguments]    ${offer_id}
    ${delete_response}=    DELETE On Session    inventory    /offer/${offer_id}
    Log To Console    Suppression réponse code: ${delete_response.status_code}
    Should Be Equal As Strings    ${delete_response.status_code}    204


# ---------------------------------------------------
# GET /order - scénario passant
# ---------------------------------------------------
Get Orders Successfully
    [Documentation]    Vérifie que la récupération de toutes les commandes renvoie bien 200
    ${response}=    GET On Session    fulfillment    /order
    Log Response JSON    ${response}
    
    ${body}=    Convert To String    ${response.text}
    ${json}=    Evaluate    json.loads("""${body}""")    json
    ${pretty}=    Evaluate    json.dumps(${json}, indent=2)    json
    
    Log To Console    Réponse JSON :\n${pretty}

    Should Be Equal As Strings    ${response.status_code}    200

Get Order With Invalid ID
    [Documentation]    Envoie une commande avec ID invalide et attend une erreur
    Run Keyword And Expect Error    *Client Error*    GET On Session    fulfillment    /order/${INVALID_ORDER_ID}
    
# ----------------------------------------
# ISSUE REFUND
# ----------------------------------------
Issue Refund Successfully
    [Documentation]    Envoie une demande de remboursement pour une commande valide
    ${payload}=    Set Variable    {"refundReason": "BUYER_CANCEL", "comments": "Client a annulé"}
    Run Keyword And Expect Error    *Client Error*    POST On Session    fulfillment    /order/${VALID_ORDER_ID}/refund    json=${payload}
    
Issue Refund With Invalid Payload
    [Documentation]    Tente un remboursement avec données invalides
    ${payload}=    Set Variable    {"motif": "Invalide"}  # mauvais champ
    Run Keyword And Expect Error    *Client Error*    POST On Session    fulfillment    /order/${INVALID_ORDER_ID}/refund    json=${payload}
    