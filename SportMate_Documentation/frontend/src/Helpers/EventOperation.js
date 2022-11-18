let data;

export default data = [
    {
        "id" : 1,
        "desc" :  "Permet de tester le controller des event",
        "name" : "GET /api/event/test",
        "jsonRet" : "{\n" +
            "    \"message\": \"eventCtrl is working !\"\n" +
            "}"
    },
    {
        "id" : 2,
        "desc" : "Permet de récupérer l'intégralité des events par date de création du plus récent au plus ancien",
        "name" : "/GET /api/event/retrieveEvent",
        "jsonRet" : "{ \"event\" [        " +
            "{\n" +
            "            \"FirstName\": \"Pierre\",\n" +
            "            \"LastName\": \"Jacques\",\n" +
            "            \"idEvent\": \"8\",\n"+
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-11-23T23:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-06T23:00:00.000Z\",\n" +
            "            \"Label\": \"TENNIS\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": \"7\",\n"+
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-10-30T22:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-15T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 3,
        "desc" : "Permet de récupérer les event en fonction du sport via son id, pour récupérer l'id d'un sport voir doc sport",
        "name" : "GET /api/event/retrieveEventBySport",
        "jsonEnt" : "{\n" +
            "    \"idSport\" : \"1\"\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"Event\": [\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": \"3\",\n"+
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-10-30T22:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-15T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Pierre\",\n" +
            "            \"LastName\": \"Jacques\",\n" +
            "            \"idEvent\": \"5\",\n"+
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-11-23T23:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-06T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        }\n" +
            "   ] " +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 4,
        "desc" : "Permet de récupére les event crées par l'utilisateur connecté",
        "name" : "GET /api/user/retrieveEventByCurrentUser",
        "jsonRet" : "{\n" +
            "    \"Evenements\": [\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": \"9\",\n"+
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-10-30T22:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-15T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": \"17\",\n"+
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-10-30T22:00:00.000Z\",\n" +
            "            \"DateCreation\": null,\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 5,
        "desc" : "Permet de créer un event, pour récupérer l'id d'un sport voir doc sport. Attention, le nombre de personne max et min ne doivent pas être entouré de \"\" " +
            "car ce ne sont pas des strings",
        "name" : "POST /api/event/createEvent",
        "jsonEnt" : "{\n" +
            "    \"DESCRIPTION_EVENT\" : \"This is an event\", \n" +
            "    \"TypeEvent\" : \"Cours\", \n" +
            "    \"PersMin\" : 5, \n" +
            "    \"PersMax\" : 10, \n" +
            "    \"DateEvent\" : \"2021-11-14\", \n" +
            "    \"idSport\" : \"1\"\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"message\": \"Event crée !\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 6,
        "desc" : "Permet de supprimer un event en fonction de son id",
        "name" : "DELETE /api/event/deleteEvent",
        "jsonEnt" : "{\n" +
            "    \"idEvent\" : 1\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"message\": \"Event supprimé !\"\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 7,
        "desc" : "Permet de récupérer les event crée par un user grâce à son mail",
        "name" : "GET /api/event/retrieveEventByUser",
        "jsonEnt" : "\n" +
            "{\n" +
            "    \"Email\" : \"jp@gmail.com\"\n" +
            "}",
        "jsonRet" : "{\n" +
            "    \"Events\": [\n" +
            "        {\n" +
            "            \"FirstName\": \"Pierre\",\n" +
            "            \"LastName\": \"Jacques\",\n" +
            "            \"idEvent\": 8,\n" +
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-11-23T23:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-06T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Pierre\",\n" +
            "            \"LastName\": \"Jacques\",\n" +
            "            \"idEvent\": 9,\n" +
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-11-23T23:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-06T23:00:00.000Z\",\n" +
            "            \"Label\": \"TENNIS\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    },
    {
        "id" : 8,
        "desc" : "Permet de récupérer tout les évenements organisé les amis de l'utilisateur connecté",
        "name" : "GET /api/event/retrieveEventByFriendsList",
        "jsonRet" : "{\n" +
            "    \"Events\": [\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": 6,\n" +
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-10-30T22:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-15T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": 12,\n" +
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": 5,\n" +
            "            \"PersMax\": 10,\n" +
            "            \"DateEvent\": \"2021-11-13T23:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-13T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": 11,\n" +
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": 5,\n" +
            "            \"PersMax\": 10,\n" +
            "            \"DateEvent\": \"2021-11-13T23:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-13T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": 10,\n" +
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": 5,\n" +
            "            \"PersMax\": 10,\n" +
            "            \"DateEvent\": \"2021-11-13T23:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-11-11T23:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        },\n" +
            "        {\n" +
            "            \"FirstName\": \"Jason\",\n" +
            "            \"LastName\": \"Hugo\",\n" +
            "            \"idEvent\": 7,\n" +
            "            \"DESCRIPTION_EVENT\": \"This is an event\",\n" +
            "            \"TypeEvent\": \"Cours\",\n" +
            "            \"PersMin\": null,\n" +
            "            \"PersMax\": 8,\n" +
            "            \"DateEvent\": \"2021-10-30T22:00:00.000Z\",\n" +
            "            \"DateCreation\": \"2021-10-30T22:00:00.000Z\",\n" +
            "            \"Label\": \"BASKET\"\n" +
            "        }\n" +
            "    ]\n" +
            "}",
        "isAuth" : "REQUETE AUTHENTIFIÉE, TOKEN DANS LE HEADER DE LA REQUETE REQUIS !"
    }
]