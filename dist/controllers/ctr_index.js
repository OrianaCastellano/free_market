const controller = {};

// Metodo autentificación
// 1. valida si el correo existe en la BD para ingresar al perfil
//  si no existe envia ciertos mensajes dependiendo al tipo de error
controller.auth = async (req, res) => {
  const user = req.body.user_email;
  const pass = req.body.user_pass;

  req.getConnection((err, conn) => {
    if (user && pass) {
      conn.query("SELECT * FROM tbl_user WHERE user_email = ?", [user], async (err, rta) => {
        setInterval(function () {
          conn.query('SELECT 1');
        }, 5000);
        console.log("AQUI")
        console.log(rta[0])
        if (rta[0] != null) {
          if (res.length == 0 || pass != rta[0].user_pass) {
            // enviar mensaje para contraseña vacia
            res.redirect('/?auth=false')
          } else {
            req.session.loggedin = true;
            req.session.user_id = rta[0].user_id;
            req.session.name = rta[0].user_name;
            req.session.lastname = rta[0].user_lastname;
            req.session.document_id = rta[0].user_document_id;
            req.session.email = rta[0].user_email;
            req.session.phone = rta[0].user_phone;
            req.session.pass = rta[0].user_pass;
            res.redirect("profile");
          }
        } else {
          // enviar mensaje para correo no encontrado
          res.redirect('/?auth=false&mail=false')
        }
      })
    } else {
      // enviar mensaje para campos vacios
      res.redirect('/?auth=false&input=null')
    }
  })
}

// LISTAR USUARIOS DE LA BD
controller.listUsers = (req, res) => {
  req.getConnection((err, conn) => {
    conn.query("SELECT * FROM tbl_user", (err, userRows) => {

      if (err) {
        next(err);
      }

      // console.log(userRows)
      res.render('userList', {
        data: userRows
      });

    });
  })
}

// INSERTAR USUARIO EN LA BD
controller.saveUser = (req, res) => {

  req.getConnection((err, conn) => {
    conn.query('INSERT INTO tbl_user set ?', [req.body], (err, rowTables) => {
      res.redirect("user_control");
    })
  })
}

// LISTAR LOS DATOS DEL USUARIO EN EL FORMULARIO EDITAR
controller.editUser = (req, res) => {
  const { id } = req.params;

  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM tbl_user WHERE user_id = ?', [id], (err, user) => {
      if (user != null) {
        if (req.session.loggedin) {
          res.render('edit', {
            data: user[0],
            login: true,
            id: req.session.user_id,
            name: req.session.name,
            update: false,
            updateProduct: false
          });
        }
      } else {
        res.redirect('/?users=none')
      }
    });
  })
}

// MODIFICAR EL USUARIO
controller.updateUser = (req, res) => {
  const { id } = req.params;
  const userUpdate = req.body;
  req.getConnection((err, conn) => {
    conn.query('UPDATE tbl_user SET ? WHERE user_id = ?', [userUpdate, id], (err, rowuserUpdate) => {
      if (rowuserUpdate != null) {
        if (req.session.loggedin) {
          res.render('profile', {
            login: true,
            id: userUpdate.user_id,
            name: userUpdate.user_name,
            lastname: userUpdate.user_lastname,
            document_id: userUpdate.user_document_id,
            email: userUpdate.user_email,
            phone: userUpdate.user_phone,
            pass: userUpdate.user_pass,
            update: true,
            updateProduct: false
          });
        }
      } else {
        res.redirect('/?update_user=none')
      }
    });
  })
}

controller.deleteUser = (req, res) => {
  const { id } = req.params;

  req.getConnection((err, conn) => {
    conn.query('DELETE FROM tbl_user WHERE user_id = ?', [id], (error) => {
      if (error) {
        console.log(error)
        return res.redirect('/?user=nodelete');
      } else {
        return res.redirect('/?user=delete');
      }
    });
  });
}

// REDIRECCIONAR A LA PÁGINA DEL PERFIL
controller.logIn = (req, res) => {
  req.getConnection((err, conn) => {
    const user = req.session.email;
    if (req.session.loggedin) {
      conn.query("SELECT * FROM tbl_user WHERE user_email = ?", [user], async (err, rta) => {
        res.render('profile', {
          login: true,
          id: req.session.user_id,
          name: req.session.name,
          lastname: req.session.lastname,
          document_id: req.session.document_id,
          email: req.session.email,
          phone: req.session.phone,
          pass: req.session.pass,
          name_test: rta[0].user_email,
          update: false,
          updateProduct: false
        })
      });
    } else {
      res.render('home', {
        login: false,
        name: 'anonimo'
      })
    }
  });
}

