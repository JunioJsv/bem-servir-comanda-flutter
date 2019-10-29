import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'comanda_cell.dart';

var theme = ThemeData(
  primaryColor: Colors.blue,
  primaryColorDark: Colors.blue[600],
  accentColor: Colors.pinkAccent,
);
final native = MethodChannel("main_channel");
var _title = "Comanda";
var _comandas = <ComandaCell>[];
var _currentPage = 0;

void main() {
  runApp(
    MaterialApp(
      title: _title,
      theme: theme,
      home: Comanda(),
    ),
  );
}

class Comanda extends StatefulWidget {
  @override
  _ComandaState createState() => _ComandaState();
}

class _ComandaState extends State<Comanda> {
  String clientBuffer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                createComandaCell(context, (comandaCell) {
                  setState(() {
                    _comandas.add(comandaCell);
                    _currentPage = _comandas.length - 1;
                  });
                });
              }),
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: _comandas.isNotEmpty
                  ? () {
                      setState(() {
                        _comandas.remove(_comandas[_currentPage]);
                        if (_currentPage > 0)
                          _currentPage = _comandas.length - 1 < _currentPage
                              ? _currentPage - 1
                              : _currentPage;
                      });
                    }
                  : null),
        ],
      ),
      body: _comandas.isNotEmpty
          ? Stack(children: [
              PageView(
                key: UniqueKey(),
                controller: PageController(
                  initialPage: _currentPage,
                ),
                children: _comandas,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: DotsIndicator(
                    dotsCount: _comandas.length,
                    position: _currentPage,
                    decorator: DotsDecorator(activeColor: theme.accentColor),
                  ),
                ),
              ),
            ])
          : Center(
              child: Text(
                "Nenhuma comanda",
                style: TextStyle(fontSize: 38, color: Colors.grey[600]),
              ),
            ),
    );
  }
}
