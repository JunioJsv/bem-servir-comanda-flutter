import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'comanda_cell.dart';

final theme = ThemeData(
  primaryColor: Colors.blue,
  primaryColorDark: Colors.blue[600],
  accentColor: Colors.pinkAccent,
);
final native = MethodChannel("main_channel");
final _title = "Comanda";
final _comandas = <ComandaCell>[];

main() => runApp(
      MaterialApp(
        title: _title,
        theme: theme,
        home: Comanda(),
      ),
    );

class Comanda extends StatefulWidget {
  @override
  _ComandaState createState() => _ComandaState();
}

class _ComandaState extends State<Comanda> with TickerProviderStateMixin {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = TabController(
        vsync: this, length: _comandas.length, initialIndex: initialIndex);
    final tabs = TabBar(
      tabs: List.generate(
        _comandas.length,
        (index) => Container(
          height: 48,
          alignment: Alignment.center,
          child: Text(_comandas[index].client.toUpperCase()),
        ),
      ),
      controller: controller,
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => createComandaCell(
              context,
              (comandaCell) => setState(() {
                _comandas.add(comandaCell);
                initialIndex = _comandas.length - 1;
              }),
            ),
          ),
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: _comandas.isNotEmpty
                  ? () {
                      showDialog(
                        context: context,
                        builder: (bctx) => AlertDialog(
                          title: Text(
                              "Excluir ${_comandas[controller.index].client}"),
                          content:
                              Text("Você realmente quer excluir essa comanda?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.pop(bctx),
                              child: Text("Não"),
                            ),
                            FlatButton(
                              onPressed: () => setState(() {
                                _comandas.removeAt(controller.index);
                                if (controller.index == 0 ||
                                    controller.index < _comandas.length - 1)
                                  initialIndex = controller.index;
                                else
                                  initialIndex = _comandas.length - 1;
                                Navigator.pop(bctx);
                              }),
                              child: Text("Sim"),
                            ),
                          ],
                        ),
                      );
                    }
                  : null),
        ],
        bottom: _comandas.isNotEmpty
            ? PreferredSize(
                preferredSize: tabs.preferredSize,
                child: tabs,
              )
            : null,
      ),
      body: _comandas.isNotEmpty
          ? TabBarView(
              key: UniqueKey(),
              controller: controller,
              children: _comandas,
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: theme.primaryColor,
                  ),
                  Text(
                    "Nenhuma comanda",
                    style: TextStyle(fontSize: 36, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
    );
  }
}