//RENDERIZAR EL HOME
controller.renderHome = (req, res) => {
  if (req.session.loggedin) {
    res.render('home', {
      login: true,
      name: req.session.name,
    })
  } else {
    res.render('home', {
      login: false,
      name: 'anonimo',
    })
  }
}

// LISTAR PRODUCTOS DE LA BD
controller.listProducts = (req, res) => {
  req.getConnection((err, conn) => {
    conn.query("SELECT * FROM tbl_product", (err, userRows) => {
      conn.query("SELECT * FROM tbl_category", (errCategory, userRowsCategory) => {

        if (userRowsCategory != null) {

          if (err || errCategory) {
            console.log(err);
            console.log(errCategory);
          }

          if (req.session.loggedin) {
            res.render('list_products', {
              data: userRows,
              dataCategory: userRowsCategory,
              login: true,
              name: req.session.name,
            });
          } else {
            res.render('list_products', {
              login: false,
              name: 'anonimo',
              data: userRows,
              dataCategory: userRowsCategory
            })
          }
        } else {
          res.redirect('/?products=none')
        }

      });
    })
  })
}
// LISTAR PRODUCTOS SOLO DEL USUARIO
controller.listProductsUser = (req, res) => {
  const { id } = req.params;

  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM tbl_product WHERE tbl_user_user_id = ?', [id], (err, products) => {
      if (products != null) {
        if (req.session.loggedin) {
          res.render('my_products', {
            data: products,
            login: true,
            id: req.session.user_id,
            name: req.session.name
          });
        }
      } else {
        res.redirect('/?products_mine=none')
      }
    });
  })
}

controller.renderFormProduct = (req, res) => {
  req.getConnection((err, conn) => {
    conn.query("SELECT * FROM tbl_category", (err, userRows) => {

      if (err) {
        next(err);
      }

      if (req.session.loggedin) {
        res.render('form_add_product', {
          login: true,
          name: req.session.name,
          data: userRows,
          id_user: req.session.user_id
        });
      } else {
        res.render('home', {
          login: false,
          name: 'anonimo',
        })
      }

    });
  })
}

// INSERTAR PRODUCTO EN LA BD
controller.saveProduct = (req, res) => {
  req.getConnection((err, conn) => {
    conn.query('INSERT INTO tbl_product set ?', [req.body], (err, rowTables) => {
      if (err) {
        console.log(err)
      } else {
        console.log(rowTables);
        res.redirect("products");
      }
    })
  })
}

// ELIMILNAR PRODUCTO DE USUARIO
controller.deleteProductUser = (req, res) => {
  const { id } = req.params;

  req.getConnection((err, conn) => {
    conn.query('DELETE FROM tbl_product WHERE product_id = ?', [id], (error) => {
      if (error) {
        console.log(error)
        return res.redirect('/profile?product=nodelete');
      } else {
        return res.redirect('/profile?product=delete');
      }
    });
  });
}


// RENDERIZAR VISTA DEL FORMULARIO EDITAR
controller.editProductUser = (req, res) => {
  const { id } = req.params;

  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM tbl_product WHERE product_id = ?', [id], (err, productUser) => {
      conn.query("SELECT * FROM tbl_category", (errCategory, userRowsCategory) => {
        console.log(userRowsCategory)
        if (req.session.loggedin) {
          res.render('update_product', {
            data: productUser[0],
            dataCategory: userRowsCategory,
            login: true,
            id: req.session.user_id,
            name: req.session.name,
            update: false
          });
        }
      });
    });
  })
}

//FORMULARIO EDITAR PRODUCTO
controller.updateProductUser = (req, res) => {
  const { id } = req.params;
  const productUpdate = req.body;
  req.getConnection((err, conn) => {
    conn.query('UPDATE tbl_product SET ? WHERE product_id = ?', [productUpdate, id], (err, rowProductUpdate) => {
      if (req.session.loggedin) {
        res.render('profile', {
          login: true,
          id: req.session.user_id,
          name: req.session.name,
          data: productUpdate,
          lastname: req.session.lastname,
          document_id: req.session.document_id,
          email: req.session.email,
          phone: req.session.phone,
          pass: req.session.pass,
          update: false,
          updateProduct: true
        });
      }
    });
  })
}

