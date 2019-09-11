import 'package:flutter/material.dart';
import 'package:inventory_control/models/product.dart';
import 'package:inventory_control/scoped-models/main.dart';
import 'package:inventory_control/widgets/products/product_card.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  //32. Define a esta propiedad de clase como no-modificable con el tipo final ya que es un widget
  //    sin estado y no va a poder saber cuando esta propiedad sea modificada. Solo será definida
  //    desde afuera una vez, y si se reciben nuevos datos, estos nuevos remplazan a los datos
  //    actuales
  // final List<Map<String, dynamic>> products;
  //31. Método constructor, nos permite acceder a datos externos a esta clase mediante parámetros
  //    y definir código para ser ejecutado cuando se crea una instancia de esta clase. En este
  //    caso queremos recibir un producto y almacenarlo en una propiedad de clase con el mismo
  //    nombre
  //45. Define un argumento posicional "this.products" y permite definir un valor inicial por
  //    defecto encerrando en [] todo el argumento y definiendolo como constante.
  //    Ej. ([this.products = const ['Food Tester']])
  // Products(this.products) {
  //   //print('[Products Widget] Constructor');
  // }

  //58. Método que define los elementos a ser renderizados en la ListView. Requiere cómo parámetros
  //    el contexto y el índice de cada elemento
  /* Widget _buildProductItem(BuildContext context, int index) {

    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Container(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  products[index]['title'],
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(
                  width: 5.0,
                ),
                PriceTag(
                  products[index]['price'].toString(),
                ),
              ],
            ),
          ),
          Container(
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
            child: Text(products[index]['ubication']),
          ),
          ButtonBar(
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
                              products[index]['title'],
                              products[index]['image'],
                            ),
                      ),
                      //69. Permite escuchar un evento futuro para ejecutar acciones cuando dicho
                      //    evento ocurra, en este caso se captura un valor pasado desde la el pop
                      //    de la página a la que este widget hace push
                    ).then((bool value) {
                      if (value) {
                        deleteProduct(index);
                      }
                    }),
                onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      '/product/' + index.toString(),
                    ),
              ), */
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + index.toString()),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => {},
              ),
            ],
          ),
        ],
      ),
    );
  } */

  Widget _buildProductList(List<Product> products) {
    //61. Variable local utilizada para renderizar un elemento u otro dependiendo si se cumple
    //    la condición. Se define un valor inicial y solo cambia si la condición se cumple
    Widget productCards = Center(
      child: Text('No products found, please add some'),
    );
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    //print('[Products Widget] build()');
    //55. Widget que permite renderizar listas y permite que la pantalla sea scrolleable cuando
    //    los elementos exceden el límite de la pantalla de manera vertical, el elemento donde se
    //    almacena un ListView debe estar en un contenedor separado.
    //    Utiliza el constructor especial builder para definir nuevos atributos de configuración.
    //    Sirve para configurar el ListView para que sólo renderice y alamacene en memoria los
    //    elementos que están actualmente en la pantalla
    //60. Agrega una "expresion ternaria" que permite realizar condiciones en una sola linea. Se
    //    Define la condicion al inicio y se usa el símbolo ? para definir la expresión como un
    //    condicional. Después ejecuta el código cuando la condición sea verdadera y un else
    //    definido con el símbolo : para cuando la condición no se cumple
    /* return products.length > 0
        ? ListView.builder(
            //57. Argumento que define cómo debe construir los elementos dentro de la lista
            itemBuilder: _buildProductItem,
            //59. Argumento que define la cantidad de elementos de la ListView
            itemCount: products.length,
          )
        :  */
    //117 Ejecuta el método builder cada vez que un dato cambia en este modelo
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductList(model.displayedProducts);
      },
    );
  }
}
