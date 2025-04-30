import 'package:flutter/material.dart';

import '../view_models/todos_details_view_model.dart';

class TodoDetailsScreen extends StatefulWidget {
  final String id;
  final TodosDetailsViewModel todoDetailsViewModel;

  const TodoDetailsScreen({
    super.key,
    required this.id,
    required this.todoDetailsViewModel,
  });

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listando detalhes da Tarefa'), //
      ),
      body: Center(
        child: Text('Detalhes da Tarefa: ${widget.id}'), //
      ),
    );
  }
}