//RENDERIZAR VISTA DETALLE DE PRODUCTO
controller.renderDetailProduct = (req, res) => {
  const { product_id } = req.params;
  console.log(req.params)

  req.getConnection((err, conn) => {
    conn.query("SELECT * FROM tbl_product WHERE product_id = ?", [product_id], (err, productRow) => {
      conn.query("SELECT * FROM tbl_category WHERE category_id = ?", [productRow[0].tbl_category_category_id], (errC, categoryRow) => {
        conn.query("SELECT * FROM tbl_review WHERE tbl_product_product_id = ?", [productRow[0].product_id], (errR, reviewRow) => {
          conn.query("SELECT SUM(review_qualification) as sum_quali FROM tbl_review WHERE tbl_product_product_id = ?", [productRow[0].product_id], (errQ, rowSumQualification) => {
            if (productRow != null && categoryRow != null) {

              if (err) {
                console.log(err);
              }

              res.render('detail_product', {
                data: productRow[0],
                login: true,
                id: req.session.user_id,
                name: req.session.name,
                lastname: req.session.lastname,
                document_id: req.session.document_id,
                email: req.session.email,
                phone: req.session.phone,
                pass: req.session.pass,
                categoryProduct: categoryRow[0].category_name,
                reviewProduct: reviewRow,
                sumQualification: rowSumQualification[0].sum_quali
              });
            } else {
              return res.redirect('/profile?detail=none');
            }

          });
        });
      });
    });
  } 
  })
}

// RENDERIZAR FORMULARIO PARA LA RESEÑA
controller.renderFormReseña = (req, res) => {
  req.getConnection((err, conn) => {

    const { product_id } = req.params;

    if (err) {
      next(err);
    }

    conn.query("SELECT * FROM tbl_product WHERE product_id = ?", [product_id], (err, productRow) => {
      console.log(productRow)
      if (req.session.loggedin) {
        res.render('form_add_review', {
          login: true,
          dataProduct: productRow[0],
          name: req.session.name,
          id_user: req.session.user_id
        });
      }
    });

  });
}

// INSERTAR RESEÑA EN LA BD
controller.saveReview = (req, res) => {

  req.getConnection((err, conn) => {
    // Se rellena tabla notificación
    responseNotification = {
      notification_title: 'Se ha agregado una nueva reseña, revisa en tu menu de usuario',
      tbl_user_user_id: req.body.tbl_user_user_id,
    };
    conn.query('INSERT INTO tbl_review set ?', [req.body], (errInsert, rowTables) => {
      if (errInsert) {
        console.log(errInsert)
      }

      conn.query('INSERT INTO tbl_notification set ?', [responseNotification], (errNoti, rowTablesNoti) => {
        res.redirect("profile/?review=add");
      })
    })
  })

}

//RENDER FORMULARIO RESPUESTA RESEÑA
controller.renderFormRequestReview = (req, res) => {
  const { review_id } = req.params;
  console.log(review_id)
  if (req.session.loggedin) {
    res.render('form_add_request', {
      login: true,
      name: req.session.name,
      id_user: req.session.user_id,
      request_review_id: review_id
    });
  }
}

controller.saveRequestReview = (req, res) => {
  req.getConnection((err, conn) => {

    if (err) {
      next(err);
    }

    conn.query("INSERT INTO tbl_request_review SET ?", [req.body], (err, requestRow) => {
      if (requestRow != null) {
        res.redirect("profile/?request_review=add");
      }
    });

  });
}

controller.listRequestReview = (req, res) => {
  const { id_review } = req.params;
  console.log('SILIENTEE')
  console.log(req.params)

  req.getConnection((err, conn) => {
    conn.query("SELECT * FROM tbl_request_review WHERE tbl_review_review_id = ?", [id_review], (err, reviewRequestRows) => {

      if (err) {
        next(err);
      }

      if (req.session.loggedin) {
        res.render('list_request_review', {
          data: reviewRequestRows,
          login: true,
          name: req.session.name,
          id_user: req.session.user_id,
          request_id_review: id_review
        });
      }
    });
  })
}

controller.deleteRequestReview = (req, res) => {
  const { id_request } = req.params;

  req.getConnection((err, conn) => {
    conn.query('DELETE FROM tbl_request_review WHERE request_id = ?', [id_request], (error) => {
      if (error) {
        res.redirect('/profile?request_review=nodelete');
      } else {
        res.redirect('/profile?request_review=delete');
      }
    });
  });
}

controller.logOut = (req, res) => {
  req.session.destroy(() => {
    res.redirect('/')
  })
}

module.exports = controller;