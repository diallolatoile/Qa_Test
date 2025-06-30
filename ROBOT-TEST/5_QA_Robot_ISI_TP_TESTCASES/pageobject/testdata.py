### pageobject/testdata.py

# Identifiants valides pour authentification
VALID_USERNAME_AUTOMATION = "admin@robotframeworktutorial.com"
VALID_PASSWORD_AUTOMATION = "pwd"

# Informations sur le testeur
TESTER_FIRSTNAME = "Mamadou Bobo"
TESTER_LASTNAME = "DIALLO"
# Client 1 - Male Customer CA
MALE_CUSTOMER_EMAIL = "john.doe@test.com"
MALE_CUSTOMER_FIRSTNAME = "John"
MALE_CUSTOMER_LASTNAME = "Doe"
MALE_CUSTOMER_CITY = "Los Angeles"
MALE_CUSTOMER_STATE = "CA"
MALE_CUSTOMER_GENDER = "male"
MALE_CUSTOMER_ACTIVE = True

# Client 2 - Female Customer NY
FEMALE_CUSTOMER_EMAIL = "jane.smith@test.com"
FEMALE_CUSTOMER_FIRSTNAME = "Jane"
FEMALE_CUSTOMER_LASTNAME = "Smith"
FEMALE_CUSTOMER_CITY = "New York"
FEMALE_CUSTOMER_STATE = "NY"
FEMALE_CUSTOMER_GENDER = "female"
FEMALE_CUSTOMER_ACTIVE = False

# Liste dynamique pour boucle Robot Framework
CUSTOMERS = [
    {
        "email": MALE_CUSTOMER_EMAIL,
        "firstname": MALE_CUSTOMER_FIRSTNAME,
        "lastname": MALE_CUSTOMER_LASTNAME,
        "city": MALE_CUSTOMER_CITY,
        "state": MALE_CUSTOMER_STATE,
        "gender": MALE_CUSTOMER_GENDER,
        "active": MALE_CUSTOMER_ACTIVE
    },
    {
        "email": FEMALE_CUSTOMER_EMAIL,
        "firstname": FEMALE_CUSTOMER_FIRSTNAME,
        "lastname": FEMALE_CUSTOMER_LASTNAME,
        "city": FEMALE_CUSTOMER_CITY,
        "state": FEMALE_CUSTOMER_STATE,
        "gender": FEMALE_CUSTOMER_GENDER,
        "active": FEMALE_CUSTOMER_ACTIVE
    }
]
