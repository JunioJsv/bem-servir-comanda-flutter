import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'product_cell.dart';

void createComandaCell(
    BuildContext buildContext, void Function(ComandaCell) callBack) {
  String client;

  showDialog(
    context: buildContext,
    builder: (context) => Dialog(
      child: ListView(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text(
              "Adicionar comanda",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_add),
              hintText: "Cliente",
              filled: true,
            ),
            onChanged: (input) {
              client = input;
            },
          ),
          FlatButton(
            onPressed: () {
              if (client.isNotEmpty) {
                callBack(
                  ComandaCell(
                    key: UniqueKey(),
                    client: client,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: Text(
              "Adicionar",
              style: TextStyle(color: theme.accentColor),
            ),
          ),
        ],
      ),
    ),
  );
}

class ComandaCell extends StatefulWidget {
  final String client;
  final List<Product> products = <Product>[];

  ComandaCell({@required key, @required this.client}) : super(key: key);

  @override
  _ComandaCellState createState() => _ComandaCellState();

  double get getTotal {
    var total = 0.0;
    products.forEach((product) {
      total += product.price * product.amount;
    });
    return total;
  }

  void shareComanda(bool tax) {
    var doc = "<CENTER><BIG>${client.toUpperCase()}";
    final total = getTotal;

    doc += "<BR>Data : ${DateFormat("dd/MM/yyyy").format(DateTime.now())}";
    products.forEach((Product product) {
      final name = product.name;
      final price = product.price;
      final amount = product.amount;

      doc +=
          "<BR><BOLD>$amount - $name - R\$${(amount * price).toStringAsFixed(2)}";
    });
    if (tax)
      doc +=
          "<BR>Taxa de 15% sobre o valor total - R\$${(total * 0.15).toStringAsFixed(2)}";
    doc +=
        "<BR><BOLD><MEDIUM3>TOTAL: R\$${tax ? (total + total * 0.15).toStringAsFixed(2) : total.toStringAsFixed(2)}<BR><BR>";
    native.invokeMethod("share", <String, String>{
      "doc": doc,
    });
  }
}

class _ComandaCellState extends State<ComandaCell> {
  bool _tax = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.only(bottom: 96),
          itemCount:
              widget.products.isNotEmpty ? widget.products.length + 1 : 1,
          itemBuilder: (BuildContext context, int index) =>
              index < widget.products.length
                  ? Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) => setState(() {
                        widget.products.removeAt(index);
                      }),
                      background: Container(
                        color: Colors.grey[200],
                      ),
                      child: ProductCell(
                        key: UniqueKey(),
                        product: widget.products[index],
                      ),
                    )
                  : ExpansionTile(
                      key: UniqueKey(),
                      leading: Icon(Icons.person),
                      title: Text(widget.client),
                      children: <Widget>[
                        StatefulBuilder(
                          key: UniqueKey(),
                          builder: (bctx, setState) => CheckboxListTile(
                            title: Text("Compra afiançada"),
                            subtitle:
                                Text("Cobrar taxa de 15% sobre o valor total"),
                            value: _tax,
                            onChanged: (value) => setState(() {
                              _tax = value;
                            }),
                          ),
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.share),
                          textColor: theme.accentColor,
                          label: Text("Compartilhar"),
                          onPressed: () => widget.shareComanda(_tax),
                        )
                      ],
                    ),
        ),
        Positioned(
          bottom: 32,
          right: 32,
          child: FloatingActionButton(
            child: Icon(Icons.add_shopping_cart),
            onPressed: () => createProduct(
              context,
              (Product product) => setState(() {
                widget.products.add(product);
              }),
            ),
          ),
        )
      ],
    );
  }
}
