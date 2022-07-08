// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {
  final int id;
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

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dataPublicacao: $dataPublicacao, dataAtualizacao: $dataAtualizacao)';
  }
}
