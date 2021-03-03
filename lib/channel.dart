import 'package:simple_commerce_api/controller/cart_controller.dart';
import 'package:simple_commerce_api/controller/category_controller.dart';
import 'package:simple_commerce_api/model/product_cart.dart';
import 'package:simple_commerce_api/model/category.dart';
import 'package:simple_commerce_api/model/product.dart';
import 'package:simple_commerce_api/model/users.dart';
import 'package:simple_commerce_api/utils/configuration.dart';
import 'package:simple_commerce_api/utils/db_config.dart';

import 'controller/login.controller.dart';
import 'controller/product_controller.dart';
import 'middleware/auth.middleware.dart';
import 'model/cart.dart';
import 'simple_commerce_api.dart';
class SimpleCommerceApiChannel extends ApplicationChannel {
  ManagedContext context;
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final config = DbConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel([Category, Product, Users, Cart, ProductCart]);
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);
    context = ManagedContext(dataModel, psc);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
        .route('/login')
        .link(()=> LoginController(context));
    router
        .route('/category')
        .link(()=> CategoryController(context));

    router
        .route('/product/[:id]')
        .link(()=> ProductController(context));
    router
        .route('/cart/[:id]')
        .link(() => AuthMiddleware())
        .link(() => CartController(context));

    return router;
  }
}