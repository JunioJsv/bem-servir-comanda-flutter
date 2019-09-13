import 'package:flutter/material.dart';
import 'product_cell.dart';

class ComandaCell extends StatefulWidget {
  String client;
  List<Product> products = new List<Product>();

  ComandaCell({@required key, this.client}) : super(key: key);


  @override
  _ComandaCellState createState() => _ComandaCellState();
}

class _ComandaCellState extends State<ComandaCell> {

  String produtBuffer;
  double priceBuffer;
  int amountBuffer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: widget.products != null ? widget.products.length : 0,
          itemBuilder: (BuildContext context, int index){
            return ProductCell(
              key: UniqueKey(),
              product: widget.products[index],
            );
          },
        ),
        Positioned(
            bottom: 32,
            right: 32,
            child: FloatingActionButton(
              child: Icon(Icons.plus_one),
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Produto",
                                filled: true
                            ),
                            onChanged: (String value){
                              setState(() {
                                produtBuffer = value;
                              });
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Preço",
                                filled: true
                            ),
                            onChanged: (String value){
                              setState(() {
                                priceBuffer = double.parse(value);
                              });
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Quantidade",
                                filled: true
                            ),
                            onChanged: (String value){
                              setState(() {
                                amountBuffer = int.parse(value);
                              });
                            },
                          )
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Adicionar"),
                          onPressed: produtBuffer != null && priceBuffer != null && amountBuffer != null ? (){
                            setState(() {
                              widget.products.add(Product(produtBuffer, priceBuffer, amountBuffer));
                            });
                            produtBuffer = null;
                            priceBuffer = null;
                            amountBuffer = null;
                            Navigator.pop(context);
                          } : null,
                        )
                      ],
                    );
                  }
                );
              },
            )
        )
      ],
    );
  }
}