let data;

export default data = [
    {
        "id": 1,
        "desc": "Permet de tester le controller friend",
        "name": "GET /api/comment/test",
        "jsonRet": "{\n" +
            "    \"message\": \"joinCtrl is working !\"\n" +
            "}"
    },
    {
        "id" : 2,
        "desc" : "Permet de récupérer les commentaires d'un event",
        "name" : "GET /api/comment/retrieveComment",
        "jsonEnt" : "{\n" +
            "    \"idEvent\" : \"3\"\n" +
            "}\n" +
            "\n",
        "jsonRet" : "{\n" +
            "    \"Comments\": [\n" +
            "        {\n" +
            "            \"idComm\": 1,\n" +
            "            \"CommentContent\": \"J'adore cet event\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"FirstName\": \"Jason\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 3,
        "desc" : "Permet de poster un commentaire sur un event via l'id de event",
        "jsonEnt" : "{\n" +
            "    \"idEvent\" : \"3\",\n" +
            "    \"comment\" : \"J'adore cet event\"\n" +
            "}\n" +
            "\n",
        "jsonRet" : "{\n" +
            "    \"message\": \"Commentaire posté !\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 4,
        "desc" : "Permet de supprimer un commentaire via son id",
        "name" : "DELETE /api/comment/deleteComment",
        "jsonRet" : "{\n" +
            "    \"idComment\" : 1\n" +
            "}\n" +
            "\n",
        "jsonEnt" : "{\n" +
            "    \"message\": \"Commentaire supprimé\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    }
]