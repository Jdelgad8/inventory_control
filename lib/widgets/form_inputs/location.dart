/* import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:map_view/map_view.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  //148 Objeto que permite saber cuando un campo está siendo enfocado y cuando deja de estarlo
  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    //149 Ejecuta un método cada vez que el foco del campo de texto cambia
    _addressInputFocusNode.addListener(_updateLocation);

    super.initState();
  }

  //150 Se ejecuta cuando nos deshacemos de un widget. Por ejemplo cuando salimos de la pantalla
  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void getStaticMap(String address) async {
    if (address.isEmpty) {
      return;
    }
    //155 Genera la url de la api de geolocalización de google y anexa a esta la dirección del
    //    campo de texto y la llave de la api
    final Uri uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {
        'address': address,
        'key': 'AIzaSyARRJ66QT7_3IzBMoM1U3gXH7cL982hKLI',
      },
    );
    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    final coords = decodedResponse['results'][0]['geometry']['location'];

    final StaticMapProvider staticMapViewProvider =
        StaticMapProvider("AIzaSyARRJ66QT7_3IzBMoM1U3gXH7cL982hKLI");
    //151 Obtiene el link del mapa estático con pines
    final staticMapUri = staticMapViewProvider.getStaticUriWithMarkers(
      [
        //152 Define un pin con el id, título, latitud y longitud pasadas como parametro
        Marker('position', 'Position', coords['lat'], coords['lng']),
      ],
      //153 Define el centro del mapa con la latitud y la longitud
      center: Location(coords['lat'], coords['lng']),
      width: 500,
      height: 300,
      maptype: StaticMapViewType.roadmap,
    );
    setState(() {
      _addressInputController.text = formattedAddress;
      _staticMapUri = staticMapUri;
    });
  }

  void _updateLocation() {
    //154 Verifica si el campo no tiene el foco
    if (!_addressInputFocusNode.hasFocus) {
      getStaticMap(_addressInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _addressInputFocusNode,
          controller: _addressInputController,
          decoration: InputDecoration(labelText: 'Address'),
        ),
        SizedBox(
          height: 10.0,
        ),
        Image.network(_staticMapUri.toString()),
      ],
    );
  }
}
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:map_view/map_view.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    _addressInputFocusNode.addListener(_updateLocation);
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void getStaticMap(String address) async {
    if (address.isEmpty) {
      return;
    }
    final Uri uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {'address': address, 'key': 'AIzaSyCLQTG59usHzrIRrkQwmb8Pzu8OMqsa7ho'},
    );
    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    final coords = decodedResponse['results'][0]['geometry']['location'];

    final StaticMapProvider staticMapViewProvider =
        StaticMapProvider('AIzaSyCLQTG59usHzrIRrkQwmb8Pzu8OMqsa7ho');
    final Uri staticMapUri = staticMapViewProvider.getStaticUriWithMarkers(
        [Marker('position', 'Position', coords['lat'], coords['lng'])],
        center: Location(coords['lat'], coords['lng']),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      _addressInputController.text = formattedAddress;
      _staticMapUri = staticMapUri;
    });
  }

  void _updateLocation() {
    if (!_addressInputFocusNode.hasFocus) {
      getStaticMap(_addressInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _addressInputFocusNode,
          controller: _addressInputController,
          decoration: InputDecoration(labelText: 'Address'),
        ),
        SizedBox(
          height: 10.0,
        ),
        Image.network(_staticMapUri.toString())
      ],
    );
  }
}
