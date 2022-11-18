const express = require('express');
const app = express();
app.use(express.json())

//Import du token de l'API
const {token} = require('./ressources/token.json');

//Import des routes
const testRoutes = require('./routes/test');
const authRoutes = require('./routes/user');
const eventRoutes = require('./routes/event');
const friendRoutes = require('./routes/friend');
const joinRoutes = require('./routes/join');
const commentRoutes = require('./routes/comment');
const sportRoutes = require('./routes/sport');
const practicesRoutes = require('./routes/practices');

//Set header, permet l'accès à l'API peut importe l'origine de l'appareil
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    next();
});

//Redirection des requêtes vers les routes
app.use(`/${token}/api/test`, testRoutes);
app.use(`/${token}/api/user`, authRoutes);
app.use(`/${token}/api/event`, eventRoutes);
app.use(`/${token}/api/friend`, friendRoutes);
app.use(`/${token}/api/join`, joinRoutes);
app.use(`/${token}/api/comment`, commentRoutes);
app.use(`/${token}/api/sport`, sportRoutes);
app.use(`/${token}/api/practices`, practicesRoutes);


module.exports = app;