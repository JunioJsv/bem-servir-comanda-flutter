import 'package:bem_servir_comanda/main.dart';
import 'package:bem_servir_comanda/models/app_model.dart';
import 'package:bem_servir_comanda/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ComandaModel extends ChangeNotifier {
  final String client;
  final _products = List<ProductModel>();
  final taxValue = 0.15;
  var _tax = false;
  var infoExpanded = false;

  ComandaModel(this.client);

  bool get tax => _tax;
  List<ProductModel> get products => _products;

  double get total {
    var total = 0.0;
    _products.forEach((model) => total += model.price * model.amount);
    if (tax) total += total * taxValue;
    return total;
  }

  void changeTax() => this
    .._tax = !_tax
    ..notifyListeners();

  void shareComanda(BuildContext context) {
    var comanda = '<CENTER><BIG>${client.toUpperCase()}';
    comanda += '<BR>Data : ${DateFormat("dd/MM/yyyy").format(DateTime.now())}';
    products.forEach((product) {
      final name = product.name;
      final price = product.price;
      final amount = product.amount;

      comanda +=
          '<BR><BOLD>$amount - $name - R\$${(amount * price).toStringAsFixed(2)}';
    });
    if (tax) comanda += '<BR>[!] Taxa de 15% sobre o valor total';
    comanda += '<BR><BOLD><MEDIUM3>TOTAL: R\$${total.toStringAsFixed(2)}<BR><BR>';
    Provider.of<AppModel>(context)
        .native
        .invokeMethod('share', <String, String>{
      'doc': comanda,
    });
  }

  void createProduct(BuildContext context) {
    var name, price, amount;

    showDialog(
      context: context,
      builder: (bctx) => AlertDialog(
        title: Text('Criar produto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.shopping_cart),
                hintText: 'Produto',
                filled: true,
              ),
              onChanged: (input) => name = input,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_money),
                hintText: 'Preço',
                filled: true,
              ),
              onChanged: (input) => price = double.parse(input),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.filter_9_plus),
                hintText: 'Quantidade',
                filled: true,
              ),
              onChanged: (input) => amount = int.parse(input),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (name != null && price != null && amount != null) {
                this
                  .._products.add(ProductModel(name, price, amount))
                  ..notifyListeners();
                Navigator.pop(bctx);
              }
            },
            child: Text(
              'ADICIONAR',
              style: TextStyle(color: theme.accentColor),
            ),
          ),
        ],
      ),
    );
  }

  void removeProduct(int index) => this
    .._products.removeAt(index)
    ..notifyListeners();
}
