const express = require('express');
const router = express.Router();
const testCtrl = require("../controllers/test");

//Import des middlewares
const auth = require("../middleware/auth");

//Get
router.get('/', testCtrl.test);
router.get('/retrieve', auth, testCtrl.testRetrieve);
//Post
router.post('/update', auth, testCtrl.testUpdate);
router.post('/create', auth, testCtrl.testCreate);
//Delete
router.delete('/delete', auth, testCtrl.testDelete);

module.exports = router;