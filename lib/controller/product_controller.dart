import 'package:simple_commerce_api/model/product.dart';
import 'package:simple_commerce_api/simple_commerce_api.dart';

class ProductController extends ResourceController {
  ProductController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllProduct() async {
    final q = Query<Product>(context);
    final products = await q.fetch();
    return Response.ok(products);
  }

  @Operation.get('id')
  Future<Response> getProductById(@Bind.path('id') int id) async {
    final q = Query<Product>(context)..where((x) => x.id).equalTo(id);
    final products = await q.fetchOne();
    return Response.ok(products);
  }

  @Operation.post()
  Future<Response> createProduct(@Bind.body() Product product) async {
    final q = Query<Product>(context)..values = product;
    try {
      final insertedProduct = await q.insert();
      return Response.ok(insertedProduct);
    } catch (e, s) {
      if (e.toString().contains(
          "Specified parameter types do not match column parameter types")) {
        return Response.created("Product Created", body: product);
      }
      return Response.badRequest(body: e.toString());
    }
  }

  @Operation.put('id')
  Future<Response> updateProduct(@Bind.path('id') String id,
      @Bind.body(ignore: ['id']) Product product) async {
    try {
      final q = Query<Product>(context)
        ..where((p) => p.id).equalTo(int.parse(id))
        ..values = product;
      final updatedProduct = await q.updateOne();
      return Response.ok(updatedProduct);
    } catch (e) {
      if (e.toString().contains(
          "Specified parameter types do not match column parameter types")) {
        return Response.ok(product);
      }
      return Response.badRequest(body: e.toString());
    }
  }

  @Operation.delete('id')
  Future<Response> delete(@Bind.path('id') String id) async {
    try {
      final q = Query<Product>(context)
        ..where((p) => p.id).equalTo(int.parse(id));
      final deletedProduct = await q.delete();
      return Response.ok(deletedProduct);
    } catch (e) {
      if (e.toString().contains(
          "Specified parameter types do not match column parameter types")) {
        return Response.ok("Product Deleted");
      }
      return Response.badRequest(body: e.toString());
    }
  }
}
