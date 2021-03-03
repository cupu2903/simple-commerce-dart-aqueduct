import 'package:simple_commerce_api/model/category.dart';
import 'package:simple_commerce_api/simple_commerce_api.dart';

class CategoryController extends ResourceController {
  CategoryController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCategory() async {
    final q = Query<Category>(context);
    final categories = await q.fetch();
    return Response.ok(categories);
  }

  @Operation.post()
  Future<Response> createCategory(@Bind.body() Category category) async {
    final q = Query<Category>(context)..values = category;
    try {
      final insertedCategory = await q.insert();
      return Response.ok(insertedCategory);
    } catch (e) {
      if (e.toString().contains(
          "Specified parameter types do not match column parameter types")) {
        return Response.created("Category Created", body: category);
      }
      return Response.badRequest(body: e.toString());
    }
  }
}
