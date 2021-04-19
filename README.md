# free-market
es una semi tienda virtual, con algunas funcionalidades como las que tiene la página de mercado libre


## Software requerido

 * Visual Studio Code para poder inspeccionar la funcionalidad de todo el código

## Tecnologias utilizadas

 * HTML, CSS y JS para toda la parte del Frontend (El frontend es todo lo visual, la parte grafica)
 * Nodejs para el backend y despliegue de la aplicación
 * Framework de Node Express
   - modulo mysql para conectar la BD
   - modulo my connection para consultas mas rapido
   - morgan ver peticiones que llegan al servidor
   - motor de plantilla EJS, procesar html antes de enviarlo al servidor

modulo para escribir mas dacil el desarrollo modulo nodemon
----
## Despligue en Heroku

Para desplegar la App desde github en Heroku 
basta conectar la cuenta de Github con el Cli de Heroku
desde [aqui](https://dashboard.heroku.com/apps/freemarketapp/deploy/github)

URL App Heroku: https://webmarketfree.herokuapp.com/

---

## Despligue en Local

Teniendo instalado NodeJs en la maquina en la carpeta principal que es free_market/ ejecutar

  > npm i                  <- Instalar todas las dependencias de node modules del proyecto
  
  > npm run dev            <- Correr el proyecto en un ambiente local

  > gulp                   <- Correr el preprocesador de css que es sass