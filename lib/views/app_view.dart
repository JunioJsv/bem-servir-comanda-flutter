import 'package:bem_servir_comanda/main.dart';
import 'package:bem_servir_comanda/models/app_model.dart';
import 'package:bem_servir_comanda/views/comanda_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(__) => ChangeNotifierProvider<AppModel>(
        create: (_) => AppModel("Comanda"),
        child: Consumer<AppModel>(
          builder: (pctx, app, __) { // [pctx] Provider<AppModel> Context
            return DefaultTabController(
              initialIndex: app.forceTabTo >= 0 ? app.forceTabTo : 0,
              key: UniqueKey(),
              length: app.comandas.length,
              child: Builder(
                builder: (bctx) => Scaffold( // [bctx] BuildContext with DefaultTabController
                  resizeToAvoidBottomPadding: false,
                  appBar: AppBar(
                    title: Text(app.title),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => app.newComanda(pctx),
                      ),
                      IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: app.comandas.isNotEmpty
                              ? () => app.deleteComanda(
                                    pctx,
                                    DefaultTabController.of(bctx).index,
                                  )
                              : null),
                    ],
                    bottom: app.comandas.isNotEmpty
                        ? TabBar(
                            key: UniqueKey(),
                            tabs: List.generate(
                              app.comandas.length,
                              (index) => Container(
                                height: 48,
                                alignment: Alignment.center,
                                child: Text(
                                    app.comandas[index].client.toUpperCase()),
                              ),
                            ),
                          )
                        : null,
                  ),
                  body: app.comandas.isNotEmpty
                      ? TabBarView(
                          key: UniqueKey(),
                          children: List.generate(
                            app.comandas.length,
                            (index) => Comanda(
                              key: UniqueKey(),
                              model: app.comandas[index],
                            ),
                          ),
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
                                'Nenhuma comanda',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      );
}
