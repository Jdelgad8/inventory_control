// 2. Importa los elementos del SDK de flutter
import 'package:flutter/material.dart';
import 'package:inventory_control/models/product.dart';
import 'package:inventory_control/pages/auth.dart';
import 'package:inventory_control/pages/product.dart';
import 'package:inventory_control/pages/products.dart';
import 'package:inventory_control/pages/products_admin.dart';
import 'package:inventory_control/scoped-models/main.dart';
import 'package:map_view/map_view.dart';
import 'package:scoped_model/scoped_model.dart';

//51. Importa el paquete para hacer debug a la interfaz de la app
//import 'package:flutter/rendering.dart';

// 0. Método principal que se ejecuta cuando la app se inicia, como no retorna nada se define
//    de tipo void
void main() {
  //147 Establece conección con la llave del api de la app
  MapView.setApiKey("AIzaSyARRJ66QT7_3IzBMoM1U3gXH7cL982hKLI");
  //52. Variable que habilita una forma de visualizar y debuggear los elementos de la interfaz
  //debugPaintSizeEnabled = true;
  //53. Variable que habilita un sombreado cuando se hace tap sobre un elemento para identificar
  //    el alcance de este tap
  //debugPaintPointersEnabled = true;
  // 9. Método especial que requiere como parámetro un objeto del Widget que queremos mostrar
  //    en la pantalla cuando inicie la app
  runApp(MyApp());
}

/* // 1. Define la clase "MyApp" y se hereda funcionalidades de StatelessWidget para definir un
//    widget simple sin datos dinámicos y únicamente visuales
class MyApp extends StatelessWidget {
  // 3. Método requerido por un StatelessWidget, definimos Widget antes de build para referenciar
  //    específicamente el tipo de objeto que debe retornar, que trata de dibujar algo en la
  //    pantalla en un método que le decimos que es un Widget. Requiere datos pasados como
  //    parámetros que son llamados por flutter. En este caso es el contexto, que es un objeto con
  //    metadatos de la app y la posición donde es dibujado este widget, se puede definir el tipo
  //    de argumento específico antes de pasarlo. El @override especifica que es un metodo
  //    requerido y que lo estamos sobre-escribiendo
  @override
  Widget build(BuildContext context) {
    // 4. Especifica que es lo que queremos dibujar o retornar en la pantalla. Un Widget siempre
    //    debe retornar otro widget en el método build(). En este caso retorna un Widget especial
    //    que envuelve la app entera para darnos la habilidad para definir el tema (colores), el
    //    navegador, etc. Este es el Widget principal de la raíz de la app y se usa en todas
    //    las aplicaciones que se creen
    return MaterialApp(
      // 5. Agrega información adicional para configurar el widget principal a través de argumentos.
      //    En este caso, espera "argumentos de nombre", de este modo = <<nombre_argumento: valor,>>
      //    El argumento home requiere otro Widget, que es el widget que será renderizado en la
      //    pantalla cuando la app carga. En este caso se usa Scaffold que crea una nueva página en
      //    la app con un  fondo blanco customizable, con la habilidad de agregar un app bar, etc.
      home: Scaffold(
        // 6. Agrega un app bar, (La barra superior), appBar a su vez requiere un Widget, que en
        //    este caso será AppBar que viene incluida dentro del paquete de flutter.
        appBar: AppBar(
          // 7. Define el título de la barra, requiere otro widget que sera renderizado como un
          //    título, en este caso será el Widget Text.
          title: Text(
              // 8. Text requiere un "argumento posicional", que en este caso es un String con el
              //    título deseado
              'EasyList'),
        ),
        body: Column(
          children: <Widget>[
            //18. Contenedor para alojar uno o varios Widgets y separarlos de otros
            Container(
              //19. Configura el margen del contenedor, requiere una clase específica para
              //    configurar el margen y accede a los lados donde se quiere agregar el margen
              //    (all, horizontal, vertical, top, bottom, left, right) y se le pasa un número
              //    decimal para definir la magnitud del margen
              margin: EdgeInsets.all(10.0),
              //16. Agrega un botón.
              child: RaisedButton(
                //17. "Argumento de nombre" que requiere una función para ser ejecutada cuando el
                //    botón sea presionado
                onPressed: () {

                },
                child: Text('Add product'),
              ),
            ),
            //10. Widget que define los widgets que serán renderizados en la página entre el app
            //    bar y el nav bar en caso de existir uno. En este caso se muestra una carta que
            //    nos brinda un contenido resaltado con una sombra leve.
            Card(
              //11. Widget que define el contenido de un "Widget padre". En este caso se usa una
              //    columna que organiza varios "Widgets hijos" de forma vertical
              child: Column(
                //12. Widget que define multiples widgets dentro de un "widget padre" que permite
                //    múltiples "widgets hijos"
                children: <Widget>[
                  //13. Añade una imagen, requiere un contructor especial donde accede al método
                  //    asset que está configurado para recibir un asset, y como parámetro se
                  //    indica la ruta del archivo que se desea utilizar en un string
                  Image.asset('assets/food.jpg'),
                  Text('Food Paradise'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} */

