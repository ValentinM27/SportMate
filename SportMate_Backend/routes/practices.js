const express = require("express");
const router = express.Router();
const practicesCtlr = require("../controllers/practices")

//Import des middlewares
const auth = require('../middleware/auth');

//GET
router.get('/test', practicesCtlr.test);
router.get('/retrievePractices', auth, practicesCtlr.retrievePractices);


//POST
router.post('/setPractices', auth, practicesCtlr.setPractices);
router.post('/retrievePracticesByEmail', practicesCtlr.retrievePracticesUser);

//DELETE BY POST
router.post('/deletePractices', auth, practicesCtlr.deletePractices);

module.exports = router;