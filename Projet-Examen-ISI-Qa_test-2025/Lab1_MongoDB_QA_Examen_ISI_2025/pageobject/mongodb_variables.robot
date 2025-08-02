### pageobject/mongodb_variables.robot

*** Settings ***
Library    RobotMongoDBLibrary.Find
Library    RobotMongoDBLibrary.Insert
Library    RobotMongoDBLibrary.Update
Library    RobotMongoDBLibrary.Delete
Library    Collections

*** Variables ***
# Configuration MongoDB Atlas
&{MONGODB_CONFIG}=    connection=mongodb+srv://diallolatoile:5cAvoTe0UbgrZGvc@cluster0.ztajrf2.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
...                   database=fakestore_db
...                   collection=fakestore_db

# Produit valide
&{VALID_PRODUCT}=    title=Samsung Galaxy S21
...                  price=${799.99}
...                  description=Latest Samsung phone
...                  category=smartphones
...                  image=https://fakestoreapi.com/img/samsung.jpg

# Cas invalides (scénarios non passants)
&{MISSING_TITLE}=    price=${799.99}
...                  description=No title product
...                  category=smartphones

&{INVALID_PRICE}=    title=Invalid Price Product
...                  price=abc
...                  description=Bad price format

&{UNKNOWN_ID}=       _id=000000000000000000000000
