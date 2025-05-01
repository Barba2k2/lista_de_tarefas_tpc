import 'package:flutter/material.dart';

import 'routing/router.dart';

import 'main_dev.dart' as main_dev;

void main() => main_dev.main();

class ListaDeTarefasApp extends StatelessWidget {
  const ListaDeTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false, //
      ),
      routerConfig: routerConfig(),
    );
  }
}
