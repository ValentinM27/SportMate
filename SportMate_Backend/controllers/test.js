const connection = require("../database/db");

/**
 * Permet de tester la connexion à l'API
 * @param req
 * @param res
 * @param next
 */
exports.test = (req, res, next) => {
    res.status(200).json({message: "Your API is working well"});
    next();
};

/**
 * Retourne tout les utilisateur de la base de données
 * @param req
 * @param res
 * @param next
 */
exports.testRetrieve = (req,res,next) => {
    const sql = `SELECT idUser, FirstName, LastName, BirthdayDate, Description, Sexe, Email FROM UTILISATEURS`;

    connection.query(sql, function (error, result){
        if(error){
            res.status(500).message({message : "Impossible de récupérer les données"})
        } else {
            res.status(200).json(result);
        }
        next();
    })

};

/**
 * Permet d'update le nom et le prénom d'un utilisateur
 * @param req
 * @param res
 * @param next
 */
exports.testUpdate = (req, res, next) => {
    // Récupération des données
    const id = req.body.idUser;
    const lastname = req.body.LastName;
    const firstname = req.body.FirstName;

    const sql =  `UPDATE UTILISATEURS SET LastName = "${lastname}" , FirstName = "${firstname}" WHERE idUser = "${id}"`;

    connection.query(sql, function (err) {
        if(err){
            res.status(500).json({message : "Erreur base de données"})
        }else {
            res.status(200).json({message : "Utilisateur mis à jour"});
        }
        next();
    })
}

/**
 * Permet de créer un utilisateur
 * @param req
 * @param res
 * @param next
 */
exports.testCreate = (req, res, next) => {
    const firstname = req.body.FirstName;
    const lastname = req.body.LastName;
    const birthday = req.body.BirthdayDate;
    const description = req.body.Description;
    const sexe = req.body.Sexe;
    const mail = req.body.Mail;

    const sql = `INSERT INTO UTILISATEURS (FirstName, LastName, BirthdayDate, Sexe, Description, Email) VALUE
    ("${firstname}","${lastname}","${birthday}","${sexe}","${description}","${mail}")`

    connection.query(sql, (err) => {
        if(err){
            res.status(500).json({message: "Erreur à la création de l'utilisateur"})
        }else{
            res.status(200).json({message : "Utilisateur crée"})
        }
        next();
    })
}

/**
 * Permet de supprimer un utilisateur
 * @param req
 * @param res
 * @param next
 */
exports.testDelete = (req,res,next) => {
    const id = req.body.idUser;
    const sql = `DELETE FROM UTILISATEURS WHERE idUser = "${id}"`;

    connection.query(sql, (err) => {
        if(err){
            res.status(500).json({message : "Erreur Database"});
        }else{
            res.status(200).json({message : "Opération effectuée"});
        }
        next();
    })
}