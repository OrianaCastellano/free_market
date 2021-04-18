const express = require('express');
const router = express.Router();

const indexCtrl = require('../controllers/ctr_index');


// AQUI DEBO LLAMAR TODAS LAS PAGINAS ESTATICAS CON EL RENDER

// Obtener información
router.get('/user_control', indexCtrl.listUsers);
// Pasar información
router.post('/add', indexCtrl.saveUser);
// :id esto se conoce como un parametro de la ruta
router.get('/delete/:id', indexCtrl.deleteUser);
router.get('/update/:id', indexCtrl.editUser);

router.post('/update/:id', indexCtrl.updateUser);

//LOGIN
router.post('/auth', indexCtrl.auth);
router.get('/profile', indexCtrl.logIn);
router.get('/logout', indexCtrl.logOut);

// VISTA PARA EL HOME
router.get('/', indexCtrl.renderHome);

// VISTA PARA EL LISTADO DE PRODUCTOS
router.get('/products', indexCtrl.listProducts);

// renderizar vista producto
router.get('/form_product', indexCtrl.renderFormProduct);
// Acción Agregar un producto
router.post('/add_product', indexCtrl.saveProduct);
router.get('/products/:id', indexCtrl.listProductsUser);
router.get('/delete_product/:id', indexCtrl.deleteProductUser);
router.get('/update_product/:id', indexCtrl.editProductUser);
router.get('/detail_product/:product_id', indexCtrl.renderDetailProduct);

// Renderizar form reseña
router.get('/form_review/:product_id', indexCtrl.renderFormReseña);
router.post('/add_review', indexCtrl.saveReview);

// Renderizar form respuesta reseña
router.get('/form_request/:review_id', indexCtrl.renderFormRequestReview);
router.post('/add_request', indexCtrl.saveRequestReview);
router.get('/list_request/:id_review', indexCtrl.listRequestReview);
router.get('/delete_request/:id_request', indexCtrl.deleteRequestReview);

//Enviar datos formulario editar producto
router.post('/update_product/:id', indexCtrl.updateProductUser);
module.exports = router;