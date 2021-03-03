import 'package:simple_commerce_api/model/product.dart';
import 'package:simple_commerce_api/simple_commerce_api.dart';

class Category extends ManagedObject<_Category> implements _Category{

}
@Table(name: 'category')
class _Category{
  @Column(primaryKey: true, databaseType: ManagedPropertyType.bigInteger, autoincrement: true)
  int code;
  String cat_name;

  ManagedSet<Product> products;
}