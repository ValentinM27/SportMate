let data;

export default data = [
    {
        "id" : 1,
        "desc" :  "Permet de tester le controller friend",
        "name" : "GET /api/friend/test",
        "jsonRet" : "{\n" +
            "    \"message\": \"friendCtrl is working !\"\n" +
            "}"
    },
    {
        "id" : 2,
        "desc" : "Permet de récupérer toutes les demandes d'amis de l'utilisateur",
        "name" : "GET /api/friend/friendRequest",
        "jsonRet" : "{\n" +
            "    \"idFriendship\": 1, \n" +
            "    \"LastName\": \"Jason\", \n" +
            "    \"FirstName\": \"Hugo\", \n" +
            "    \"IsValided\" : 0, \n" +
            "    \"Email\": \"jason@gmail.com\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 3,
        "desc" : "Permet de récupérer la liste des amis de l'utilisateur connecté",
        "name" : "GET /api/friend/retrieveFriend",
        "jsonRet" : "{\n" +
            "    \"amis\": [\n" +
            "        {\n" +
            "            \"idFriendship\": 2,\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"IsValided\": 1,\n" +
            "            \"Email\": \"jason@gmail.com\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 4,
        "desc" : "Permet d'envoyer une demande d'amis",
        "name" : "POST /api/friend/createFriendship",
        "jsonEnt" : "{\"friendEmail\" : \"jp@gmail.com\"}",
        "jsonRet" : "{\n" +
            "    \"message\": \"Demande d'ami envoyée\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 5,
        "desc" : "Permet de valider une amitié grâce à son ID, pour récupérer l'id d'une amité proçédez à un " +
            "appel de /friendRequest",
        "name" : "POST /api/friend/validateRequest",
        "jsonEnt" : "{\"idFriendship\" : \"1\"}",
        "jsonRet" : "{\"message\" : \" Vous êtes maintenant ami !\"}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 6,
        "desc" : "Permet de supprimer une amitié grâce à son id, pour récupérer l'id de l'amitié, procédez à un appel de" +
            "/retrieveFriend",
        "name" : "DELETE /api/friend/deleteFriend",
        "jsonEnt" : "{\"idFriendship\" : \"1\"}",
        "jsonRet" : "{message : \"Amitié supprimée\"}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    }
]