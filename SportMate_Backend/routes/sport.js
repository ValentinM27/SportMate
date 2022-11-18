const express = require('express');
const router = express.Router();
const sportCtrl = require('../controllers/sport');

//Import des middlewares
const auth = require('../middleware/auth');

//GET
router.get('/test', sportCtrl.test);
router.get('/retrieveSports', auth, sportCtrl.retrieveSport);

module.exports = router;