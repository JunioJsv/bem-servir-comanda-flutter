import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'comanda_cell.dart';

const TITLE = "Comanda";
List<ComandaCell> comandas = new List<ComandaCell>();
int currentComanda = 0;

void main() {
  runApp(MaterialApp(
    title: TITLE,
    home: Comanda(),
  ));
}

class Comanda extends StatefulWidget {
  @override
  _ComandaState createState() => _ComandaState();
}

class _ComandaState extends State<Comanda> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: comandas.length > 0 ? Drawer(
        child: ListView.builder(
          itemCount: comandas.length,
          itemBuilder: (BuildContext ctx, int index){
            return FlatButton(
              onPressed: (){
                setState(() {
                  currentComanda = index;
                });
              },
              child: Text(
                comandas[index].client,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600]
                ),
              )
            );
          },
        ),
      ) : null,
      appBar: AppBar(
        title: Text(TITLE),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            setState(() {
              comandas.add(ComandaCell(
                key: UniqueKey(),
                client: "Jeovane ${comandas.length}",
              ));
            });
          }),
          IconButton(icon: Icon(Icons.remove), onPressed: null,)
        ],
      ),
      body: comandas.length > 0 ? comandas[currentComanda] : Center(
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


