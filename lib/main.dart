import 'package:app_cep_turma/views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.amber),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}
