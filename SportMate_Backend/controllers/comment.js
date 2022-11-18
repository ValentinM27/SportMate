const connection = require('../database/db');

/**
 * Permet de tester le controller de commentaires
 * @param req
 * @param res
 */
exports.test = (req, res) => {
    res.status(200).json({message : "commentCtrl is working !"});
}

exports.createComment = (req, res) => {
    const idUser = res.locals.idUser;
    const idEvent = req.body.idEvent;
    const comment = req.body.comment;

    const sql = `SELECT idEvent FROM EVENEMENTS WHERE idEvent = "${idEvent}"`;

    connection.query(sql, function(err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Vous ne pouvez pas commenter un event qui n'existe pas !"});
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const sql = `INSERT INTO COMMENT (idCreatorCom, idEvent, CommentContent) VALUES ("${idUser}", "${idEvent}", "${comment}")`;

            connection.query(sql, function (err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({message : "Commentaire posté !"});
                }
            })
        }
    })
}

/**
 * Permet de supprimer un commentaire
 * @param req
 * @param res
 */
exports.deleteComment = (req, res) => {
    const idUser = res.locals.idUser;
    const idComment = req.body.idComment;

    const sql = `SELECT idCreatorCom FROM COMMENT WHERE idComm = "${idComment}"`;

    connection.query(sql, function(err, result){
        if(result !== undefined && result.length !== 0 && result[0].idCreatorCom === idUser){
            const sql = `DELETE FROM COMMENT WHERE idComm = "${idComment}"`;

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({message : "Commentaire supprimé"});
                }
            })
        } else if (err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else if (result === undefined || result.length === 0){
            res.status(404).json({message : "Ce commentaire n'existe pas"});
        }
        else {
            res.status(403).json({message : "Vous n'êtes pas l'auteur de ce commentaire, vous ne pouvez donc pas le supprimer"});
        }
    })
}

/**
 * Permet de lister tout les commentaires d'un event
 * @param req
 * @param res
 */
exports.listComment = (req, res) => {
    const idEvent = req.body.idEvent;

    const sql = `SELECT idEvent FROM EVENEMENTS WHERE idEvent = "${idEvent}"`;
    connection.query(sql, function(err, result){
        if(result === undefined || result === null || result.length === 0) {
            res.status(404).json({message : "idEvent introuvable"});
        } else if (err) {
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const sql = `SELECT COMMENT.idComm, COMMENT.CommentContent, COMMENT.idEvent, UTILISATEURS.LastName, UTILISATEURS.FirstName, UTILISATEURS.Email
                        FROM COMMENT INNER JOIN UTILISATEURS ON COMMENT.idCreatorCom = UTILISATEURS.idUser
                        WHERE idEvent = "${idEvent}"`;

            connection.query(sql, function (err, result){
                if(result === undefined || result === null || result.length === 0){
                    res.status(404).json({message : "Il n'y a pas de commentaire sur cet event"});
                } else if (err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({Comments : result});
                }
            })
        }
    })
}