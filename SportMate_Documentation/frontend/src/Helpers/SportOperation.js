let data;

export default data = [
    {
        "id" : 1,
        "desc" :  "Permet de tester le controller friend",
        "name" : "GET /api/sport/test",
        "jsonRet" : "{\n" +
            "    \"message\": \"sportCtrl is working !\"\n" +
            "}"
    },
    {
        "id" : 2,
        "desc" : "Permet de récupérer l'ID et le label des sports",
        "name" : "GET /api/sport/retrieveSports",
        "jsonRet" : "{\n" +
            "    \"Sports\": [\n" +
            "        {\n" +
            "            \"idSport\": 1,\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"idSport\": 2,\n" +
            "            \"Label\": \"TENNIS\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"idSport\": 3,\n" +
            "            \"Label\": \"CYCLISME\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"idSport\": 4,\n" +
            "            \"Label\": \"FOOTBALL\"\n" +
            "        }, etc ...",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
     }
]