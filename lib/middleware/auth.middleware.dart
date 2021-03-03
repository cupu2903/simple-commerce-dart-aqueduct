//import '../helpers/auth.provider.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:simple_commerce_api/middleware/JWTConstant.dart';

import '../simple_commerce_api.dart';

class AuthMiddleware extends Controller {
  @override
  Future<RequestOrResponse> handle(Request request) async {
    try {
      final String token =
          request.raw.headers['authorization'][0].replaceAll('Bearer ', '');
      final JwtClaim claim =
          verifyJwtHS256Signature(token, JWTConstant.SIGNATURE);
      print(claim);
      claim.validate(
          issuer: JWTConstant.ISSUER, audience: JWTConstant.AUDIENCE);
      request.attachments['id'] = claim.subject;
      return request;
    } catch (e) {
      return Response.unauthorized(body: {"error": 'User not authorized'});
    }
  }
}
