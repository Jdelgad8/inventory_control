import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_control/models/auth.dart';
import 'package:inventory_control/models/product.dart';
import 'package:inventory_control/models/user.dart';
import 'package:rxdart/subjects.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _productId;
  bool _isLoading = false;
}

//121 Permite combinar varias clases
mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    //116 Retorna una nueva instancia de lista de productos en vez de una referencia a la lista
    //    interna del modelo en la linea 7. Esto ayuda a que no se edite por accidente esta lista
    //    desde afuera
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      //120 Ejecuta una función para cada elemento de la lista
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.productId == _productId;
    });
  }

  String get selectedProductId {
    return _productId;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.productId == _productId;
    });
  }

  //131 Retorna en el bloque then verdadero cuando el proceso fue exitoso o falso si no lo fue
  Future<bool> addProduct(
    String title,
    double price,
    String description,
    String image,
    String ubication,
    //133 Convirte la función en una función "async" asíncrona. Quiere decir que completa
    //    acciones que hacen peticiones a un servidor y por lo tanto toman cierto tiempo en
    //    completarse
  ) async {
    _isLoading = true;
    notifyListeners();
    //124 Crea un mapa para almacenar los datos del producto que se enviarán al servidor
    final Map<String, dynamic> productData = {
      'title': title,
      'price': price,
      'description': description,
      'image':
          'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg',
      'ubication': ubication,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    try {
      //134 Reemplaza la función del método then(). Regresa un valor que se almacena en una variable
      //
      final http.Response response = await http
          //123 Define la operación que se realiza sobre el API. En este caso es un post al servidor
          //    de Firebase en la tabla products
          .post(
        'https://flutter-products-jordy.firebaseio.com/products.json?auth=${_authenticatedUser.token}',
        body: json.encode(productData),
        //125 Accede a la respuesta que devuelve Firebase de tipo response. Dentro de esta
        //    respuesta se puede acceder al cuerpo de la respuesta donde se extrae el id del
        //    producto agregado. Para esto se convierte el json que retorna en un objeto Map
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
        productId: responseData['name'],
        title: title,
        price: price,
        description: description,
        image: image,
        ubication: ubication,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
      );
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
    //132 Captura los errores de toda la función, incluso antes del then y dentro del then
    //   .catchError((error) {
    // _isLoading = false;
    // notifyListeners();
    // return false;
    // }
    // );
  }

  Future<bool> updateProduct(
    String title,
    double price,
    String description,
    String image,
    String ubication,
  ) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'price': price,
      'description': description,
      'image':
          'https://cdn.pixabay.com/photo/2015/10/02/12/00/chocolate-968457_960_720.jpg',
      'ubication': ubication,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    return http
        .put(
      'https://flutter-products-jordy.firebaseio.com/products/${selectedProduct.productId}.json?auth=${_authenticatedUser.token}',
      body: json.encode(updateData),
    )
        .then((http.Response response) {
      _isLoading = false;
      final Product updatedProduct = Product(
        productId: selectedProduct.productId,
        title: title,
        price: price,
        description: description,
        image: image,
        ubication: ubication,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
      );
      _products[selectedProductIndex] = updatedProduct;

      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.productId;

    _products.removeAt(selectedProductIndex);
    _productId = null;
    notifyListeners();
    return http
        .delete(
            'https://flutter-products-jordy.firebaseio.com/products/$deletedProductId.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void selectProduct(String productId) {
    _productId = productId;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() async {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
      productId: selectedProduct.productId,
      title: selectedProduct.title,
      price: selectedProduct.price,
      description: selectedProduct.description,
      image: selectedProduct.image,
      ubication: selectedProduct.ubication,
      isFavorite: newFavoriteStatus,
      userEmail: _authenticatedUser.email,
      userId: _authenticatedUser.id,
    );
    _products[selectedProductIndex] = updatedProduct;
    // _productIndex = null;
    //119 Indica al modelo que debe ejecutar de nuevo el método donde se encuentra el llamado
    //    a esta función para renderizar nuevamente con los cambios ejecutados
    notifyListeners();
    http.Response response;
    if (newFavoriteStatus) {
      response = await http.put(
        'https://flutter-products-jordy.firebaseio.com/products/${selectedProduct.productId}/favoritesUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
        body: jsonEncode(true),
      );
    } else {
      response = await http.delete(
          'https://flutter-products-jordy.firebaseio.com/products/${selectedProduct.productId}/favoritesUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      final Product updatedProduct = Product(
        productId: selectedProduct.productId,
        title: selectedProduct.title,
        price: selectedProduct.price,
        description: selectedProduct.description,
        image: selectedProduct.image,
        ubication: selectedProduct.ubication,
        isFavorite: !newFavoriteStatus,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
      );
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
    _productId = null;
  }

  //127 Permite a la función retornar una promesa sin que retorne ningun dato para brindar la
  //    información cuando termine el proceso de fetchProducts
  Future<Null> fetchProducts({onlyForUser = false}) {
    _isLoading = true;
    notifyListeners();
    //126 Realiza una petición al servidor para acceder a los productos almacenados
    return http
        .get(
            'https://flutter-products-jordy.firebaseio.com/products.json?auth=${_authenticatedUser.token}')
        .then<Null>((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            productId: productId,
            title: productData['title'],
            price: productData['price'],
            description: productData['description'],
            image: productData['image'],
            ubication: productData['ubication'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            //146 Le informa a flutter que el elemento que retorna es un map con un elemento
            //    booleano y verifica si contiene el id del usuario actual
            isFavorite: productData['favoritesUsers'] == null
                ? false
                : (productData['favoritesUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
      _products = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
          : fetchedProductList;
      _isLoading = false;
      notifyListeners();
      _productId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}

mixin UserModel on ConnectedProductsModel {
  Timer _authTimer;
  //143 Emite un valor al cual podemos escuchar. En este caso se usa un booleano para verificar
  //    si el usuario esta loggeado o no.
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyDzzXuZ4q7gvHa11kwJcHKifyvUg-ybaJA',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDzzXuZ4q7gvHa11kwJcHKifyvUg-ybaJA',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong!';
    print(response);
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded';
      _authenticatedUser = User(
        id: responseData['localId'],
        email: email,
        token: responseData['idToken'],
      );
      setAuthTimeout(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      //140 Almacena la hora y la fecha actual
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      //136 Crea un objeto que permite interactuar con el almacenamiento del dispositivo
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //137 Añade datos al objeto prefs para guardar la información en el almacenamiento del
      //    dispositivo. Este perdura después de cerrar completamente la aplicación
      prefs.setString('userId', responseData['localId']);
      prefs.setString('userEmail', email);
      prefs.setString('token', responseData['idToken']);
      //141 Convierte el objeto de fecha y hora en un string con el formato adecuado
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Email already registered';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Email isn\'t registered';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Incorrect password entered';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //138 Accede a el dato guardado en el almacenamiento del teléfono
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      final DateTime now = DateTime.now();
      //142 Convierte el string de tiempo en un objeto de tiempo
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      //143 Verifica si el tiempo de expiración ya pasó comparado con el tiempo actual
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userId = prefs.getString('userId');
      final String userEmail = prefs.getString('userEmail');
      //144 Almacena en segundos el tiempo restante que queda entre el tiempo de expiración del
      //    token y el tiempo actual
      final int tokenLifeSpan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(
        id: userId,
        email: userEmail,
        token: token,
      );
      _userSubject.add(true);
      setAuthTimeout(tokenLifeSpan);
      notifyListeners();
    }
  }

  void logout() async {
    print('logout');
    _authenticatedUser = null;
    _authTimer.cancel();
    //144 Añade un evento. En este caso el evento es retornar falso para definir que el usuario
    //    no está loggeado
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }

  void setAuthTimeout(int time) {
    //139 Define una "temporizador" cuando pase la duración establecida en la unidad de tiempo
    //    establecida y ejecuta la función del segundo parámetro cuando este tiempo se cumpla
    _authTimer = Timer(Duration(seconds: time), logout);
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
