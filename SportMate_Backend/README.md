# SportMate_Backend
Répertoire correspondant à l'API de l'application Sport'Mate
# Les technos 
Node.JS avec Express.JS | Docker
# Container
Pour serveur avec volume et base de données sans volume
# Base de données 
MySQL => Script à éxécuter en se connectant à la base de données du docker
# Structure de l'API 
* server.js : Fichier permettant de lancer l'API, permet de paramétrer le port d'écoute. Transfert les data à App.js
* App.js : Redirige les requêtes vers la bonne route (et contrôles le CORS grâce au header)
* Fichiers :
  * Routes : Contient les routes en fonctions des type de requête => Procéde aux appels des fonctions via les controlleurs (ou Middlewares)
  * Controllers : Contient les différentes fonctions de l'API
# Documentation de l'API
https://valentinm27.github.io/SportMate_Documentation/#/
