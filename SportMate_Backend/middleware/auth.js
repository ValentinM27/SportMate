const jwt = require("jsonwebtoken");
const {JWT_SECRET_TOKEN_}= require("../ressources/jwtToken.json");
const connection = require("../database/db");

/**
 * Permet de tester le token de l'utilisateur
 * @param req
 * @param res
 * @param next
 */
module.exports = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[0];
        const decodedToken = jwt.verify(token, JWT_SECRET_TOKEN_);
        const userId = decodedToken.userId;

        const sql = `SELECT idUser FROM UTILISATEURS WHERE idUser = ${userId}`;

        connection.query(sql, function(err, result){
            if(result === undefined || result === null || result.length === 0){
                res.status(403).json({message : "Ce token est invalide"});
            } else if (err){
                res.status(500).json({erreur : err});
            } else {
                res.locals.idUser = result[0].idUser;
                next();
            }
        })

    } catch (error){
        res.status(401).json({
            error: error
        });
    }
};