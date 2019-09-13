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
  //final Key key;

  ProductCell({@required key, this.product}) : super(key: key);

  @override
  _ProductCellState createState() => new _ProductCellState(product.product, product.price, product.amount);
}

class _ProductCellState extends State<ProductCell> {
  String _product;
  double _price;
  int _amount;

  _ProductCellState(this._product, this._price, this._amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
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
                    elevation: 2,
                    child: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      child: Text(
                        _product[0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 32
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
                          _product,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          "R\$${_price.toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.grey[600])
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              "R\$${(_price*_amount).toStringAsFixed(2)}",
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
