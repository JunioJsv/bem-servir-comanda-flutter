import 'package:bem_servir_comanda/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product extends StatelessWidget {
  final ProductModel model;

  Product({key, this.model}) : super(key: key);

  @override
  Widget build(__) => ChangeNotifierProvider<ProductModel>.value(
        value: model,
        child: Consumer<ProductModel>(
          builder: (pctx, product, __) => ListTile(
            leading: Card(
              child: InkWell(
                onDoubleTap: () => product.increment(pctx),
                onLongPress: () {
                  if(product.amount > 1)
                    product.decrement(pctx);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  child: Text(
                    '${product.amount}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(pctx).accentColor,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(product.name),
            subtitle: Text('R\$${product.price.toStringAsFixed(2)}'),
            trailing: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "R\$",
                  style: TextStyle(fontSize: 16, color: Theme.of(pctx).primaryColor),
                ),
                Text(
                  '${(product.price * product.amount).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 32, color: Theme.of(pctx).primaryColor),
                )
              ],
            ),
          ),
        ),
      );
}
