const connection = require('../database/db');

/**
 * Permet de tester le controller des sports
 * @param req
 * @param res
 */
exports.test = (req, res) => {
    res.status(200).json({message : "sportCtrl is working !"});
}

/**
 * Permet de retourner la liste de tout les sports présent dans la base de données
 * @param req
 * @param res
 */
exports.retrieveSport = (req, res) => {
    const sql = `SELECT idSport, Label FROM SPORT`;

    connection.query(sql, function (err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Il n'existe aucun sport en base de données"});
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            res.status(200).json({Sports : result});
        }
    })
}

