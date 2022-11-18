let data;

export default data = [
    {
        "id" : 1,
        "desc" :  "Permet de tester le controller d'authentification",
        "name" : "GET /api/user/test",
        "jsonRet" : "{\n" +
            "    \"message\": \"authCtrl is working\"\n" +
            "}"
    },
    {
        "id" : 2,
        "desc" : "Permet de créer un utilisateur, le mot de passe doit être validé et doit réspecter les contraintes suivantes : 1 chiffre, une maj et 8 chararctères. " +
            "Attention, après création du compte, l'utilisateur doit se connecter pour obtenir son token",
        "name" : "POST /api/user/register",
        "jsonEnt" : "{ \"LastName\" : \"Hugo\", \"FirstName\" : \"Jason\", \"BirthdayDate\" : \"2001-10-05\", \"Description\" : \"Lorem Ipsum\", \"Email\" : \"jason2@gmail.com\", \"Sexe\" : \"H\", \"PASSWORD\" : \"TheSuperToto21\", \"validatePASSWORD\" : \"TheSuperToto21\"}\n" +
            "\n"
    },
    {
        "id" : 3,
        "desc" :  "Permet à l'utilisateur de se connecter",
        "name" : "POST /api/user/login",
        "jsonEnt" : "{ \"Email\" : \"jason@gmail.com\", \"PASSWORD\" : \"TheSuperToto21\" }",
        "jsonRet" : "{\n" +
            "    \"message\": \"Connexion réussie\",\n" +
            "    \"token\": \"token\"\n" +
            "}",
        "isAuth" : "ATTENTION, IL FAUT STOCKER LE TOKEN POUR LES REQUETES AUTHENTIFIÉES"
    },
    {
        "id" : 4,
        "desc" :  "Permet de récupérer les données de l'utilisateur",
        "name" : "GET /api/user/dataUser",
        "jsonRet" : "[\n" +
            "    {\n" +
            "        \"LastName\": \"Hugo\",\n" +
            "        \"FirstName\": \"Jason\",\n" +
            "        \"Email\": \"jason@gmail.com\",\n" +
            "        \"Description\": \"Lorem Ipsum\"\n" +
            "    }\n" +
            "]",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 5,
        "desc" : "Permet de mettre à jour le mot de passe de l'utilisateur, validatePASSWORD correspond au champs de validation" +
            "du mot du passe dans le formulaire, un mot de passe doit faire 8 caractères au moin avec une maj et un chiffre",
        "name" : "POST /api/user/passwordChange",
        "jsonEnt" : "{\"PASSWORD\" : \"TheSuperToto21\", \"validatePASSWORD\" : \"TheSuperToto21\"}",
        "jsonRet" : "{\n" +
            "    \"message\": \"Mot de passe mis à jour\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 6,
        "desc" : "Permet de supprimer un utilisateur",
        "name" : "DELETE /api/user/deleteUser",
        "jsonRet" : "{\"message\" : \"utilisateur supprimé\"}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 7,
        "desc" : "Permet de mettre à jour les données de l'utilisateur",
        "name" : "POST /api/user/updateUser",
        "jsonEnt" : "{\"Description\" : \"Lorem Ipsum\", \"LastName\" : \"Jason\", " +
            "\"FirstName\" : \"Bob\", \"BirthdayDate\" : \"2001-10-04\"}",
        "jsonRet" : "{\"Message\" : \"Utilisateur Mise à jour\"}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 8,
        "desc" : "Permet de mettre à jour le mail de l'utilisateur, validateEmail correspond au champs de validation " +
            "de l'email dans le formulaire",
        "name" : "POST /api/user/emailChange",
        "jsonEnt" : "{\"Email\" : \"this@toto.fr\", \"validateEmail\" : \"this@toto.fr\"}",
        "jsonRet" : "{\n" +
            "    \"message\": \"Email mise à jour\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 9,
        "desc" : "Permet de rechercher un utilisateur grâce à son nom ou son prénom",
        "name" : "GET /api/user/search",
        "jsonEnt" : "{\n" +
            "    \"name\" : \"Jason\"\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"personnes\": [\n" +
            "        {\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"Email\": \"jason@gmail.com\",\n" +
            "            \"Description\": \"Lorem Ipsum\",\n" +
            "            \"Sexe\": \"H\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"Email\": \"jason2@gmail.com\",\n" +
            "            \"Description\": \"Lorem Ipsum\",\n" +
            "            \"Sexe\": \"H\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    }
]