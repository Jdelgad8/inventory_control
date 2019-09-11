import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String productUbication;

  AddressTag(this.productUbication);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 2.5,
      ),
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(productUbication),
    );
  }
}
