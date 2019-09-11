//34. Importa el widget creado en nuestro directorio principal

/* class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;

  //43. Define un "argumento de nombre" en vez de un argumento posicional. Este argumento permite
  //    definir un valor por defecto.
  // ProductManager({this.startingProduct = 'Sweets Tester'})
  ProductManager({this.startingProduct}) {
    print('[ProductManager Widget] Constructor');
  }
  @override
  _ProductManagerState createState() {
    print('[ProductManager Widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  //36. Método que permite definir estados iniciales dentro de la clase de estado, es ejecutado
  //    cuando se inicializa la clase, antes del método build
  @override
  void initState() {
    print('[ProductManager state] initState()');
    //37. super se refiere a la clase de donde se está heredando la funcionalidad, la llama para
    //    asegurarse que esté presente incluso si se sobrescribe
    super.initState();
    if (widget.startingProduct != null) {
      //38. widget permite acceder a las propiedades de clase de la clase widget vinculada a esta
      //    clase estado
      _products.add(widget.startingProduct);
    }
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    print('[ProductManager state] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  //47. Método que añade un producto nuevo pasado por parámetro. El producto es un Map y se define
  //    que tipos contiene el map. En este caso la llave es un String y los elementos asociados
  //    son tambien String
  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductManager state] build()');
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          //48. Pasa como argumento al constructor un método. No se instancia por lo cual no se
          //    ejecuta inmediatamente cuando se ejecuta el constructor, es un a referencia a la
          //    función
          child: ProductControl(_addProduct),
          /* child: RaisedButton(
            //42. Define un color para el elemento. En este caso usa el objeto especial "Theme",
            //    con un método "of" y utiliza como parámetro el contexto para poder acceder a
            //    El primary color definido de la app
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                print('[ProductManager state] setState()');
                _products.add('Advanced food tester');
              });
            },
            child: Text('Add product'),
          ), */
        ),
        //56. Widget que toma todo el espacio disponible después de los widgets anteriores
        Expanded(
          //35. Instancia el widget importado y se le pasa como parámetro los datos de la propiedad de
          //    clase local en su constructor.
          child: Products(
            _products,
            deleteProduct: _deleteProduct,
          ),
        ),
      ],
    );
  }
} */

/* class ProductManager extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Products(products),
        ),
      ],
    );
  }
} */
