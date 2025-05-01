import 'package:flutter/material.dart';

import '../view_models/todo_details_view_model.dart';
import 'edit_todo_widget.dart';
import 'todo_description_widget.dart';
import 'todo_name_widget.dart';

class TodoDetailsScreen extends StatefulWidget {
  final TodoDetailsViewModel todoDetailsViewModel;

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
              child: Column(
                spacing: 8,
                children: [
                  TodoNameWidget(
                    todo: widget.todoDetailsViewModel.todo, //
                  ),
                  if (widget.todoDetailsViewModel.todo.description.isNotEmpty)
                    TodoDescriptionWidget(
                      todo: widget.todoDetailsViewModel.todo,
                    ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: EditTodoWidget(
                  todo: widget.todoDetailsViewModel.todo,
                  todoDetailsViewModel: widget.todoDetailsViewModel,
                ),
              );
            },
          );
        },
        child: ListenableBuilder(
          listenable: widget.todoDetailsViewModel.load,
          builder: (context, child) {
            if (widget.todoDetailsViewModel.load.running ||
                widget.todoDetailsViewModel.load.error) {
              return SizedBox.shrink();
            }
            return Icon(Icons.edit);
          },
        ),
      ),
    );
  }
}
