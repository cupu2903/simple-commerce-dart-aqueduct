import 'package:simple_commerce_api/model/product_cart.dart';
import 'package:simple_commerce_api/simple_commerce_api.dart';

import 'category.dart';

class Product extends ManagedObject<_Product> implements _Product {
}

@Table(name: 'product')
class _Product {
  @Column(primaryKey: true,databaseType: ManagedPropertyType.bigInteger, autoincrement: true)
  int id;

  String product_name;
  @Column(databaseType: ManagedPropertyType.bigInteger)
  int price;
  @Relate(#products)
  Category cat;

  ManagedSet<ProductCart> productCarts;
}
