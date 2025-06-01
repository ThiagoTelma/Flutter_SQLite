import 'package:cadastro_produto_banco_dados/database/product_database.dart';
import 'package:cadastro_produto_banco_dados/page/components/list_item.dart';
import 'package:flutter/material.dart';
import '../model/produto_model.dart';
import 'product_form_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<ProdutoModel>> _carregaProdutos() async {
    final db = ProductDatabase();
    return await db.findAllProducts();
  }

  Future<void> _updateList() async {
    await _carregaProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista e Cadastro de Produto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: const [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: null,
          ),
        ],
      ),
      backgroundColor: Colors.deepPurple[100],
      body: Scaffold(
        backgroundColor: Colors.grey[100],
        body: FutureBuilder<List<ProdutoModel>>(
          future: _carregaProdutos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.grey),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Erro ao carregar produtos: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "Nenhum produto cadastrado.",
                  style: TextStyle(color: Colors.black54, fontSize: 18.0),
                ),
              );
            }
            final listaProduto = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 75),
              itemCount: listaProduto.length,
              itemBuilder: (context, index) {
                final produto = listaProduto[index];
                return ListItem(product: produto, onUpdate: _updateList);
              },
            );
          },
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            ProdutoModel? produto = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
            if (produto != null) {
              final db = ProductDatabase();
              await db.insertProduct(produto);
              setState(() {
                // Atualiza a lista de produtos após inserir um novo produto.
              });
            }
          },
          label: const Text(
            'Novo Produto',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
