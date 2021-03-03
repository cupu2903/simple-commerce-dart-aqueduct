import 'dart:async';

import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:simple_commerce_api/middleware/JWTConstant.dart';

class AuthProvider {
  
  FutureOr<String> auth(String userId) async {
    final JwtClaim claim = JwtClaim(
      subject: userId,
      issuer: JWTConstant.ISSUER,
      audience: [JWTConstant.AUDIENCE],
    );

    final String token = issueJwtHS256(claim, JWTConstant.SIGNATURE);
    return token;
  }
}