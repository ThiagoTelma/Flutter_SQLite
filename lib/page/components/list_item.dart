import 'package:cadastro_produto_banco_dados/database/product_database.dart';
import 'package:cadastro_produto_banco_dados/page/product_form_page.dart';
import 'package:flutter/material.dart';

import '../../model/produto_model.dart';
import '../../widgets/chip_info.dart';

class ListItem extends StatelessWidget {
  final ProdutoModel product;
  final VoidCallback onUpdate;

  const ListItem({super.key, required this.product, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nome
            Row(
              children: [
                const Icon(Icons.label, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    product.nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Imagem (se houver)
            if (product.imagem != null && product.imagem.toString().isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imagem!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text('Imagem não carregada')),
                ),
              ),
            if (product.imagem != null && product.imagem.toString().isNotEmpty)
              const SizedBox(height: 12),

            /// Preços e quantidade
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChipInfoWidget(
                    label: 'Compra R\$ ${product.precoCompra}',
                    icon: Icons.shopping_cart,
                  ),
                  const SizedBox(width: 8),
                  ChipInfoWidget(
                    label: 'Venda R\$ ${product.precoVenda}',
                    icon: Icons.attach_money,
                  ),
                  const SizedBox(width: 8),
                  ChipInfoWidget(
                    label: 'Qtd ${product.quantidade}',
                    icon: Icons.inventory,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// Categoria
            Row(
              children: [
                const Icon(Icons.category, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Categoria: ${product.categoria}',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 4),

            /// Descrição
            Row(
              children: [
                const Icon(Icons.description, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Descrição: ${product.descricao}',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Status
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icon(
                    product.ativo ? Icons.check_circle : Icons.cancel,
                    color: product.ativo ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    product.ativo ? 'Ativo' : 'Inativo',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(width: 12),
                  // Informa se está em promoção
                  Icon(
                    product.emPromocao ? Icons.discount : Icons.price_check,
                    color: product.emPromocao ? Colors.orange : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    product.emPromocao ? 'Em Promoção' : 'Sem Promoção',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(width: 8),
                  const Icon(Icons.percent, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Desconto: ${product.desconto}%',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.deepPurple),
                  onPressed: () async {
                    final ProdutoModel? produtoAlterado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductFormPage(product: product),
                      ),
                    );
                    if (produtoAlterado != null) {
                      // Salva alteração no banco
                      final db = ProductDatabase();
                      await db.updateProduct(product.id!, produtoAlterado);
                      onUpdate();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final db = ProductDatabase();
                    await db.deleteProduct(product.id!);
                    onUpdate();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
