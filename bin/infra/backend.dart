import 'package:shelf/shelf.dart';

import '../apis/blog_api.dart';
import '../apis/login_api.dart';
import '../custom_server.dart';
import '../services/noticia_service.dart';
import '../utils/custom_env.dart';
import 'middleware_interception.dart';
import 'security/security_service_imp.dart';

void main() async {
  CustomEnv.fromFile('.env');

  var cascadeHandler = Cascade()
      .add(LoginApi(SecurityServiceImp()).handler)
      .add(BlogApi(NoticiaService()).handler)
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(SecurityServiceImp().authorization)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      // address: await CustomEnv.get<String>(key: 'server_address'),
      // port: await CustomEnv.get<int>(key: 'server_port'),
      address: 'localhost',
      port: 8080);
}