/* //20. Crea un StatefulWidget que permite trabajar con estados y datos dinámicos. Este widget se
//    renderiza cada vez que agregamos estados o cada vez que modificamos estados
class MyApp extends StatefulWidget {
  @override
  //21. Retorna un objeto de estado y especifica que ese estado pertenece a este mismo
  //    StatefulWidget
  State<StatefulWidget> createState() {
    //23. Retorna la clase creada específicamente para manejar los estados dentro del widget y
    //    la retornamos como un objeto instanciado
    return _MyAppState();
  }
}

//22. Define una clase que solo debe ser usada o llamada dentro de este archivo. Hereda de la clase
//    State, brindada por flutter para manejar los estados. Y le especificamos la clase a la que
//    pertenece.
class _MyAppState extends State<MyApp> {
  //24. Propiedades del Widget. Se define un tipo de dato, un nombre y un valor inicial opcional.
  //    En este caso se utiliza una Lista de Strings y se define un valor inicial.
  List<String> _products = ['Food tester'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  //29. Función especial que permite definir un estado, el cuál al ser agregado
                  //    o modificado, podrá renderizar nuevamente los widgets donde se llame
                  //    este estado. Requiere como parámetro una función donde se define la
                  //    actualización del estado
                  setState(() {
                    // 28. Añade un nuevo String a la propiedad de clase
                    _products.add('Advanced food tester');
                  });
                },
                child: Text('Add product'),
              ),
            ),
            Column(
              children: _products
                  .map(
                    (element) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/food.jpg'),
                              //26. Accede al texto almacenado en la propiedad ya que es una
                              //    lista de String
                              Text(element),
                            ],
                          ),
                        ),
                  )
                  //27. Convierte el elemento retornado a una lista para poder ser retornada
                  //    correctamente en el children de la columna
                  .toList(),
            ),
            //25. Llama a la propiedad de esta clase y se ejecuta un método map() que permite
            //    ejecutar cierto código para cada elemento de esa lista. En este caso se retorna
            //    una carta por cada elemento de la lista
          ],
        ),
      ),
    );
  }
} */

/* class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //54. Agrega una rejilla donde se muestran los pixeles de la pantalla
      //debugShowMaterialGrid: true,
      //39. Define los colores y estilos de material design para la app
      theme: ThemeData(
        //41. Define el tema de la app para modo dark o modo light
        brightness: Brightness.light,
        //40. Define un color para la app y el resto de colores son inferidos basados en este.
        //    Para definir el color usamos un objeto de tipo Colors y una propiedad "static type"
        //    para poder usarlo sin tener que instanciar la clase entera
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
      ),
      /* home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: ProductManager(
            //44. Uso de el argumento de nombre definido en ProductManager. Si se omite este
            //    argumento, usará el valor por defecto definido en caso de tenerlo
            //startingProduct: 'Food Tester'
            ),
      ), */
      // home: AuthPage(),
      //81. Agrega rutas nombradas para navegar de una manera global donde la app sepa cual
      //    pagina es cual. Como valor acepta un Map, donde la llave es el nombre de la ruta
      //    que le daremos y el valor de esa llave es la página a la que corresponde esa ruta
      routes: {
        '/': (BuildContext context) => ProductsPage(),
        '/admin': (BuildContext context) => ProductsAdminPage(),
      },
      //83. Ejecuta código cuando se usa una ruta nombrada, debe retornar la ruta a la que se quiere
      //    navegar
      onGenerateRoute: (RouteSettings settings) {
        //84. settings almacena una ruta "/products/2" por ejemplo. Con el método split sacamos los
        //    valores sin incluir los / para almacenarlos en variables y acceder a los productos
        //    desde esta página
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute(
            builder: (BuildContext context) => ProductPage(
                  products[index]['title'],
                  products[index]['image'],
                ),
          );
        }
        return null;
      },
    );
  }
} */

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    //145 Ejecuta una función cuando el "subject" definido en el UserModel se activa. En este caso
    //    cuando el usuario ya no está loggeado
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //118 Crea una instancia global del modelo que se usa en toda la app, para que la app solo use
    //    una misma instancia del modelos y evitar la incoherencia de datos
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurple,
        ),
        routes: {
          '/': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsPage(_model),
          // '/': (BuildContext context) => ProductsPage(),

          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsAdminPage(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId = pathElements[2];
            final Product product =
                _model.allProducts.firstWhere((Product product) {
              return product.productId == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductPage(product),
            );
          }
          return null;
        },
        //85. Ejecuta código cuanto onGenerateRoute falla en generar una ruta. Por ejemplo cuando
        //    el usuario trata de volver a una página donde los datos llamados del servidor fueron
        //    borrados. En este caso navega a la página principal
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : ProductsPage(_model),
          );
        },
      ),
    );
  }
}
