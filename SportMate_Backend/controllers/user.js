const connection = require("../database/db");
const bcrypt = require("bcryptjs");
const jwt = require('jsonwebtoken');
const {JWT_SECRET_TOKEN_} = require('../ressources/jwtToken.json');
const transporter = require('../package/mail');

/**
 * Permet de tester le controlleur d'authentification
 * @param req
 * @param res
 */
exports.test = (req, res) => {
    res.status(200).json({message: "authCtrl is working"});
}

/**
 * Permet de créer un compte
 * @param req
 * @param res
 */
exports.register = (req,res) => {
    const {LastName, FirstName, BirthdayDate, Description, Email, Sexe, PASSWORD, validatePASSWORD} = req.body;

    connection.query(`SELECT idUser FROM UTILISATEURS WHERE EMAIL = "${Email}"`, function (err, result){

        if(result.length === 0){
            // Vérification du password avant le hash
            if(PASSWORD === validatePASSWORD){
                //Hash du password via bcrypt, 10 = nombre de fois que le mdp est hashé
                bcrypt.hash(PASSWORD, 10)

                .then( hash => {
                    const sql = (`INSERT INTO UTILISATEURS (FirstName, LastName, BirthdayDate, Sexe, Description, Email, PASSWORD) VALUE
                    ("${FirstName}","${LastName}","${BirthdayDate}","${Sexe}","${Description}","${Email}","${hash}")`);
                    connection.query(sql, function(err){
                        if(err){
                            res.status(500).json({message : "Problème serveur"});
                        } else {
                            res.status(200).json({message : "Utilisateur crée"});
                        }
                    })
                }) .catch(error => res.status(500).json({message : error}))
            } else {
                res.status(403).json({message : "Veuillez saisir deux fois le même mot de passe"});
            }
        } else if (err){
            res.status(500).json({message : "Erreur base de données"});
        } else {
            res.status(403).json({message : "Ce mail est déjà utilisé"});
        }
    });
}

/**
 * Permet un utilisateur de se connecter
 * @param req
 * @param res
 */
exports.login = (req,res) => {
    const {Email, PASSWORD} = req.body;

    connection.query(`SELECT idUser, PASSWORD FROM UTILISATEURS WHERE EMAIL = "${Email}"`, function(err, result){
        if(result.length !== 0){
            bcrypt.compare(PASSWORD, result[0].PASSWORD)
                .then( valid => {
                    if(!valid){
                        res.status(401).json({message : "mot de passe incorrect"});
                    } else {
                        res.status(200).json({
                            message : "Connexion réussie",
                            token : jwt.sign(
                                {userId : result[0].idUser},
                                JWT_SECRET_TOKEN_,
                                { expiresIn: '72h'}
                                )
                        });
                    }
                })
        } else if(err) {
            res.status(500).json({message : "Erreur serveur"})
        }
        else {
            res.status(404).json({message : "L'utilisateur n'existe pas"})
        }
    })
}

/**
 * Retourne les data d'un utilisateur
 * @param req
 * @param res
 */
exports.dataUser = (req,res) => {
    const idUser = res.locals.idUser;

    const sql = (`SELECT LastName, FirstName, Email, Description, Sexe FROM UTILISATEURS WHERE idUser = "${idUser}"`);

    connection.query(sql, function(err, result) {
        if(result !== null){
            res.status(200).json({data : result});
        } else if(err) {
            res.status(500).json({message : "Erreur base de données"})
        } else {
            res.status(404).json({message : "L'utilisateur n'existe pas"})
        }
    })
}

/**
 * Permet de mettre le mot de passe à jour
 * @param req
 * @param res
 */
exports.passwordChange = (req, res) => {
    const idUser = res.locals.idUser;
    const {PASSWORD, validatePASSWORD} = req.body;

    if(PASSWORD === validatePASSWORD) {
        //Hash du password via bcrypt, 10 = nombre de fois que le mdp est hashé
        bcrypt.hash(PASSWORD, 10)
            .then(hash => {
                const sql = `UPDATE UTILISATEURS
                     SET PASSWORD = "${hash}"
                     WHERE idUser = "${idUser}"`;

                connection.query(sql, function (err){
                    if(err) {
                        res.status(500).json({erreur : err});
                    } else {
                        res.status(200).json({message : "Mot de passe mis à jour"});
                    }
                })
            })
            .catch(error => res.status(500).json({message : error}))
    }  else {
        res.status(403).json({message : "Veuillez saisir deux fois le même mot de passe"});
    }
}

