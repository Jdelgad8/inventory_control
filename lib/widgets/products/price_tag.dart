import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;

  PriceTag(this.price);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 2.5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        //94. \ sirve para agregar un símbolo reservado como string y $ por si solo
        //    define que la expresión dentro de '', es una variable
        '\$$price',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
