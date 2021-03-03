import '../simple_commerce_api.dart';

class DbConfig extends Configuration {
  DbConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