/**
 * Permet de supprimer un utlisateur / Pas besoin de vérifier que l'idUser est le bon car
 * passage par le middleware d'authentification avant !
 * @param req
 * @param res
 */
exports.deleleteUser = (req, res) => {
     const idUser = res.locals.idUser;

     const sql = `DELETE FROM UTILISATEURS
        WHERE idUser="${idUser}"`;

     connection.query(sql, function(err){
         if(err){
             res.status(500).json({message : "Erreur serveur", erreur : err});
         } else {
             res.status(200).json({message : "utilisateur supprimé"});
         }
     })
}

/**
 * Permet de modifier les datas d'un utilisateur (Excepté Email et MDP)
 * @param req
 * @param res
 */
exports.modifyUser =(req,res) => {
    const idUser = res.locals.idUser;
    const {Description, LastName, FirstName, Sexe} = req.body;

    if(Description !== undefined || LastName !== undefined || FirstName !== undefined || Sexe !== undefined){

        if(Description !== undefined){
            const sql = `UPDATE UTILISATEURS SET Description = "${Description}" WHERE idUser = "${idUser}"`;

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({erreur : err, message : "Problème update description"});
                }
            })
        }

        if(LastName !== undefined){
            const sql = `UPDATE UTILISATEURS SET LastName = "${LastName}" WHERE idUser = "${idUser}"`;

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({erreur : err, message  : "Problème update LastName"});
                }
            })
        }

        if(FirstName !== undefined){
            const sql = `UPDATE UTILISATEURS SET FirstName= "${FirstName}" WHERE idUser = "${idUser}"`;

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({erreur : err, message  : "Problème update FirstName"});
                }
            })
        }

        if(Sexe !== undefined){
            const sql = `UPDATE UTILISATEURS SET Sexe = "${Sexe}" WHERE idUser = "${idUser}"`;

            connection.query(sql, function(err){
                if(err){
                    res.status(500).json({erreur : err, message  : "Problème update Sexe"});
                }
            })
        }

    }
    else {
        res.status(403).json({message : "Il n'y a rien à modifier"})
    }
    res.status(200).json({Message : "Utilisateur Mise à jour"});
}

/**
 * Permet de mettre à jour l'email de l'utilisateur
 * @param req
 * @param res
 */
exports.emailChange = (req,res) => {
    const idUser = res.locals.idUser;
    const {Email, validateEmail} = req.body;

    connection.query(`SELECT idUser FROM UTILISATEURS WHERE EMAIL = "${Email}"`, function (err, result){
        if(result.length === 0){
            if(Email === validateEmail){
                const sql = `UPDATE UTILISATEURS SET Email = "${Email}" WHERE idUser = "${idUser}"`;

                connection.query(sql, function (err){
                    if(err){
                        res.status(500).json({message : "Erreur base de données"});
                    }else {
                        res.status(200).json({message : "Email mise à jour"});
                    }
                })
            } else {
                    res.status(403).json({message : "Veuillez entrer deux fois le même mail"});
            }
        } else if(err){
            res.status(500).json({message : "Erreur de base de données"});
        } else {
            res.status(403).json({message : "Ce mail est déjà utilisé"});
        }
    })
}

/**
 * Permet de rechercher des utilisateurs
 * @param req
 * @param res
 */
exports.searchUser = (req,res) => {
    const name = req.body.name;

    const _name_Array = name.split(' ');

    const sql = `SELECT LastName, FirstName, Email, Description, Sexe, Description, BirthdayDate 
                FROM UTILISATEURS 
                WHERE LastName = "${_name_Array[0]}" OR FirstName = "${_name_Array[1]}"
                OR LastName = "${_name_Array[1]}" OR FirstName = "${_name_Array[0]}";`

    connection.query(sql, function(err, result){
        if(result === null || result === undefined || result.length === 0){
            res.status(404).json({message : "Aucune personne ne correspond à votre recherche !"});
        } else if(err){
            res.status(500).json({message :"Erreur serveur", Erreur : err});
        } else {
            res.status(200).json({personnes : result});
        }
    })
}

/**
 * Permet d'obtenir les datas d'un user en fonction de son mail
 * @param req
 * @param res
 */
