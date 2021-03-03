

import '../simple_commerce_api.dart';

class JWTAuthConfiguration extends Configuration {
  JWTAuthConfiguration(String path): super.fromFile(File(path));
  DatabaseConfiguration database;
}