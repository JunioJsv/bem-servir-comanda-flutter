import 'package:bem_servir_comanda/models/comanda_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppModel extends ChangeNotifier {
  final String title;
  final _comandas = List<ComandaModel>();
  final native = MethodChannel('main_channel');
  int forceTabTo = 0;

  AppModel(this.title);

  List<ComandaModel> get comandas => _comandas;

  void newComanda(BuildContext context) {
    String client;
    showDialog(
      context: context,
      builder: (bctx) => AlertDialog(
        title: Text('Criar comanda'),
        content: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_add),
            hintText: "Cliente",
            filled: true,
          ),
          onChanged: (input) => client = input,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (client.isNotEmpty) {
                forceTabTo = _comandas.length;
                this
                  .._comandas.add(ComandaModel(client))
                  ..notifyListeners();
                Navigator.pop(bctx);
              }
            },
            child: Text('CRIAR'),
          ),
        ],
      ),
    );
  }

  void deleteComanda(BuildContext context, int index) => showDialog(
        context: context,
        builder: (bctx) => AlertDialog(
          title: Text(
            'Excluir ${_comandas[index].client}',
          ),
          content: Text(
            'Você realmente quer excluir essa comanda?',
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(bctx),
              child: Text('NÃO'),
            ),
            FlatButton(
              onPressed: () {
                forceTabTo = index < _comandas.length - 1 ? index : index - 1;
                this
                  .._comandas.removeAt(index)
                  ..notifyListeners();
                Navigator.pop(bctx);
              },
              child: Text('SIM'),
            ),
          ],
        ),
      );
}
