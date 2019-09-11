import 'package:flutter/material.dart';
import 'package:inventory_control/models/product.dart';
import 'package:inventory_control/scoped-models/main.dart';
import 'package:inventory_control/widgets/form_inputs/location.dart';
import 'package:scoped_model/scoped_model.dart';

/* class ProductCreatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Save'),
        onPressed: () {
          //87. Crea una ventana que aparece desde abajo de la pantalla para mostrar información
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Text('This is a modal'),
              );
            },
          );
        },
      ),
    );
  }
} */

class ProductEditPage extends StatefulWidget {
  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  //110 Almacena todas las variables donde se almacenarán los datos del usuario en el formulario
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'decription': null,
    'image': 'assets/food.jpg',
    'ubication': 'Villavicencio, Meta',
  };
  //104 Define una llave para el formulario dentro de este widget y que se pueda acceder a este
  //    desde cualquier parte de este Widget
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    /* //88. Permite agregar un campo de texto para que el usuario ingrese información
    return TextField(
      //89. Ejecuta código cuando el campo de texto es modificado, recibe como parámetro un
      //    String con el valor que contiene
      onChanged: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
      //91. Permite configurar los estilos para el campo.
      decoration: InputDecoration(
        //92. Añade una etiqueta para que el usuario sepa que tiene que ingresar en ese campo
        labelText: 'Product title',
      ),
    ); */
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      initialValue: product == null ? '' : product.title,
      onSaved: (String value) {
        _formData['title'] = value;
      },
      //105 Toma el valor del campo y retorna un String en caso de que la validación definida
      //    falle. Es decir retorna un error en pantalla al usuario y cuando no retorna nada,
      //    quiere decir que no presenta ningún error
      validator: (String value) {
        //106 Remueve los espacios en blanco del String
        //if(value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be at least 5 characters long';
        }
      },
      //107 Valida automáticamente cuando sale del campo y la validación no pasa
      //autovalidate: true,
    );
  }

  Widget _buildPriceTextField(Product product) {
    /* return TextField(
      //90. Define el tipo de teclado que se quiere utilizar cuando selecciona el campo. En
      //    este caso se define un teclado numérico
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        setState(() {
          _priceValue = double.parse(value);
        });
      },
      decoration: InputDecoration(
        labelText: 'Product price',
      ),
    ); */
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Product price',
      ),
      initialValue: product == null ? '' : product.price.toString(),
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number';
        }
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Product description',
      ),
      initialValue: product == null ? '' : product.description,
      onSaved: (String value) {
        _formData['description'] = value;
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is required and should be at least 10 characters long';
        }
      },
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    //108 Retorna verdadero cuando todos los campos dentro del formulario pasaron la validacion y
    if (!_formkey.currentState.validate()) {
      return;
    }
    //105 Asocia el estado actual del formulario de la llave definida y ejecuta el método on Save
    //    en cada campo del formulario
    _formkey.currentState.save();

    if (selectedProductIndex == -1) {
      addProduct(
        _formData['title'],
        _formData['price'],
        _formData['description'],
        _formData['image'],
        _formData['ubication'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Something went wrong',
                  ),
                  content: Text('Pleasy try again'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _formData['title'],
        _formData['price'],
        _formData['description'],
        _formData['image'],
        _formData['ubication'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null)));
    }
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        //109 Permite cerrar el teclado cuando hace tap por fuera del formulario
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildPriceTextField(product),
              _buildDescriptionTextField(product),
              //93. Ocupa un espacio definido en pantalla sin mostrar ningún contenido
              SizedBox(
                height: 10.0,
              ),
              LocationInput(),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton()
              //103 Permite añadir métodos para interactuar cuando el usuario presiones el Widget
              /* GestureDetector(
                onTap: _submitForm,
                child: Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(5.0),
                  child: Text('My button'),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                textColor: Colors.white,
                onPressed: () => _submitForm(
                      model.addProduct,
                      model.updateProduct,
                      model.selectProduct,
                      model.selectedProductIndex,
                    ),
                child: Text('Save'),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent);
      },
    );
  }
}
