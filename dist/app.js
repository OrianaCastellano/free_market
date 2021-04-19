const express = require('express');
const path = require('path');
const morgan = require('morgan');
const mysql = require('mysql');
const myConnection = require('express-myconnection');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const app = express();


// SETTINGS
// 1. Configuración de puertos
// 2. Configuracion de carpetas
// 3. Configuración de vistas
// _dirname -> Me permite traer la ruta desde donde estoy ejecutando ese archivo
// path -> Me permite concatenar rutas
// Si quiero que la aplicación tenga otro puerto cambio el 3000 por un puerto valido
app.set('port', process.env.PORT || 3000);
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// MIDDLEWARE
// Se ejecutan antes de las peticiones del usuario
// morgan('dev) se usa para imprimir los mensajes de las peticiones en consola
// myConeccection se usa para conectar la app con la bd
app.use(cookieParser());
app.use(morgan('dev'));
app.use(myConnection(mysql, {
  host: 'us-cdbr-east-03.cleardb.com',
  user: 'bd1a595984bdaf',
  password: 'd4b32c6a',
  port: 3306,
  database: 'heroku_cd05ed895bbf370'
}, 'single'))
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true
}))
app.use(express.urlencoded({
  extended: false
}));


// IMPORTING ROUTES
const siteRoutes = require('./routes/index');
const { urlencoded } = require('express');

//ROUTES
// Son las rutas de las páginas que tendra mi app
app.use('/', siteRoutes);

// STATIC FILES
app.use("/static", express.static(__dirname + '/public'));


// Inicializar el servidor
app.listen(app.get('port'), () => {
  console.log("run on: http://localhost:3000/");
})