const express = require("express");
const router = express.Router();
const userCtrl = require("../controllers/user");

//Import des middlewares
const auth = require('../middleware/auth');
const testPassword = require('../middleware/testPassword');

//GET
router.get('/test', userCtrl.test);
router.get('/dataUser', auth, userCtrl.dataUser);
router.get('/checkToken', auth, userCtrl.checkToken);



//POST
router.post('/register', testPassword, userCtrl.register);
router.post('/login', userCtrl.login);
router.post('/passwordChange', auth, testPassword, userCtrl.passwordChange);
router.post('/updateUser', auth, userCtrl.modifyUser);
router.post('/emailChange', auth, userCtrl.emailChange);
router.post('/retrieveUsersDatas', userCtrl.retrieveUserData);
router.post('/search', auth, userCtrl.searchUser);
router.post('/changePassword', testPassword, userCtrl.setNewPassword);
router.post('/resetPassword', userCtrl.resetPassword);

//DELETE
router.delete('/deleteUser', auth, userCtrl.deleleteUser);

module.exports = router;