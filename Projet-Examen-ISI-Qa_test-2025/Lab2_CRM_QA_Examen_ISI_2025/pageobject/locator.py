### pageobject/locator.py

HOME_PAGE_TEXT = "xpath=/html/body/div/section/div/div/div[1]/h2"

LOGIN_LINK = "xpath=/html/body/nav/ul/li/a"

# Login Page

LOGIN_FORM = "xpath=/html/body/section/div/div/div/div/form"
LOGIN_PAGE_TEXT = "xpath=/html/body/section/div/div/div/div/h2"
LOGOUT_SUCCESS_TEXT = "xpath=/html/body/div/section/div/div/div[1]/h2"

LOGIN_EMAIL = "id=email-id"
LOGIN_PASSWORD = "id=password"

LOGIN_SUBMIT_BUTTON = "id=submit-id"

CUSTOMERS_PAGE_TEXT = "xpath=/html/body/div/h2"

CONTACTS_TABLE = "id=customers"

# Checkbox et logout
REMEMBER_ME = "id=remember"
LOGOUT_LINK = "xpath=/html/body/nav/ul/li/a"
PERSISTED_EMAIL = "id=email-id"  # LOGIN_EMAIL


# Customers Table
CUSTOMERS_TABLE = "id=customers"
TABLE_HEADERS = "xpath=//table[@id='customers']/thead/tr/th"
TABLE_ROWS = "xpath=//table[@id='customers']/tbody/tr"
FIRST_ROW_COLS = "xpath=//table[@id='customers']/tbody/tr[1]/td"
PAGINATION = "xpath=/html/body/div/div/nav/ul"
PAGE_NEXT = "xpath=/html/body/div/div/nav/ul/li[5]/a"

NEW_CUSTOMER_BTN = "id=new-customer"
CANCEL_BTN = "xpath=/html/body/section/div/div/div/div/form/a"
SUBMIT_BTN = "xpath=/html/body/section/div/div/div/div/form/button"

# Formulaire
EMAIL_FIELD = "id=EmailAddress"
FIRST_NAME_FIELD = "id=FirstName"
LAST_NAME_FIELD = "id=LastName"
CITY_FIELD = "id=City"
STATE_DROPDOWN = "id=StateOrRegion"
GENDER_MALE = "xpath=//input[@value='male']"
GENDER_FEMALE = "xpath=//input[@value='female']"
PROMO_CHECKBOX = "name=promos-name"
ADD_CUSTOMER_PAGE_TEXT = "xpath=/html/body/section/div/div/div/div/h2"

ADD_CUSTOMER_SUCCESS_PAGE_TEXT = "id=Success"





