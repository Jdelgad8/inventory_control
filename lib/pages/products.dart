import 'package:flutter/material.dart';
import 'package:inventory_control/scoped-models/main.dart';
import 'package:inventory_control/widgets/products/products.dart';
import 'package:inventory_control/widgets/ui_elements/logout_list_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            //76. Utiliza dentro del panel el mismo icono de la ventana principal del panel
            automaticallyImplyLeading: false,
            title: Text('Choose'),
            //75. Widget que permite tener una lista de elementos con elementos anidados en cada
            //    fila.
          ),
          ListTile(
            //99. Añade contenido al inicio de cada texto del menú lateral
            leading: Icon(
              Icons.edit,
            ),
            title: Text('Manage products'),
            onTap: () {
              //82. Utiliza la ruta nombrada definida en el main
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          Divider(),
          LogoutListTile(),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(
          child: Text('No products found!'),
        );
        if (model.displayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          //128 Muestra un spinner
          content = Center(
            child: CircularProgressIndicator(),
          );
        }
        //129 Permite ejecutar una acción cuando el usuario arrastra hacia abajo la página. En
        //    este caso, se actualizan los productos de la base de datos a la pantalla
        return RefreshIndicator(
          onRefresh: model.fetchProducts,
          child: content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //74. permite agregar un botón de navegación en el header a la izquierda. Usa un widget
      //    especial que permite manejar la navegación desde este panel
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        //100 Permite añadir un botón de icono al final del AppBar
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          ),
        ],
      ),
      body: _buildProductsList(),
    );
  }
}
