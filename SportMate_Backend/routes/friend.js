const express = require("express");
const router = express.Router();
const friendCtlr = require("../controllers/friend")

//Import des middlewares
const auth = require('../middleware/auth');

//GET
router.get('/test', friendCtlr.test);
router.get('/friendRequest', auth, friendCtlr.retrieveFriendRequest);
router.get('/retrieveFriend', auth, friendCtlr.retrieveFriend);

//POST
router.post('/createFriendship', auth, friendCtlr.createFriendship);
router.post('/validateRequest', auth, friendCtlr.validateFriendship);

//DELETE BY POST
router.post('/deleteFriend', auth, friendCtlr.deleteFriendship);

module.exports = router;