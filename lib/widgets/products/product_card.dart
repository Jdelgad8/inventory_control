import 'package:flutter/material.dart';
import 'package:inventory_control/models/product.dart';
import 'package:inventory_control/scoped-models/main.dart';
import 'package:inventory_control/widgets/products/address_tag.dart';
import 'package:inventory_control/widgets/products/price_tag.dart';
import 'package:inventory_control/widgets/ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(
            product.title,
          ),
          SizedBox(
            width: 5.0,
          ),
          PriceTag(
            product.price.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          //64. Permite alinear los elementos. Usa como argumento un MainAxisAlignment que accede
          //    a la propiedad que configura cómo queremos alinear los elementos. En este caso
          //    se alinea al centro
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            /* FlatButton(
                child: Text('Details'),
                //66. Navigator permite la navegación entre páginas. Accede al método push para
                //    poner una página encima de la actual.
                onPressed: () => Navigator.push<bool>(
                      context,
                      //67. Necesita cómo parámetros el contexto y una ruta que en este caso es un
                      //    Widget instanceado: MaterialPageRoute, esta ruta agrega la animación y
                      //    controla la página destino. Cómo parámetro de nombre de este Widget
                      //    pasamos un builder y este recibe una función que almacena el widget al
                      //    que se navegará
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductPage(
                              products[productIndex]['title'],
                              products[productIndex]['image'],
                            ),
                      ),
                      //69. Permite escuchar un evento futuro para ejecutar acciones cuando dicho
                      //    evento ocurra, en este caso se captura un valor pasado desde la el pop
                      //    de la página a la que este widget hace push
                    ).then((bool value) {
                      if (value) {
                        deleteProduct(productIndex);
                      }
                    }),
                onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      '/product/' + productIndex.toString(),
                    ),
              ), */
            IconButton(
              icon: Icon(Icons.info),
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.pushNamed<bool>(context,
                  '/product/' + model.allProducts[productIndex].productId),
            ),
            IconButton(
              icon: Icon(model.displayedProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectProduct(model.allProducts[productIndex].productId);
                model.toggleProductFavoriteStatus();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          //130 Agrega un placeholder para mantener el espacio de la imagen antes de que cargue
          FadeInImage(
            placeholder: AssetImage('assets/place-holder.jpg'),
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          _buildTitlePriceRow(),
          AddressTag(
            product.ubication,
          ),
          Text(product.userEmail),
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