exports.retrieveUserData = (req,res) => {
    let Email = req.body.Email;

    const sql = `SELECT idUser FROM UTILISATEURS WHERE Email = "${Email}"`;

    connection.query(sql, function(err, result){
        if(result === undefined || result === null || result.length === 0){
            res.status(404).json({message : "Email introuvable"});
        } else if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        } else {
            const idUser = result[0].idUser;
            const sql = `SELECT UTILISATEURS.LastName, UTILISATEURS.FirstName, UTILISATEURS.Email, 
                        UTILISATEURS.Description, UTILISATEURS.BirthdayDate, UTILISATEURS.Sexe
                        FROM UTILISATEURS 
                        WHERE UTILISATEURS.idUser = "${idUser}"`;

            connection.query(sql, function (err, result){
                if(result === undefined || result === null || result.length === 0){
                    res.status(404).json({message : "No data found"});
                } else if(err){
                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                } else {
                    res.status(200).json({Data : result});
                }
            })
        }
    })
}

/**
 * Permet d'envoyer un mail de reinitialisation du mot de passe à l'utilisateur
 * @param req
 * @param res
 */
exports.resetPassword = (req, res) => {
    const userEmail = req.body.Email;
    const expirationDate = new Date().toISOString().slice(0, 10);

    let token = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    // Génération du token
    for ( let i = 0; i < 24 ; i++ ) {
        token += characters.charAt(Math.floor(Math.random() * charactersLength));
    }

    const sql = `INSERT INTO RESETPASSWORD (userEmail, resetTOKEN, expirationDate) 
                VALUES ("${userEmail}", "${token}", "${expirationDate}")`;

    connection.query(sql, function(err){
        if(err){
            res.status(500).json({message : "Request failed"});
        } else {

            /**
             * Data de l'email
             * @type {{subject: string, from: string, html: string, to: *, text: string}}
             */
            const mailData = {
                from: 'sportmate.mail@gmail.com',  // sender address
                to: userEmail,   // list of receivers
                subject: 'Changement de mot de passe',
                text: "Changer votre mot de passe Sport'Mate",
                html: `<b>Salut sportif ! </b> 
                    <br>Il semblerait que vous vouliez changer de mot de passe !<br/>
                    <a href=http://support.dialyx.fr/SportMate_support/?token=${token}>Réinitialiser mon mot de passe</a>`
            }

            /**
             * Envoie de l'email
             */
            transporter.sendMail(mailData, function(err){
                if(err){
                    res.status(200).json({message : "Failed to delivered", Erreur : err});
                } else {
                    res.status(200).json({message : "Mail envoyé !"});
                }
            })
        }
    })
}

/**
 * Permet de changer le mot de passe via client web après demande de reset
 * @param req
 * @param res
 */
exports.setNewPassword = (req,res) => {
    const Email = req.body.Email;
    const TOKEN = req.body.token;
    const PASSWORD = req.body.PASSWORD;
    const validatePASSWORD = req.body.validatePASSWORD;

    const currentDate = new Date().toISOString().slice(0, 19).replace('T', ' ');

    const sql = `SELECT userEmail FROM RESETPASSWORD WHERE resetToken = "${TOKEN}" && userEmail = "${Email}"`;

    connection.query(sql, function(err, result){

        if(err){
            res.status(500).json({message : "Erreur serveur", Erreur : err});
        }

        else if (result === undefined || result.length === 0){
            res.status(404).json({message : "Mail non valide ou lien expiré"});
        }

        else if (result[0].userEmail === Email && PASSWORD === validatePASSWORD ){
            bcrypt.hash(PASSWORD, 10)
                .then(hash => {
                    const sql = `UPDATE UTILISATEURS
                     SET PASSWORD = "${hash}"
                     WHERE Email = "${Email}"`;

                    connection.query(sql, function (err){
                        if(err) {
                            res.status(500).json({erreur : err});
                        } else {
                            const sql = `DELETE FROM RESETPASSWORD WHERE userEmail = "${Email}" && resetTOKEN = "${TOKEN}"`;

                            connection.query(sql, function(err){
                                if(err){
                                    res.status(500).json({message : "Erreur serveur", Erreur : err});
                                } else {
                                    res.status(200).json({message : "Mot de passe mis à jour"});
                                }
                            })
                        }
                    })
                })
                .catch(error => res.status(500).json({message : error}))
        } else {
            res.status(403).json({message : "Veuillez saisir deux fois le même mot de passe"});
        }
    })
}

/**
 * Permet d'envoyer un message au client permettant de certifier la validité du JWT
 * @param req
 * @param res
 */
exports.checkToken = (req, res) => {
    res.status(200).json({message : "Token is valid !"});
}










