import 'package:flutter/material.dart';
import 'package:inventory_control/models/auth.dart';
import 'package:inventory_control/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

//136 Objeto que permite tomar decisiones para distintos valores. Contiene los nombres de las
//    opciones definidas
// enum AuthMode { Signup, Login }

/* class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          child: Text('Login'),
          onPressed: () {
            //73. Permite pasar a la siguiente página y no permite volver a la actual
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
    );
  }
} */

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'accept_terms': false,
  };
  final TextEditingController _emailTextControler = TextEditingController();
  final TextEditingController _passwordTextControler = TextEditingController();
  //137 Define una variable para controlar en que modo se encuentra el usuario. Login o Signup
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      //96. AssetImage no retorna un widget de imagen, únicamente información de la imagen
      //    para mostrarla en pantalla
      image: AssetImage('assets/background.jpg'),
      //97. configura la forma como se muestra la imagen con respecto a su medida y el
      //    tamaño de la pantall
      fit: BoxFit.cover,
      //98. Cambia como se muestra la imagen en cuanto a sus colores y opacidad
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.6),
        BlendMode.dstATop,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['email'] = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        filled: true,
        fillColor: Colors.white,
      ),
      //135 Define un controlador para el campo de texto el cual almacena el valor ingresado
      controller: _emailTextControler,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      },
    );
  }

  Widget _buildEmailConfirmTextField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['email'] = value;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Confirm E-mail',
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (String value) {
        if (_emailTextControler.text != value) {
          return 'Email address don\'t match';
        }
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['password'] = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ),
      controller: _passwordTextControler,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password should be at least 6 characters long';
        }
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      onSaved: (String value) {
        _formData['password'] = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm password',
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (String value) {
        if (_passwordTextControler.text != value) {
          return 'Passwords don\'t match';
        }
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      title: Text('Accept terms'),
      value: _formData['accept_terms'],
      onChanged: (bool value) {
        setState(() {
          _formData['accept_terms'] = value;
        });
      },
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    if (!_formData['accept_terms']) {
      setState(() {
        _showWarningDialog(context);
      });
      return;
    }
    _formkey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await authenticate(
        _formData['email'], _formData['password'], _authMode);

    if (successInformation['success']) {
      //73. Permite pasar a la siguiente página y no permite volver a la actual
      // Navigator.pushReplacementNamed(context, '/');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An error ocurred!'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
    //print(_formData);
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Accept terms of conditions'),
          content: Text('Please read and accept our terms of conditions.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //102 Captura el total del tamaño de ancho de la pantalla en pixeles
    final double deviceWith = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWith > 550.0 ? 500.0 : deviceWith * 0.95;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          //95. Configura decoración para el contenedor. En este caso agrega una imagen de fondo
          decoration: BoxDecoration(
            image: _buildBackgroundImage(),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Container(
                  width: targetWidth,
                  child: Column(
                    children: <Widget>[
                      _buildEmailTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _authMode == AuthMode.Signup
                          ? _buildEmailConfirmTextField()
                          : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _authMode == AuthMode.Signup
                          ? _buildPasswordConfirmTextField()
                          : Container(),
                      _buildAcceptSwitch(),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login
                                ? AuthMode.Signup
                                : AuthMode.Login;
                          });
                        },
                        child: Text(
                            'Switch to: ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {
                          return model.isLoading
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  textColor: Colors.white,
                                  child: Text(_authMode == AuthMode.Login
                                      ? 'Login'
                                      : 'Signup'),
                                  onPressed: () =>
                                      _submitForm(model.authenticate),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
