import 'package:bem_servir_comanda/views/app_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: Colors.blue,
  primaryColorDark: Colors.blue[600],
  accentColor: Colors.pinkAccent,
);

main() => runApp(
      MaterialApp(
        title: "Comanda",
        theme: theme,
        home: App(),
      ),
    );