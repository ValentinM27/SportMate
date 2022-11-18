const connection = require("../database/db");

/**
 * Permet de tester le controller join
 * @param req 
 * @param res 
 */
exports.test = (req,res) => {
    res.status(200).json({message : "joinCtrl is working !"});
}

/**
 * Permet de rejoindre un event
 * @param req
 * @param res
 */
exports.joinEvent = (req,res) => {
    const idUser = res.locals.idUser;
    const idEvent = req.body.idEvent;

    const sql = `SELECT idEvent FROM EVENEMENTS WHERE idEvent = "${idEvent}"`

    connection.query(sql, function(err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "L'event que vous souhaitez rejoindre n'existe pas"});
        } else if(err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const sql = `SELECT * FROM PARTICIPE WHERE idEvent = "${idEvent}" && idUser = "${idUser}"`
            connection.query(sql, function(err, result){
                if(result !== undefined && result.length !== 0){
                    res.status(403).json({message : "Vous avez déjà rejoint cet event"});
                } else if (err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    const sql = `INSERT INTO PARTICIPE (idUser, idEvent) VALUES ("${idUser}","${idEvent}")`

                    connection.query(sql, function (err){
                        if(err){
                            res.status(500).json({message : "Erreur serveur", Erreur : err});
                        } else {
                            res.status(200).json({message : "Vous avez rejoint l'event"});
                        }
                    })
                }
            })
        }
    })
}

/**
 * Permet de quitter un Event
 * @param req
 * @param res
 */
exports.leftEvent = (req,res) => {
    const idUser = res.locals.idUser;
    const idEvent = req.body.idEvent;

    const sql = `SELECT * FROM PARTICIPE WHERE idUser = "${idUser}" AND idEvent = "${idEvent}"`;

    connection.query(sql, function(err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Vous n'avez pas rejoins cet event"});
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const sql = `DELETE FROM PARTICIPE WHERE idUser = "${idUser}" AND idEvent = "${idEvent}"`

            connection.query(sql, function (err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({message : "Vous avez quitté l'event"});
                }
            })
        }
    })
}

/**
 * Retourne la liste des participants d'un event
 * @param req
 * @param res
 */
exports.participateToEvent = (req, res) => {
    const idEvent = req.body.idEvent;

    const sql = `SELECT idEvent FROM EVENEMENTS WHERE idEvent = "${idEvent}"`;

    connection.query(sql, function (err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "idEvent introuvable"});
        } else if (err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const sql = `SELECT UTILISATEURS.Email ,UTILISATEURS.LastName, UTILISATEURS.FirstName
                        FROM PARTICIPE INNER JOIN UTILISATEURS ON PARTICIPE.idUser = UTILISATEURS.idUser
                        WHERE idEvent = "${idEvent}"`;
            connection.query(sql, function (err, result){
                if(result === undefined ||  result === null || result.length === 0 ){
                    res.status(404).json({message : "Il n'y aucun participants pour l'instant"});
                } else if (err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({Participants : result});
                }
            })
        }
    })
}

/**
 * Permet de retourner la liste des events auxquels participe l'utilisateur connecté
 * @param req
 * @param res
 */
exports.retrieveJoinedEvents = (req, res) => {
    const idUser = res.locals.idUser;

    const sql = `SELECT
                 UTILISATEURS.LastName, UTILISATEURS.FirstName, EVENEMENTS.idEvent, EVENEMENTS.idSport,
                    EVENEMENTS.DESCRIPTION_EVENT, EVENEMENTS.TypeEvent, EVENEMENTS.DateEvent, 
                    EVENEMENTS.PersMin, EVENEMENTS.PersMax, EVENEMENTS.DateCreation

                 FROM PARTICIPE
                          INNER JOIN EVENEMENTS ON PARTICIPE.idEvent = EVENEMENTS.idEvent
                          INNER JOIN UTILISATEURS ON EVENEMENTS.idUser = UTILISATEURS.idUser

                 WHERE PARTICIPE.idUser = "${idUser}"`

    connection.query(sql, function(err, result) {
        if(result === undefined || result === null|| result.length === 0) {
            res.status(404).json({message : "Vous n'avez rejoin aucun événements actuellement"});
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            res.status(200).json({Events : result});
        }
    })
}

/**
 * Permet de savoir si un utilisateur participe à un événement
 * @param req
 * @param res
 */
exports.participate = (req,res) => {
    const idUser = res.locals.idUser;
    const idEvent = req.body.idEvent;

    const sql = `SELECT idEvent FROM PARTICIPE WHERE idEvent = "${idEvent}" AND idUser = "${idUser}"`;

    connection.query(sql, function(err, result){
        if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else if (result === null || result.length === 0 || result === undefined){
            res.status(404).json({participe : "FALSE"});
        } else {
            res.status(200).json({participe : "TRUE"});
        }
    })
}
