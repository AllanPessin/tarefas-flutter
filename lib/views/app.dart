import 'package:flutter/material.dart';
import 'package:tarefas/views/edita.dart';
import 'package:tarefas/views/lista.dart';
import 'package:tarefas/views/nova.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Lista(),
      routes: {
        '/': (context) => Lista(),
        '/nova': (context) => NovaPage(),
        '/edita': (context) => EditaPage(),
      },
      initialRoute: '/',
    );
  }
}