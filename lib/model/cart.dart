import 'package:simple_commerce_api/model/product_cart.dart';
import 'package:simple_commerce_api/model/users.dart';
import 'package:simple_commerce_api/simple_commerce_api.dart';

class Cart extends ManagedObject<_Cart> implements _Cart {}

@Table(name: 'cart')
class _Cart {
  @Column(primaryKey: true, databaseType: ManagedPropertyType.string)
  String id;

  @Relate(#carts)
  Users buyer;

  @Column(databaseType: ManagedPropertyType.datetime)
  DateTime created_at;

  @Column(databaseType: ManagedPropertyType.boolean)
  bool status;

  ManagedSet<ProductCart> cartsProduct;
}
