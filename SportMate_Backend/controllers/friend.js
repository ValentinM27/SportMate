const connection = require("../database/db");

/**
 * Permet de tester le controlleur friend
 * @param req
 * @param res
 */
exports.test = (req,res) => {
    res.status(200).json({message : "friendCtlr is working !"});
}

/**
 * Permet de créer une amitié entre la personne connectée et une autre utilisateur
 * @param req
 * @param res
 */
exports.createFriendship = (req, res) => {
    const idUser = res.locals.idUser;
    const friendEmail = req.body.friendEmail;

    const sql = `SELECT idUser FROM UTILISATEURS WHERE Email = "${friendEmail}"`;

    connection.query(sql, function(err, result){
        if(result === null || result === undefined || result.length ===0){
             res.status(404).json({message : "L'utilisateur à ajouter n'existe pas !"});
        } else if (idUser === result[0].idUser) {
            res.status(303).json({message : "Vous ne pouvez pas vous ajouter en ami !"});
        } else if(err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const _User2 = result[0].idUser;
            const sql = `SELECT idFriendShip, isValided FROM AMIS 
                                WHERE (InitBy = "${idUser}" AND User2 = "${result[0].idUser}")
                                OR (InitBy = "${result[0].idUser}" AND User2 = "${idUser}")`

            connection.query(sql, function(err, result){
                if(result === undefined || result.length === 0 || result === null){
                    const sql = `INSERT INTO AMIS (initBy, User2, IsValided) VALUES ("${idUser}", "${_User2}",FALSE)`;

                    connection.query(sql, function(err){
                        if(err){
                            res.status(500).json({message : " Erreur serveur !", Erreur : err});
                        } else {
                            res.status(200).json({message : "Demande d'ami envoyée"});
                        }
                    })
                } else if (err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else if (parseInt(result[0].isValided) === 1) {
                    res.status(403).json({message : "Vous êtes déjà ami !"});
                } else {
                    res.status(403).json({message : "Vous avez déjà envoyé une demande à cet utilisateur"})
                }
            })
        }
    })
}

/**
 * Retourne les demande d'amis de l'utilisateur connecté
 * @param req
 * @param res
 */
exports.retrieveFriendRequest = (req,res) => {
    const idUser = res.locals.idUser;

    const sql = `SELECT idFriendship, LastName, FirstName, IsValided, Email FROM AMIS 
                INNER JOIN UTILISATEURS ON UTILISATEURS.idUser = AMIS.InitBy
                WHERE User2 = "${idUser}" AND IsValided = FALSE`;

    connection.query(sql, function(err, result){
        if(result === null || result === undefined || result.length === 0){
            res.status(404).json({message : "Aucunes demandes d'amis trouvées"});
        } else if (err) {
            res.status(500).json({message: "Erreur serveur", Erreur: err});
        } else {
            res.status(200).json({demandes : result});
        }
    })
}

/**
 * Permet de valider une demande d'ami
 * @param req
 * @param res
 */
exports.validateFriendship = (req,res) => {
    const idUser = res.locals.idUser;

    const idFriendship = req.body.idFriendship;

    if(idFriendship === undefined || idFriendship === null || idFriendship.length === 0){
        res.status(403).json({message : "Veuillez renseigner un idFriendShip, reference doc"});
    } else {
        const sql = `SELECT InitBy, User2 FROM AMIS WHERE idFriendship = "${idFriendship}"`;

        connection.query(sql, function(err, result){
            if(result[0].InitBy === idUser){
                res.status(303).json({message : "L'utilisateur a initié la demande, il ne peut pas la valider"});
            } else if (err) {
                res.status(500).json({message : "Erreur serveur", Erreur : err});
            } else if (result[0].User2 === idUser) {
                const sql = `UPDATE AMIS SET IsValided = TRUE WHERE idFriendship = "${idFriendship}"`;

                connection.query(sql, function(err){
                    if(err){
                        res.status(500).json({message : "Erreur serveur", Erreur : err});
                    } else {
                        res.status(200).json({message : " Vous êtes maintenant ami !"});
                    }
                })
            } else {
                res.status(500).json({message : "Erreurs"});
            }
        })
    }
}

/**
 * Retourne la liste des amis de l'utilisateur
 * @param req
 * @param res
 */
exports.retrieveFriend = (req,res) => {
    const idUser = res.locals.idUser;

    const sql = `(SELECT idFriendship, LastName, FirstName, IsValided, Email FROM AMIS 
     INNER JOIN UTILISATEURS ON UTILISATEURS.idUser = AMIS.User2
     WHERE InitBy = "${idUser}" AND IsValided = TRUE)
    UNION 
     (SELECT idFriendship, LastName, FirstName, IsValided, Email FROM AMIS 
      INNER JOIN UTILISATEURS ON UTILISATEURS.idUser = AMIS.InitBy
      WHERE User2 = "${idUser}" AND IsValided = TRUE)`;

    connection.query(sql, function(err, result){
        if(result === null || result === undefined || result.length === 0){
            res.status(404).json({message : "Vous n'avez pas encore d'amis"});
        } else if (err){
            res.status(500).json({message : "Erreur Serveur", Erreur : err});
        } else {
            res.status(200).json({amis : result});
        }
    })
}

/**
 * Permet de supprimer une amitié
 * @param req
 * @param res
 */
exports.deleteFriendship = (req,res) => {
    const idUser = res.locals.idUser;
    const idFriendship = req.body.idFriendship;

    const sql = `SELECT InitBy, User2 FROM AMIS WHERE idFriendship ="${idFriendship}"`;

    connection.query(sql, function (err, result){
        if(result[0].InitBy === idUser || result[0].User2 === idUser){
            const sql = `DELETE FROM AMIS WHERE idFriendship = "${idFriendship}"`;

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({message : "Amitié supprimée"});
                }
            })
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            res.status(403).json({message : "Vous ne faite pas parti de cette amitié"});
        }
    })
}