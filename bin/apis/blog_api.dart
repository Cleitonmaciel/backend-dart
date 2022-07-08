import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../services/generic_service.dart';

class BlogApi {
  final GenericiService _service;
  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    // listagem
    router.get('/blog/noticias', (Request req) {
      _service.findAll();
      return Response.ok('Choveu hoje!');
    });

    // nova noticia
    router.post('/blog/noticias', (Request req) {
      // _service.save('');
      return Response.ok('Nova notícia!');
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

    return router;
  }
}
