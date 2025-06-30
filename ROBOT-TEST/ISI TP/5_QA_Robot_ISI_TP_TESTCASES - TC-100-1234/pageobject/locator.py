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

CONTACTS_TABLE = "id=customers"

# Checkbox et logout
REMEMBER_ME = "id=remember"
LOGOUT_LINK = "xpath=/html/body/nav/ul/li/a"
PERSISTED_EMAIL = "id=email-id"  # LOGIN_EMAIL

# Home page (anglais)
VALID_MSG_HOME_en = "Customers Are Priority One!"

# Home page (français)
VALID_MSG_HOME_fr = "Les clients sont la priorité numéro un !"

# Login page (anglais)
INVALID_MSG_LOGIN_en = "Login"

# Login page (français)
INVALID_MSG_LOGIN_fr = "Se connecter"

# Post Login Contacts page (anglais)
VALID_MSG_POST_LOGIN_en = "Our Happy Customers"

# Post Login Contacts page (français)
VALID_MSG_POST_LOGIN_fr = "Nos clients satisfaits"

# Post Logout page (anglais)
VALID_MSG_POST_LOGOUT_en = "Signed Out"

# Post Logout page (français)
VALID_MSG_POST_LOGOUT_fr = "Déconnecté"

