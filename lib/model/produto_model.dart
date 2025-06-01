class ProdutoModel {
  int? id;
  String nome;
  double precoCompra;
  double precoVenda;
  int quantidade;
  String descricao;
  String categoria;
  String? imagem;
  bool ativo;
  bool emPromocao;
  double desconto;

  ProdutoModel({
    this.id,
    required this.nome,
    required this.precoCompra,
    required this.precoVenda,
    required this.quantidade,
    required this.descricao,
    required this.categoria,
    required this.imagem,
    required this.ativo,
    required this.emPromocao,
    required this.desconto,
  });

  // ✅ Converte para Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'preco_compra': precoCompra,
      'preco_venda': precoVenda,
      'quantidade': quantidade,
      'descricao': descricao,
      'categoria': categoria,
      'imagem': imagem,
      'ativo': ativo ? 1 : 0,
      'em_promocao': emPromocao ? 1 : 0,
      'desconto': desconto,
    };
  }

  // ✅ Cria um Produto a partir de um Map
  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'],
      nome: map['nome'] ?? '',
      precoCompra: (map['preco_compra'] ?? 0).toDouble(),
      precoVenda: (map['preco_venda'] ?? 0).toDouble(),
      quantidade: (map['quantidade'] ?? 0).toInt(),
      descricao: map['descricao'] ?? '',
      categoria: map['categoria'] ?? '',
      imagem: map['imagem'],
      ativo: (map['ativo'] ?? 0) == 1,
      emPromocao: (map['em_promocao'] ?? 0) == 1,
      desconto: (map['desconto'] ?? 0).toDouble(),
    );
  }
}
