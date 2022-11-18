let data;

export default data = [
    {
        "id" : 1,
        "desc" :  "Permet de tester le controller friend",
        "name" : "GET /api/join/test",
        "jsonRet" : "{\n" +
            "    \"message\": \"joinCtrl is working !\"\n" +
            "}"
    },
    {
        "id" : 2,
        "desc" : "Permet de récupérer les participants d'un Event",
        "name" : "GET /api/join/retrieveParticipant",
        "jsonEnt" : "\n" +
            "{\n" +
            "    \"idEvent\" : 10\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"Participants\": [\n" +
            "        {\n" +
            "            \"Email\": \"jp@gmail.com\",\n" +
            "            \"LastName\": \"Jacques\",\n" +
            "            \"FirstName\": \"Pierre\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 3,
        "desc" : "Permet de rejoindre un evet grâce à son id",
        "name" : "POST /api/join/joinEvent",
        "jsonEnt" : "\n" +
            "{\n" +
            "    \"idEvent\" : 11\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"message\": \"Vous avez rejoint l'event\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 4,
        "desc" : "Permet de quitter un Event grâce à l'id de l'event",
        "name" : "DELETE /api/join/leftEvent",
        "jsonEnt" : "\n" +
            "{\n" +
            "    \"idEvent\" : 11\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"message\": \"Vous avez quitté l'event\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    }
]