import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'comanda_cell.dart';

ThemeData theme = ThemeData(
  primaryColor: Colors.green,
  accentColor: Colors.pinkAccent
);
String title = "Comanda";
List<ComandaCell> comandas = new List<ComandaCell>();
int currentComanda = 0;


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: theme,
    home: Comanda(),
  ));
}

class Comanda extends StatefulWidget {
  @override
  _ComandaState createState() => _ComandaState();
}

class _ComandaState extends State<Comanda> {

  String clientBuffer;

  @override
  Widget build(BuildContext context) {
    title = comandas.length > 0 ? comandas[currentComanda].client : "Comanda";

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return Align(
                  alignment: Alignment.topCenter,
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
                            onChanged: (String value) {
                                clientBuffer = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Cliente",
                                filled: true
                            ),
                          ),
                          FlatButton(
                            textColor: theme.accentColor,
                            child: Text("Adicionar"),
                            onPressed: () {
                              if(clientBuffer != null && clientBuffer.isNotEmpty) {
                                setState(() {
                                  comandas.add(ComandaCell(
                                    key: UniqueKey(),
                                    client: clientBuffer,
                                  ));
                                  clientBuffer = null;
                                  currentComanda = comandas.length - 1;
                                  Navigator.pop(context);
                                });
                              }
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }),
          IconButton(icon: Icon(Icons.remove), onPressed: comandas.length > 0 ? (){
            setState(() {
              comandas.remove(comandas[currentComanda]);
              if(currentComanda > 0) currentComanda = comandas.length - 1 < currentComanda ? currentComanda - 1 : currentComanda;
            });
          } : null)
        ],
      ),
      body: comandas.length > 0 ? Stack(
        children: <Widget>[
          PageView(
            key: UniqueKey(),
            controller: PageController(
              initialPage: currentComanda,
            ),
            children: comandas,
            onPageChanged: (int page){
              setState(() {
                currentComanda = page;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 24,
            child: DotsIndicator(
              dotsCount: comandas.length,
              position: currentComanda,
              decorator: DotsDecorator(
                activeColor: theme.accentColor
              ),
            ),
          )
        ],
      ) : Center(
        child: Text(
          "Nenhuma comanda",
          style: TextStyle(
            fontSize: 38,
            color: Colors.grey[600]
          ),
        ),
      )
    );
  }
}


