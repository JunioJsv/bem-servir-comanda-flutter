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
      child: FlatButton(
        onPressed: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      child: Text(
                        "x${widget.product.amount}",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey[600]
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
                          //style: TextStyle(),
                        ),
                        Text(
                          "R\$${widget.product.price.toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.grey[600])
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              "R\$${(widget.product.price*widget.product.amount).toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey[600]
              ),
            )
          ],
        ),
      ),
    );
  }
}
