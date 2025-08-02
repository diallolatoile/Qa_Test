*** Variables ***
&{VALID_PRODUCT}                       _id=P1001    title=Produit Test    price=29.99    description=Produit de test    category=electronique
&{INVALID_PRODUCT_NO_TITLE}           _id=P1002    price=15.99    description=Sans titre
&{INVALID_PRODUCT_NEGATIVE_PRICE}    _id=P1003    title=Produit Invalide    price=-10    description=Prix négatif

${INVALID_ID}          BADID123
${NON_EXISTENT_ID}     507f191e810c19729de860ea1234
