import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:simple_commerce_api/middleware/auth.provider.dart';
import '../model/users.dart';
import '../utils/hash.dart';

class LoginController extends ResourceController {
  LoginController(this.context);
  final ManagedContext context;

  @Operation.post()
  FutureOr<Response> login(@Bind.body() Users user) async {
    if (user.email == null || user.password == null) {
      return Response.badRequest(
          body: {'error': 'email and password are required'});
    }
    final query = Query<Users>(context)
      ..where((u) => u.email).equalTo(user.email);
    final Users fetchedUser = await query.fetchOne();
    print(fetchedUser);
    if (fetchedUser == null) {
      return Response.badRequest(body: {'error': 'users not found'});
    } else {
      if (fetchedUser.password == Hash.create(user.password)) {
        print(fetchedUser.toString());
        return Response.ok({
          "success": true,
          "message": 'Successfully login',
          "token": await AuthProvider().auth(fetchedUser.id.toString())
        });
      } else {
        return Response.badRequest(body: {'error': 'wrong password'});
      }
    }
  }
}
