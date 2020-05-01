import 'package:bem_servir_comanda/views/app_view.dart';
import 'package:flutter/material.dart';

main() => runApp(
      MaterialApp(
        title: "Comanda",
        theme: ThemeData(
          primaryColor: Colors.blue,
          primaryColorDark: Colors.blue[600],
          accentColor: Colors.pinkAccent,
        ),
        home: App(),
      ),
    );
