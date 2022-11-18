// Librairies
const connection = require("../database/db");
const cron = require('node-cron');

/**
 * Permet de supprimer les demande de réinitialisation de mots de passe expirée
 */
cron.schedule('* * * * *', function() {
    connection.query(`DELETE FROM RESETPASSWORD WHERE expirationDate < CAST(NOW() AS DATE)`, function(err){
        if(err){
            console.log(err);
        }
        console.log("Job done");
    })
});
