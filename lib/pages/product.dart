import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventory_control/models/product.dart';
import 'package:inventory_control/widgets/products/address_tag.dart';
import 'package:inventory_control/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  /* _showWarningDialog(BuildContext context) {
    //86. Crea una alerta en la pantalla, usa como parámetro un widget predefinido
    //    para manejar alertas
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('This action cannot be undone!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Discard'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  } */

  final Product product;

  ProductPage(this.product);

  Widget _buildTitle(Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TitleDefault('Nombre'),
        Text(
          product.title,
          style: TextStyle(
              fontSize: 20.0, fontFamily: 'Oswald', color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _buildPrice(Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TitleDefault('Precio'),
        Text(
          '\$ ' + product.price.toString(),
          style: TextStyle(
              fontSize: 20.0, fontFamily: 'Oswald', color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _buildDescription(Product product) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault('Descripción'),
          Text(
            product.description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0, fontFamily: 'Oswald', color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildUbication(Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TitleDefault('Ubicación'),
        AddressTag(product.ubication),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //70. Verifica cuando el botón de volver es presionado. El argumento de nombre onWillPop,
    //    almacena código para ser ejecutado cuando el usuario quiere volver a la página anterior
    return WillPopScope(
      onWillPop: () {
        //print('Back button pressed!');
        Navigator.pop(context, false);
        //71. Permite retornar un valor para definir si el usuario puede regresar o no, puede ser
        //    que le definamos regresar dos veces de una vez con el pop y el valor false de futuro
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FadeInImage(
                  placeholder: AssetImage('assets/place-holder.jpg'),
                  image: NetworkImage(product.image),
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      _buildTitle(product),
                      _buildPrice(product),
                      _buildDescription(product),
                      _buildUbication(product),
                    ],
                  ),
                ),
              ],
            )

            /* Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Delete'),
                //68. Pop permite regresar a la página anterior cuando se navegó a esta con un push
                onPressed: () => _showWarningDialog(context),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
