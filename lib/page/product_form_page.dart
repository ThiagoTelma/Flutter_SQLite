import 'package:cadastro_produto_banco_dados/model/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text3/flutter_masked_text3.dart';

import '../widgets/text_field_widget.dart';

class ProductFormPage extends StatefulWidget {
  final ProdutoModel? product;
  final VoidCallback? onSave;
  const ProductFormPage({super.key, this.product, this.onSave});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _productNameController.text = widget.product!.nome;
      _productPurchasePriceController.updateValue(widget.product!.precoCompra);
      _productSalePriceController.updateValue(widget.product!.precoVenda);
      _productQuantityController.updateValue(
        widget.product!.quantidade.toDouble(),
      );
      _productDescriptionController.text = widget.product!.descricao;
      _productImageController.text = widget.product!.imagem ?? '';
      _productActive = widget.product!.ativo;
      _productCategory = widget.product!.categoria;
      _productOnSale = widget.product!.emPromocao;
      _discountValue = widget.product!.desconto;
    }
  }

  final TextEditingController _productNameController = TextEditingController();
  final MoneyMaskedTextController _productPurchasePriceController =
      MoneyMaskedTextController(precision: 2);
  final MoneyMaskedTextController _productSalePriceController =
      MoneyMaskedTextController(precision: 2);

  final MoneyMaskedTextController _productQuantityController =
      MoneyMaskedTextController(precision: 0, decimalSeparator: '');
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productImageController = TextEditingController();
  bool _productActive = true;
  String _productCategory = 'Eletrônicos';
  bool _productOnSale = false;
  double _discountValue = 0.0;

  bool _isValidQuantity(String quantity) {
    return int.tryParse(quantity) != null && int.parse(quantity) > 0;
  }

  void _cadastraProduto() {
    if (_productNameController.text.isEmpty) {
      _showSnackbar('Nome do produto é obrigatório!');
      return;
    }
    if (_productPurchasePriceController.text.isEmpty) {
      _showSnackbar('Preço de compra inválido!');
      return;
    }
    if (_productSalePriceController.text.isEmpty) {
      _showSnackbar('Preço venda inválido!');
      return;
    }
    if (_productQuantityController.text.isEmpty ||
        !_isValidQuantity(_productQuantityController.text)) {
      _showSnackbar('Quantidade inválida!');
      return;
    }
    if (_productDescriptionController.text.isEmpty) {
      _showSnackbar('Descrição do produto é obrigatória!');
      return;
    }

    final newProduct = ProdutoModel(
      nome: _productNameController.text,
      precoCompra: _productPurchasePriceController.numberValue ?? 0,
      precoVenda: _productSalePriceController.numberValue ?? 0,
      quantidade: _productQuantityController.numberValue?.toInt() ?? 0,
      descricao: _productDescriptionController.text,
      categoria: _productCategory,
      imagem: _productImageController.text,
      ativo: _productActive,
      emPromocao: _productOnSale,
      desconto: _discountValue,
    );

    Navigator.pop(context, newProduct);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Center(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product != null ? 'Editando Produto' : 'Cadastrando Produto',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: buildProductForm(),
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }

  Widget buildProductForm() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Informações do Produto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: _productNameController,
              labelText: 'Nome do produto',
              hintText: 'Informe o nome do produto',
              icon: const Icon(Icons.label),
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productPurchasePriceController,
              labelText: 'Preço de compra',
              hintText: 'Informe o preço de compra',
              icon: const Icon(Icons.attach_money),
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productSalePriceController,
              labelText: 'Preço de venda',
              hintText: 'Informe o preço de venda',
              icon: const Icon(Icons.money),
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productQuantityController,
              labelText: 'Quantidade em estoque',
              hintText: 'Informe a quantidade em estoque',
              icon: const Icon(Icons.inventory),
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productDescriptionController,
              labelText: 'Descrição',
              hintText: 'Informe a descrição do produto',
              maxLines: 5,
              icon: const Icon(Icons.description),
            ),
            const SizedBox(height: 12),
            InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Categoria',
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFB0BEC5)),
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.indigoAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _productCategory,
                  isExpanded: true,
                  items: ['Eletrônicos', 'Roupas', 'Calçados', 'Alimentos']
                      .map(
                        (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _productCategory = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productImageController,
              labelText: 'URL da imagem',
              hintText: 'Informe a imagem do produto',
              maxLines: 1,
              icon: const Icon(Icons.image),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Produto Ativo'),
              value: _productActive,
              onChanged: (value) {
                setState(() {
                  _productActive = value!;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Produto em Promoção'),
              value: _productOnSale,
              onChanged: (value) {
                setState(() {
                  _productOnSale = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Desconto (%)'),
                Slider(
                  value: _discountValue,
                  min: 0,
                  max: 90,
                  divisions: 20,
                  label: '${_discountValue.round()}%',
                  onChanged: (value) {
                    setState(() {
                      _discountValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _cadastraProduto,
              icon: const Icon(Icons.save, color: Colors.white),
              label: Text(
                widget.product == null
                    ? 'Cadastrar Produto'
                    : 'Salvar Alterações',
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, null),
              icon: const Icon(Icons.cancel, color: Colors.white),
              label: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
