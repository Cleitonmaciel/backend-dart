import 'package:shelf/shelf.dart';

import '../apis/blog_api.dart';
import '../apis/login_api.dart';
import '../custom_server.dart';

void main() async {
  var cascadeHandler =
      Cascade().add(LoginApi().handler).add(BlogApi().handler).handler;

  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await CustomServer().initialize(handler);
}
