import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {
  final int? id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime dataPublicacao;
  final DateTime? dataAtualizacao;

  NoticiaModel(
    this.id,
    this.titulo,
    this.descricao,
    this.imagem,
    this.dataPublicacao,
    this.dataAtualizacao,
  );

  factory NoticiaModel.fromJSon(Map map) {
    return NoticiaModel(
        map['id'] ?? '0',
        map['titulo'],
        map['descricao'],
        map['imagem'],
        DateTime.fromMicrosecondsSinceEpoch(int.parse(map['dataPublicacao'])),
        map['dataAtualizacao'] != null
            ? DateTime.fromMicrosecondsSinceEpoch(
                map['dataAtualizacao'],
              )
            : null);
  }

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dataPublicacao: $dataPublicacao, dataAtualizacao: $dataAtualizacao)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
      'dataPublicacao': dataPublicacao.millisecondsSinceEpoch,
      'dataAtualizacao': dataAtualizacao?.millisecondsSinceEpoch,
    };
  }

  factory NoticiaModel.fromMap(Map<String, dynamic> map) {
    return NoticiaModel(
      map['id'] != null ? map['id'] as int : null,
      map['titulo'] as String,
      map['descricao'] as String,
      map['imagem'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['dataPublicacao'] as int),
      map['dataAtualizacao'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataAtualizacao'] as int)
          : null,
    );
  }

  Map toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
    };
  }

  //String toJson() => json.encode(toMap());

  factory NoticiaModel.fromJson(String source) =>
      NoticiaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
