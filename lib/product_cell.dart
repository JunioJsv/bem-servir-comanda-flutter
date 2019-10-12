import 'package:bem_servir_comanda/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product {
  String product;
  double price;
  int amount;
  Product(this.product, this.price, this.amount);
}

class ProductCell extends StatefulWidget {
  Product product;

  ProductCell({@required key, this.product}) : super(key: key);

  @override
  _ProductCellState createState() => new _ProductCellState();
}

class _ProductCellState extends State<ProductCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Card(
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
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.product.amount}",
                        style:
                            TextStyle(fontSize: 24, color: theme.accentColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.product.product,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text("R\$${widget.product.price.toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.grey[600]))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "R\$",
                  style: TextStyle(fontSize: 16, color: theme.primaryColor),
                ),
                Text(
                  "${(widget.product.price * widget.product.amount).toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 32, color: theme.primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
