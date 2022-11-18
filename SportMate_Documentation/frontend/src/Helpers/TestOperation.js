let data;

export default data = [
    {
        id : "1",
        name : "GET /api/test",
        desc : "Permet de tester la connexion à l'API via un GET sur /api/test",
        jsonRet: "{\n" +
            "    \"message\": \"Your API is working well\"\n" +
            "}"
    },
    {
        id: "2",
        name : "GET /api/test/retrieve",
        desc: "Retourne toutes les données de chaque utilisateur",
        jsonRet : "[\n" +
            "    {\n" +
            "        \"idUser\": 1,\n" +
            "        \"FirstName\": \"Jason\",\n" +
            "        \"LastName\": \"Jasonnette\",\n" +
            "        \"BirthdayDate\": null,\n" +
            "        \"Description\": null,\n" +
            "        \"Sexe\": \"H\",\n" +
            "        \"Email\": \"jasonnette@js.fr\"\n" +
            "    },\n" +
            "    {\n" +
            "        \"idUser\": 3,\n" +
            "        \"FirstName\": \"Jason\",\n" +
            "        \"LastName\": \"Jasonnette\",\n" +
            "        \"BirthdayDate\": \"2001-10-03T22:00:00.000Z\",\n" +
            "        \"Description\": \"Je suis une Description\",\n" +
            "        \"Sexe\": \"H\",\n" +
            "        \"Email\": \"jasonnette@js.fr\"\n" +
            "    },\n" +
            "    {\n" +
            "        \"idUser\": 4,\n" +
            "        \"FirstName\": \"Jason\",\n" +
            "        \"LastName\": \"Jasonnette\",\n" +
            "        \"BirthdayDate\": \"2001-10-03T22:00:00.000Z\",\n" +
            "        \"Description\": \"Je suis une Description\",\n" +
            "        \"Sexe\": \"H\",\n" +
            "        \"Email\": \"jasonnette@js.fr\"\n" +
            "    }\n" +
            "]"
    },
    {
        id : "3",
        name : "POST /api/test/update",
        desc : "Permet de mettre à jour le nom et le prénom d'un utilisateur",
        jsonEnt : "{\n" +
            "    \"idUser\" : 8,\n" +
            "    \"LastName\" : \"Dupond\",\n" +
            "    \"FirstName\" : \"Hugo\"\n" +
            "}"
    },
    {
        id : "4",
        name : "POST /api/test/create",
        desc: "Permet de créer un utilisateur",
        jsonEnt: "    {\n" +
            "        \"FirstName\": \"Jason\",\n" +
            "        \"LastName\": \"Jasonnette\",\n" +
            "        \"BirthdayDate\": \"2001-10-04\",\n" +
            "        \"Sexe\": \"H\",\n" +
            "        \"Description\": \"Je suis une Description\",\n" +
            "        \"Mail\": \"jasonnette@js.fr\"\n" +
            "    }"
    },
    {
        id : "5",
        name : "DELETE /api/test/delete",
        desc : "Permet de supprimer un utilisateur",
        jsonEnt: "{\n" +
            "    \"idUser\" : 5\n" +
            "}"
    }
]