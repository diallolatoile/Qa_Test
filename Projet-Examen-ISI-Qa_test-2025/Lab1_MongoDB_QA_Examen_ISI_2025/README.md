# QA - Tests MongoDB avec Robot Framework

Projet d'automatisation de tests sur la base MongoDB Atlas `fakeStoreDB`.

## Structure

- `testcases/` : cas de test par collection
- `resources/` : mots-clés personnalisés réutilisables
- `pageobject/` : variables globales (URI, DB, collection)

## Lancer les tests

```bash
robot -d results testcases/products_tests.robot
