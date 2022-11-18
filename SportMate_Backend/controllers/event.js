const connection = require("../database/db");

/**
 * Permet de tester le controller event
 * @param req
 * @param res
 */
exports.test = (req,res) => {
    res.status(200).json({message : "eventCtrl is working !"});
}

/**
 * Permet de créer un évènement
 * @param res
 * @param req
 */
exports.createEvent = (req,res) => {
    const idUser = res.locals.idUser;

    const{DESCRIPTION_EVENT, TypeEvent, PersMin, PersMax, DateEvent, idSport} = req.body;
    const DateCreation = new Date().toISOString().slice(0, 10);

    if(DateEvent < DateCreation) {
        res.status(406).json({message : "La date ne doit pas être antérieur à la date du jour !"});
    } else {
        if(PersMin !== undefined && PersMax !== undefined){
            if(parseInt(PersMin) < parseInt(PersMax)){
                const sql = `INSERT INTO 
                EVENEMENTS (DESCRIPTION_EVENT,TypeEvent, PersMin, PersMax, DateEvent, DateCreation, idUser,idSport) 
                VALUES ("${DESCRIPTION_EVENT}","${TypeEvent}","${PersMin}","${PersMax}","${DateEvent}","${DateCreation}","${idUser}","${idSport}");`

                connection.query(sql, function(err){
                    if(err){
                        res.status(500).json({message : "Erreur serveur", erreur : err});
                    } else{
                        res.status(200).json({message : "Event crée !"});
                    }
                })
            } else {
                res.status(406).json({message : "Le nombre de personnes minimum doit être inférieur au nombre de personnes max"})
            }
        } else if (PersMin !== undefined && PersMax === undefined){
            const sql = `INSERT INTO 
                EVENEMENTS (DESCRIPTION_EVENT,TypeEvent, PersMin, DateEvent, DateCreation, idUser,idSport) 
                VALUES ("${DESCRIPTION_EVENT}","${TypeEvent}","${PersMin}","${DateEvent}","${DateCreation}","${idUser}","${idSport}");`

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", erreur : err});
                } else{
                    res.status(200).json({message : "Event crée !"});
                }
            })
        } else if(PersMin === undefined && PersMax !== undefined){
            const sql = `INSERT INTO 
                EVENEMENTS (DESCRIPTION_EVENT,TypeEvent, PersMax, DateEvent, DateCreation, idUser,idSport) 
                VALUES ("${DESCRIPTION_EVENT}","${TypeEvent}","${PersMax}","${DateEvent}","${DateCreation}","${idUser}","${idSport}");`

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", erreur : err});
                } else{
                    res.status(200).json({message : "Event crée !"});
                }
            })
        } else {
            const sql = `INSERT INTO 
                EVENEMENTS (DESCRIPTION_EVENT,TypeEvent, DateEvent, DateCreation, idUser,idSport) 
                VALUES ("${DESCRIPTION_EVENT}","${TypeEvent}","${DateEvent}","${DateCreation}","${idUser}","${idSport}");`

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", erreur : err});
                } else{
                    res.status(200).json({message : "Event crée !"});
                }
            })
        }
    }
}

/**
 * Permet de supprimer un évènement
 * @param req
 * @param res
 */
exports.deleteEvent = (req,res) => {
    const idUser = res.locals.idUser;
    const idEvent = req.body.idEvent;

    const sql = `SELECT idEvent, idUser FROM EVENEMENTS WHERE idEvent = ${idEvent}`;
    connection.query(sql , function(err, result) {

        if( result === undefined) {
            console.log(result);
            res.status(200).json({message : "L'event à déjà était supprimé !"});
        }
        else {
            if(result[0].idUser === idUser){
                const sql = `DELETE FROM EVENEMENTS WHERE idEvent = "${idEvent}"`;

                connection.query(sql, function(err){
                    if(err){
                        res.status(500).json({message : "Erreur serveur", Erreur : err});
                    } else{
                        res.status(200).json({message : "Event supprimé !"})
                    }
                })

            }
            else if (err){
                res.status(500).json({message : "Erreur serveur", Erreur : err});
            }
            else {
                res.status(403).json({message : "L'utilisateur n'est pas le créteur de l'event"})
            }
        }
    })
}

