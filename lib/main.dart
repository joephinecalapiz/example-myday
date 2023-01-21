import 'package:example/homepage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TODO LIST',
    theme: ThemeData(
      primarySwatch: Colors.brown,
    ),
    home: const ListTodos(),
  ));
}
