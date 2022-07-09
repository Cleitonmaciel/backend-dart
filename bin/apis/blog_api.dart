import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericiService<NoticiaModel> _service;
  BlogApi(this._service);
  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    // listagem
    router.get('/blog/noticias', (Request req) {
      List<NoticiaModel> noticias = _service.findAll();
      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(noticiasMap));
    });

    // nova noticia
    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(NoticiaModel.fromJSon(jsonDecode(body)));
      return Response(201);
    });

    // update de noticia blog/noticias?id=1
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.save('');
      return Response.ok('Update da notícia $id');
    });

    //delete noticia blog/noticias?id=1
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      _service.delete(1);
      return Response.ok('Delete da noticia $id');
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