/**
 * Permet de récupérer tout évènements
 * @param req
 * @param res
 */
exports.retrieveEvent = (req,res) => {
    const sql = `SELECT UTILISATEURS.FirstName,
                        UTILISATEURS.LastName,
                        UTILISATEURS.Email,
                        EVENEMENTS.idEvent,
                        EVENEMENTS.DESCRIPTION_EVENT,
                        EVENEMENTS.TypeEvent,
                        EVENEMENTS.PersMin,
                        EVENEMENTS.PersMax,
                        EVENEMENTS.DateEvent,
                        EVENEMENTS.DateCreation,
                        SPORT.Label

                 FROM EVENEMENTS
                          INNER JOIN UTILISATEURS ON EVENEMENTS.idUser = UTILISATEURS.idUser
                          INNER JOIN SPORT ON EVENEMENTS.idSport = SPORT.idSport
                 ORDER BY DateCreation DESC`;

    connection.query(sql, function(err, result){
        if(result === undefined || result.length === 0){
            res.status(200).json({message : "il n'existe aucun event"});
        } else if (err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            res.status(200).json({event : result});
        }
    })
}

/**
 * Permet de retourner les event par sport
 * @param req
 * @param res
 */
exports.retrieveEventsBySport = (req,res) => {
    const idSport = req.body.idSport;

    const sql = `SELECT idSport FROM SPORT WHERE idSport = "${idSport}"`;

    connection.query(sql, function(err, result){
        if(result === undefined || result.length === 0){
            res.status(404).json({message : "Le sport demandé n'existe pas !"})
        } else if (err) {
            res.status(500).json({message : "Erreur serveur"});
        } else {
            const sql = `SELECT UTILISATEURS.FirstName, UTILISATEURS.LastName, UTILISATEURS.Email,
                        EVENEMENTS.idEvent, EVENEMENTS.DESCRIPTION_EVENT, EVENEMENTS.TypeEvent, EVENEMENTS.PersMin, EVENEMENTS.PersMax, 			
                        EVENEMENTS.DateEvent, EVENEMENTS.DateCreation, SPORT.Label

                        FROM EVENEMENTS
                            INNER JOIN UTILISATEURS ON EVENEMENTS.idUser = UTILISATEURS.idUser
                            INNER JOIN SPORT ON EVENEMENTS.idSport = SPORT.idSport
                        WHERE EVENEMENTS.idSport = "${idSport}"
                        ORDER BY DateCreation DESC`;

            connection.query(sql, function (err, result){
                if(result === undefined || result.length === 0){
                    res.status(404).json({message : "Aucun event pour ce sport"})
                } else if (err) {
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({Event : result});
                }
            })
        }
    })
}

/**
 * Permet de récupérer les event crées par l'user connecté
 * On ne test pas que l'utilisateur existe car on passe par le middleware d'authentification ce qui
 * certifie que l'utilisateur existe !
 * @param req
 * @param res
 */
exports.retrieveEventsByCurrentUser = (req,res) => {
    const idUser = res.locals.idUser;

    const sql = `SELECT UTILISATEURS.FirstName, UTILISATEURS.LastName, UTILISATEURS.Email,
            EVENEMENTS.idEvent, EVENEMENTS.DESCRIPTION_EVENT, EVENEMENTS.TypeEvent, EVENEMENTS.PersMin, EVENEMENTS.PersMax, EVENEMENTS.DateEvent, EVENEMENTS.DateCreation, SPORT.Label
            
            FROM EVENEMENTS 
            INNER JOIN UTILISATEURS ON EVENEMENTS.idUser = UTILISATEURS.idUser 
            INNER JOIN SPORT ON EVENEMENTS.idSport = SPORT.idSport
            WHERE UTILISATEURS.idUser = "${idUser}"
            ORDER BY DateCreation DESC`;

    connection.query(sql, function(err, result){
        if(result.length === 0 || result === null | result === undefined){
            res.status(404).json({message : "L'utilisateur connecté n'a crée aucun event"});
        } else if (err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            res.status(200).json({Evenements : result});
        }
    })
}

