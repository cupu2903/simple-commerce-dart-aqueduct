import 'package:simple_commerce_api/model/cart.dart';

import '../simple_commerce_api.dart';

class Users extends ManagedObject<_Users> implements _Users {}

@Table(name: 'users')
class _Users {
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column(unique: true, indexed: true)
  String email;

  @Column()
  String password;

  @Column()
  String full_name;

  @Column()
  DateTime created_at;

  ManagedSet<Cart> carts;
}
