import 'package:shelf/shelf.dart';
import '../apis/blog_api.dart';
import '../apis/login_api.dart';
import '../custom_server.dart';
import '../services/noticia_service.dart';
import '../utils/custom_env.dart';
import 'dependency_injector/dependency_injector.dart';
import 'middleware_interception.dart';
import 'security/security_service.dart';
import 'security/security_service_imp.dart';

void main() async {
  CustomEnv.fromFile('.env');

  final _di = DependencyInjector();

  _di.register<SecurityService>(() => SecurityServiceImp(), isSingleton: true);
  var _securityservice = _di.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityservice).getHandler())
      .add(BlogApi(NoticiaService()).getHandler(isSecurity: true))
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
