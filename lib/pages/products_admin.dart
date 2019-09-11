import 'package:flutter/material.dart';
import 'package:inventory_control/pages/product_edit.dart';
import 'package:inventory_control/pages/product_list.dart';
import 'package:inventory_control/scoped-models/main.dart';
import 'package:inventory_control/widgets/ui_elements/logout_list_tile.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;

  ProductsAdminPage(this.model);
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(),
          LogoutListTile(),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //77. Prepara la página para agregrar pestañas a la página. Con el argumento length define
    //    cuantas pestañas tendrá.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('Manage products'),
          //77. Agrega elementos debajo del header
          bottom: TabBar(
            //78. Argumento para definir pestañas
            tabs: <Widget>[
              //79. Widget para agregar una pestaña con un ícono y un texto específico
              Tab(
                icon: Icon(Icons.create),
                text: 'Create product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My products',
              ),
            ],
          ),
        ),
        //80. Construye la página dependiendo de la pestaña seleccionada
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(),
            ProductListPage(model),
          ],
        ),
      ),
    );
  }
}
