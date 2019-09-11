import 'package:inventory_control/scoped-models/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

//122 Combina las propiedades y los métodos de los modelos mencionados en el with para poder tener
//    acceso a todas ellas donde necesitamos el scoped model
class MainModel extends Model
    with ConnectedProductsModel, ProductsModel, UserModel, UtilityModel {}
