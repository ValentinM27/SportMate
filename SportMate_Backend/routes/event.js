const express = require("express");
const router = express.Router();
const eventCtrl = require("../controllers/event");


//Import des middlewares
const auth = require('../middleware/auth');

//GET
router.get('/test',eventCtrl.test);
router.get('/retrieveEvent', auth, eventCtrl.retrieveEvent);
router.get('/retrieveEventByCurrentUser', auth, eventCtrl.retrieveEventsByCurrentUser);
router.get('/retrieveEventByFriendsList', auth, eventCtrl.retrieveEventByFriendsList);

//POST
router.post('/createEvent', auth, eventCtrl.createEvent);
router.post('/retrieveEventBySport', auth, eventCtrl.retrieveEventsBySport);
router.post('/retrieveEventByUser', auth, eventCtrl.retrieveEventByUser);

//DELETE BY POST
router.post('/deleteEvent', auth, eventCtrl.deleteEvent);

module.exports = router;