import 'package:app_cep_turma/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.amber),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}
