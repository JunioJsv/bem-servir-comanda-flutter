import 'package:bem_servir_comanda/main.dart';
import 'package:bem_servir_comanda/models/comanda_model.dart';
import 'package:bem_servir_comanda/views/product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comanda extends StatelessWidget {
  final ComandaModel model;

  Comanda({key, this.model}) : super(key: key);

  @override
  Widget build(bctx) =>
      ChangeNotifierProvider<ComandaModel>.value(
        value: model,
        child: Stack(
          children: <Widget>[
            Consumer<ComandaModel>(
              builder: (pctx, comanda, __) => ListView.separated(
                padding: EdgeInsets.only(bottom: 96),
                separatorBuilder: (_, __) => Divider(height: 1),
                itemCount: comanda.products.isNotEmpty
                    ? comanda.products.length + 1
                    : 1,
                itemBuilder: (_, index) => index < comanda.products.length
                    ? Dismissible(
                        key: UniqueKey(),
                        onDismissed: (_) => comanda.removeProduct(index),
                        background: Container(
                          color: Colors.grey[200],
                        ),
                        child: Product(
                          key: UniqueKey(),
                          model: comanda.products[index],
                        ),
                      )
                    : ExpansionTile(
                        key: UniqueKey(),
                        initiallyExpanded: comanda.infoExpanded,
                        onExpansionChanged: (value) => comanda.infoExpanded = value,
                        leading: Icon(Icons.person),
                        title: Text(comanda.client),
                        children: <Widget>[
                          CheckboxListTile(
                            title: Text('Compra afiançada'),
                            subtitle:
                                Text('Cobrar taxa de 15% sobre o valor total'),
                            value: comanda.tax,
                            onChanged: (_) => comanda.changeTax(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "R\$",
                                style: TextStyle(
                                    fontSize: 16, color: theme.primaryColor),
                              ),
                              Text(
                                '${comanda.total.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 38, color: theme.primaryColor),
                              )
                            ],
                          ),
                          FlatButton.icon(
                            icon: Icon(Icons.share),
                            textColor: theme.accentColor,
                            label: Text('COMPARTILHAR'),
                            onPressed: () => comanda.shareComanda(pctx),
                          )
                        ],
                      ),
              ),
            ),
            Positioned(
              bottom: 32,
              right: 32,
              child: FloatingActionButton(
                  child: Icon(Icons.add_shopping_cart),
                  onPressed: () => this.model.createProduct(bctx)),
            ),
          ],
        ),
      );
}