/**
 * Permet de récupérer les events crées par un utilisateur grâce à son Email
 * @param req
 * @param res
 */
exports.retrieveEventByUser = (req, res) => {
    const Email = req.body.Email;

    const sql = `SELECT idUser FROM UTILISATEURS WHERE Email = "${Email}"`;

    connection.query(sql, function(err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Cet utilisateur n'existe pas"});
        } else if (err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const sql = `SELECT UTILISATEURS.FirstName, UTILISATEURS.LastName, UTILISATEURS.Email,
            EVENEMENTS.idEvent, EVENEMENTS.DESCRIPTION_EVENT, EVENEMENTS.TypeEvent, EVENEMENTS.PersMin, EVENEMENTS.PersMax, EVENEMENTS.DateEvent, EVENEMENTS.DateCreation, SPORT.Label
            
            FROM EVENEMENTS 
            INNER JOIN UTILISATEURS ON EVENEMENTS.idUser = UTILISATEURS.idUser 
            INNER JOIN SPORT ON EVENEMENTS.idSport = SPORT.idSport
            WHERE UTILISATEURS.idUser = "${result[0].idUser}"
            ORDER BY DateCreation DESC`

            connection.query(sql, function (err, result){
                if(result === undefined || result === null || result.length === 0){
                    res.status(404).json({message : "Cet utilisateur n'a pas encore crée d'event"});
                } else if (err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({Events : result});
                }
            })
        }
    })
}

exports.retrieveEventByFriendsList = (req, res) => {
    const idUser = res.locals.idUser;

    const sql = `(SELECT UTILISATEURS.FirstName, UTILISATEURS.LastName, UTILISATEURS.Email,
            EVENEMENTS.idEvent, EVENEMENTS.DESCRIPTION_EVENT, EVENEMENTS.TypeEvent, EVENEMENTS.PersMin, EVENEMENTS.PersMax, EVENEMENTS.DateEvent, EVENEMENTS.DateCreation, SPORT.Label 
 
            FROM EVENEMENTS INNER JOIN UTILISATEURS ON EVENEMENTS.idUser = UTILISATEURS.idUser
            INNER JOIN AMIS ON UTILISATEURS.idUser = AMIS.User2 
            INNER JOIN SPORT ON EVENEMENTS.idSport = SPORT.idSport
            WHERE AMIS.InitBy = "${idUser}" AND AMIS.IsValided = TRUE)

            UNION 

            (SELECT UTILISATEURS.FirstName, UTILISATEURS.LastName, UTILISATEURS.Email,
                        EVENEMENTS.idEvent, EVENEMENTS.DESCRIPTION_EVENT, EVENEMENTS.TypeEvent, EVENEMENTS.PersMin, EVENEMENTS.PersMax, EVENEMENTS.DateEvent, EVENEMENTS.DateCreation, SPORT.Label 
            FROM EVENEMENTS INNER JOIN UTILISATEURS ON EVENEMENTS.idUser = UTILISATEURS.idUser
            INNER JOIN AMIS ON UTILISATEURS.idUser = AMIS.InitBy 
            INNER JOIN SPORT ON EVENEMENTS.idSport = SPORT.idSport
            WHERE AMIS.User2 = "${idUser}" AND AMIS.IsValided = TRUE)  
    
            ORDER BY \`DateCreation\` DESC;`;

    connection.query(sql, function (err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Vos amis n'ont pas encore crée d'event"});
        } else if (err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
             res.status(200).json({Events : result});
        }
    })
}

