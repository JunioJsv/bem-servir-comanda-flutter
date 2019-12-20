import 'package:bem_servir_comanda/models/comanda_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductModel extends ChangeNotifier {
  final String name;
  final double price;
  int _amount;

  ProductModel(this.name, this.price, this._amount);

  int get amount => _amount;

  void increment(BuildContext context) {
    this
      .._amount += 1
      ..notifyListeners();
    Provider.of<ComandaModel>(context).notifyListeners();
  }

  void decrement(BuildContext context) {
    this
      .._amount -= 1
      ..notifyListeners();
    Provider.of<ComandaModel>(context).notifyListeners();
  }
}
