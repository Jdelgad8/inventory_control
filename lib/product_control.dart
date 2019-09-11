/* import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  //49. Crea una propiedad de clase que va a almacenar la referencia a una función
  final Function addProduct;
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      //50. Usa la propiedad de clase de la función para que se ejecute la función que se pasa al
      //    constructor desde la clase que llama a esta clase
      onPressed: () {
        addProduct({'title': 'Chocolate', 'image': 'assets/food.jpg'});
      },
      child: Text('Add product'),
    );
  }
} */
