# Captain Challenge

## Setup

You must launch migration and seeds with:

`bundle exec rake db:migrate db:seed`

You can launch rails server with:

`bundle exec rails s`

## Test

To launch tests (Minitest) you can use this command:

`bundle exec rails test`

## Heroku

You can view a live version of the project [here](https://captain-challenge-test.herokuapp.com)

## Subject

Bienvenue jeune moussaillon !

Pour intégrer le navire Captain Contrat, tu dois créer une arène où deux héros pourront s'affronter !

### Résultat attendu

Le but de ce challenge est de tester ta capacité à monter une petite application [dans le respect des bonnes pratiques](https://medium.com/captain-contrat-tech).
On te propose plusieurs étapes, avec des bonus facultatifs. Tu peux t'arrêter quand tu veux.
Tiens-nous régulièrement informés de ta progression.

Nous nous intéresserons tout particulièrement aux choix de conception que tu feras, comment tu abordes les fonctionnalités à développer et ta connaissance des outils que tu utilises.

### Tes armes

- Ruby
- Rails
- git

### Étapes

#### 1. Page d'accueil statique

C'est l'accueil de l'arène, d'où nous pourrons lancer les combats.
Le but est donc de créer l'application et d'afficher une page dans un navigateur.

Bonus :

OK - Un petit texte d'introduction de ton cru. C'est plus fun.

OK - Joli design (mais n'y perd pas trop de temps non plus)

#### 2. Pouvoir créer un personnage

Données requises :

OK - Nom

OK - Points de vie

OK - Points d'attaque

Assure-toi qu'il n'y ait pas de grand déséquilibre entre combattants.

Bonus :

OK - L'arène n'est pas vide au premier démarrage de l'appli.

OK - Les persos ont une photo de profil (ou de face)

OK - Crud complet des personnages

OK - Ajouter d'autres caractéristiques aux personnages

#### 3. READY? FIGHT!

OK Pouvoir choisir deux personnages et les faire combattre, puis afficher le gagnant avec un récapitulatif du combat.

Bonus :

OK - Historique des combats qui ont eu lieu

OK - Ajout de points d'expérience (mais pourquoi faire ?)

OK - Statistiques des combats : taux de victoire par perso et tout ça

#### 4. Des armes

OK Pouvoir assigner une arme aux personnages avant le combat.

Bonus :

OK - Il n'y a pas que les armes dans la vie, il y a des boucliers aussi

OK - Pouvoir utiliser plusieurs équipements
