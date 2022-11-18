const express = require('express');
const router = express.Router();
const commentCtrl = require('../controllers/comment');

//Import des middlewares
const auth = require('../middleware/auth');

//GET
router.get('/test', commentCtrl.test);


//POST
router.post('/createComment', auth, commentCtrl.createComment);
router.post('/retrieveComment', auth, commentCtrl.listComment);

//DELETE BY POST
router.post('/deleteComment', auth, commentCtrl.deleteComment);

module.exports = router;