import 'package:mx_crud/scoped-models/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with ContectedProductsModel, UserModel, ProductModel, UtilityModel {}
