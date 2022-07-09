import 'package:shelf/shelf.dart';

import '../apis/blog_api.dart';
import '../apis/login_api.dart';
import '../custom_server.dart';
import '../services/noticia_service.dart';
import '../utils/custom_env.dart';
import 'middleware_interception.dart';
import 'security/security_service.dart';
import 'security/security_service_imp.dart';

void main() async {
  CustomEnv.fromFile('.env');

  SecurityService _securityservice = SecurityServiceImp();

  var cascadeHandler = Cascade()
      .add(LoginApi(SecurityServiceImp()).getHandler(middlewares: [
        createMiddleware(requestHandler: (Request req) {
          print('LOG -> ${req.url}');
        })
      ]))
      .add(BlogApi(NoticiaService()).getHandler(
        middlewares: [
          _securityservice.authorization,
          _securityservice.verifyJwt,
        ],
      ))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      // address: await CustomEnv.get<String>(key: 'server_address'),
      // port: await CustomEnv.get<int>(key: 'server_port'),
      address: 'localhost',
      port: 8080);
}
