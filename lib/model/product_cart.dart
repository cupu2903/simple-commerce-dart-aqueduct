import 'package:simple_commerce_api/model/product.dart';
import 'package:simple_commerce_api/simple_commerce_api.dart';

import 'cart.dart';

class ProductCart extends ManagedObject<_ProductCart> implements _ProductCart {

}

@Table(name: 'product_cart')
class _ProductCart {
  @Column(primaryKey: true, databaseType: ManagedPropertyType.string)
  String id;

  @Relate(#cartsProduct, onDelete: DeleteRule.cascade, isRequired: true)
  Cart cart;

  @Relate(#productCarts, onDelete: DeleteRule.cascade, isRequired: true)
  Product product;

  @Column(databaseType: ManagedPropertyType.bigInteger, nullable: false)
  int qty;

  @override
  String toString() {
    return '_ProductCart{id: $id, cart: $cart, product: $product, qty: $qty}';
  }
}
