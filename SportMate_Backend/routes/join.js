const express = require('express');
const router = express.Router();
const joinCtrl = require("../controllers/join");

//Import des middlewares
const auth = require("../middleware/auth");

//GET
router.get('/test', joinCtrl.test);
router.get('/retrieveJoinedEvents', auth, joinCtrl.retrieveJoinedEvents)


//POST
router.post('/joinEvent', auth, joinCtrl.joinEvent);
router.post('/retrieveParticipant', auth, joinCtrl.participateToEvent);
router.post('/participate', auth, joinCtrl.participate)

//DELETE BY POST
router.post('/leftEvent', auth, joinCtrl.leftEvent);

module.exports = router;