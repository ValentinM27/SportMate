const connection = require('../database/db');

/**
 * Permet de tester le controller des pratiques sportives
 * @param req
 * @param res
 */
exports.test = (req, res) => {
    res.status(200).json({message : "practicesCtrl is working !"});
}

/**
 * Permet d'ajouter un sport pratiqué par l'utilisateur connecté
 * @param req
 * @param res
 */
exports.setPractices = (req, res) => {
    const idUser = res.locals.idUser;
    const idSport = req.body.idSport;

    const sql = `SELECT COUNT(idUser) AS nbSports FROM PRATIQUE WHERE idUser = "${idUser}"`;

    connection.query(sql, function (err, result){
        if(result !== undefined && result[0].nbSports < 5){
            const sql = `SELECT idSport FROM SPORT WHERE idSport = "${idSport}"`;

            connection.query(sql,function (err, result){
                if(result !== undefined && result.length !== 0){
                    const sql = `SELECT * FROM PRATIQUE WHERE idSport = "${idSport}" AND idUser = "${idUser}"`;

                    connection.query(sql, function (err, result){
                        if(result !== undefined && result.length !== 0){
                            res.status(403).json({message : "Vous pratiquez déjà ce sport !"});
                        } else if(err){
                            res.status(500).json({message : "Erreur serveur", Erreur : err});
                        } else {
                            const sql = `INSERT INTO PRATIQUE (idUser, idSport) VALUES ("${idUser}", "${idSport}")`;

                            connection.query(sql, function (err){
                                if(err){
                                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                                } else {
                                    res.status(200).json({message : "Vous pratiquez à présent ce sport"});
                                }
                            })
                        }
                    })
                } else if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(404).json({message : "idSport éronné"});
                }
            })
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            res.status(403).json({message : "Vous ne pouvez pas pratiquer plus de 5 sports !"});
        }
    })
}

/**
 * Permet de récupérer la liste des sports pratiqué par l'utilisateur connecté
 * @param req
 * @param res
 */
exports.retrievePractices = (req, res) => {
    const idUser = res.locals.idUser;

    const sql = `SELECT SPORT.idSport, SPORT.Label 
                FROM PRATIQUE 
                INNER JOIN SPORT ON PRATIQUE.idSport = SPORT.idSport
                WHERE PRATIQUE.idUser = "${idUser}"`;

    connection.query(sql, function (err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(403).json({message : "Vous ne pratiquez aucuns sport pour l'instant"});
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            res.status(200).json({Pratiques : result});
        }
    })
}

/**
 * Permet de supprimer un sport pratiqué par l'utilisateur connecté
 * @param req
 * @param res
 */
exports.deletePractices = (req, res) => {
    const idUser = res.locals.idUser;
    const idSport = req.body.idSport;

    const sql = `SELECT * FROM PRATIQUE WHERE idUser = "${idUser}" AND idSport = "${idSport}"`;

    connection.query(sql, function(err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Vous ne pratiquez pas ce sport !"});
        } else if(err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const sql = `DELETE FROM PRATIQUE WHERE idUser = "${idUser}" AND idSport = "${idSport}"`;

            connection.query(sql, function (err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({message : "Vous ne pratiquez plus ce sport !"});
                }
            })
        }
    })
}

/**
 * Permet de charger les sports pratiqués por un utilisateur grâce à son mail
 * @param req
 * @param res
 */
exports.retrievePracticesUser = (req,res) => {
    const Email = req.body.Email;

    const sql = `SELECT idUser FROM UTILISATEURS WHERE Email = "${Email}"`;

    connection.query(sql, function (err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Email introuvable"});
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const idUser = result[0].idUser;

            const sql = `SELECT SPORT.idSport, SPORT.Label 
                FROM PRATIQUE 
                INNER JOIN SPORT ON PRATIQUE.idSport = SPORT.idSport
                WHERE PRATIQUE.idUser = "${idUser}"`;

            connection.query(sql, function (err, result){
                if(result === undefined || result === null || result.length === 0){
                    res.status(404).json({message : "L'utilisateur ne pratique aucun sport"});
                } else if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({Practices : result});
                }
            })
        }
    })
}