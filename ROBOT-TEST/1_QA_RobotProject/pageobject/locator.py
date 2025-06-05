USERNAME_FIELD = "id=j_username"
PASSWORD_FIELD = "id=j_password"
LOGIN_BUTTON = "xpath=//button[@class='jenkins-button jenkins-button--primary' and @name='Submit']"

# Messages d'erreur (anglais)
INVALID_CREDENTIALS_MSG_en = "xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), 'Invalid username or password')]"
EMPTY_FIELD_MSG_en = "xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), 'Invalid username or password')]"
BLOCKED_ACCOUNT_MSG_en = "xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), 'Invalid username or password')]"

# Messages d'erreur (français)
INVALID_CREDENTIALS_MSG_fr = "xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), \"Nom d'utilisateur ou mot de passe incorrect\")]"
EMPTY_FIELD_MSG_fr = "xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), \"Nom d'utilisateur ou mot de passe incorrect\")]"
BLOCKED_ACCOUNT_MSG_fr = "xpath=//div[contains(@class,'app-sign-in-register__error') and contains(text(), \"Nom d'utilisateur ou mot de passe incorrect\")]"


# Après Connexion (anglais)
VALID_CREDENTIALS_MSG_en = "Welcome to Jenkins!"

# Après Connexion (français)
VALID_CREDENTIALS_MSG_fr = "Bienvenue sur Jenkins !"
