import 'package:bem_servir_comanda/main.dart';
import 'package:flutter/cupertino.dart';
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
          padding: EdgeInsets.only(
            bottom: 84
          ),
          itemCount: widget.products != null ? widget.products.length : 0,
          itemBuilder: (BuildContext context, int index){
            return Dismissible(
              onDismissed: (direction) {
                setState(() {
                  widget.products.removeAt(index);
                });
              },
              background: Container(
                color: Colors.grey[200],
              ),
              key: UniqueKey(),
              child: ProductCell(
                key: UniqueKey(),
                product: widget.products[index],
              ),
            );
          },
        ),
        Positioned(
            bottom: 32,
            right: 32,
            child: FloatingActionButton(
              child: Icon(Icons.plus_one),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return Align(
                      alignment: Alignment.center,
                      child: Card(
                        margin: EdgeInsets.only(
                          left: 48,
                          right: 48
                        ),
                        elevation: 8.0,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Produto",
                                    filled: true
                                ),
                                onChanged: (String value){
                                  produtBuffer = value;
                                },
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Preço",
                                    filled: true
                                ),
                                onChanged: (String value){
                                  priceBuffer = double.parse(value);
                                },
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Quantidade",
                                    filled: true
                                ),
                                onChanged: (String value){
                                  amountBuffer = int.parse(value);
                                },
                              ),
                              FlatButton(
                                textColor: theme.accentColor,
                                  child: Text("Adicionar"),
                                  onPressed: () {
                                    if(produtBuffer != null && priceBuffer != null && amountBuffer != null) {
                                      setState(() {
                                        widget.products.add(Product(produtBuffer, priceBuffer, amountBuffer));
                                        produtBuffer = null;
                                        priceBuffer = null;
                                        amountBuffer = null;
                                        Navigator.pop(context);
                                      });
                                    }
                                  }
                              )
                            ],
                          ),
                        )
                      ),
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