const mysql = require("mysql");
const configDB = require("./configDB");

// Création de la connexion à la base de données
const connection = mysql.createConnection({
    host: configDB.host,
    user: configDB.user,
    password: configDB.password,
    database: configDB.db
})

//Ouverture de la connexion
connection.connect( error => {
    if (error) throw error;
    console.log("Connexion ouverte");
});

module.exports = connection;