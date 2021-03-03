import 'package:simple_commerce_api/model/cart.dart';
import 'package:simple_commerce_api/model/product.dart';
import 'package:simple_commerce_api/model/product_cart.dart';
import 'package:simple_commerce_api/simple_commerce_api.dart';
import 'package:uuid/uuid.dart';

class CartController extends ResourceController {
  CartController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  FutureOr<Response> getCart(@Bind.path('id') String cartId) async {
    try {
      final attachment = request.attachments['id'];
      final q = Query<Cart>(context)
        ..where((x) => x.id).equalTo(cartId)
        ..where((x) => x.buyer.id).equalTo(int.parse(attachment.toString()));
      final fetch = q.fetchOne();
      if (fetch != null) {
        final qProductByCart = Query<ProductCart>(context)
          ..where((x) => x.cart.id).equalTo(cartId);
        final list = await qProductByCart.fetch();
        return Response.ok(list);
      } else {
        return Response.notFound();
      }
    } catch (e) {
      return Response.notFound();
    }
  }

  @Operation.post('id')
  FutureOr<Response> addToCart(@Bind.path('id') String cartId,
      @Bind.body() ProductCart productCart) async {
    try {
      final attachment = request.attachments['id'];
      final q = Query<Cart>(context)
        ..where((x) => x.id).equalTo(cartId)
        ..where((x) => x.buyer.id).equalTo(int.parse(attachment.toString()));
      final cart = await q.fetchOne();
      if (cart != null) {
        final qProductByCart = Query<ProductCart>(context)
          ..values.id = Uuid().v1()
          ..values.cart = cart
          ..values.product = productCart.product
          ..values.qty = productCart.qty;
        print(qProductByCart.values.toString());
        final productCartCreated = await qProductByCart.insert();
        return Response.created("Product Added to Cart",
            body: productCartCreated);
      } else {
        return Response.notFound();
      }
    } catch (e, s) {
      return Response.notFound(body:e.toString());
    }
  }
}
