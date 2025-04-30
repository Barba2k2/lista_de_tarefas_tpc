import 'package:flutter/material.dart';

import '../view_models/todos_details_view_model.dart';
import 'todo_name_widget.dart';

class TodoDetailsScreen extends StatefulWidget {
  final TodosDetailsViewModel todoDetailsViewModel;

  const TodoDetailsScreen({
    super.key,
    required this.todoDetailsViewModel, //
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
      body: ListenableBuilder(
        listenable: widget.todoDetailsViewModel,
        builder: (context, child) {
          if (widget.todoDetailsViewModel.load.running) {
            return Center(
              child: CircularProgressIndicator.adaptive(), //
            );
          }

          if (widget.todoDetailsViewModel.load.error) {
            return Center(
              child: Text('Ocorreu um erro ao carregar a tarefa'), //
            );
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.todoDetailsViewModel,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: TodoNameWidget(
                todo: widget.todoDetailsViewModel.todo, //
              ),
            );
          },
        ),
      ),
    );
  }
}
