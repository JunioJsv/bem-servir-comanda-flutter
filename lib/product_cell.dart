import 'package:bem_servir_comanda/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  int amount;

  Product(this.name, this.price, this.amount);
}

void createProduct(BuildContext buildContext, Function(Product) callBack) {
  String name;
  double price;
  int amount;

  showDialog(
    context: buildContext,
    builder: (context) => Align(
      alignment: Alignment.topCenter,
      child: Card(
        margin: EdgeInsets.only(left: 48, right: 48),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Produto", filled: true),
                onChanged: (input) {
                  name = input;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Preço", filled: true),
                onChanged: (input) {
                  price = double.parse(input);
                },
              ),
              TextField(
                decoration:
                    InputDecoration(hintText: "Quantidade", filled: true),
                onChanged: (input) {
                  amount = int.parse(input);
                },
              ),
              FlatButton(
                onPressed: () {
                  if (name != null && price != null && amount != null) {
                    callBack(Product(name, price, amount));
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
      ),
    ),
  );
}

class ProductCell extends StatefulWidget {
  Product product;

  ProductCell({@required key, this.product}) : super(key: key);

  @override
  _ProductCellState createState() => _ProductCellState();
}

class _ProductCellState extends State<ProductCell> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Card(
        child: InkWell(
          onDoubleTap: () {
            setState(() {
              widget.product.amount++;
            });
          },
          onLongPress: () {
            setState(() {
              if (widget.product.amount > 1) widget.product.amount--;
            });
          },
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: Text(
              widget.product.amount.toString(),
              style: TextStyle(
                fontSize: 24,
                color: theme.accentColor,
              ),
            ),
          ),
        ),
      ),
      title: Text(widget.product.name),
      subtitle: Text("R\$${widget.product.price.toStringAsFixed(2)}"),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "R\$",
            style: TextStyle(fontSize: 16, color: theme.primaryColor),
          ),
          Text(
            (widget.product.price * widget.product.amount).toStringAsFixed(2),
            style: TextStyle(fontSize: 32, color: theme.primaryColor),
          )
        ],
      ),
    );
  }
}
