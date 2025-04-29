import 'package:flutter/material.dart';

import '../viewmodels/todo_view_model.dart';
import 'add_todo_widget.dart';
import 'todo_list.dart';

class TodoScreen extends StatelessWidget {
  final TodoViewModel todoViewModel;

  const TodoScreen({
    super.key,
    required this.todoViewModel, //
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'), //
      ),
      body: ListenableBuilder(
        listenable: todoViewModel.load,
        builder: (context, child) {
          if (todoViewModel.load.running) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (todoViewModel.load.error) {
            return Center(child: Text('An error ocurred on load todos... =('));
          }

          return child!;
        },

        child: ListenableBuilder(
          listenable: todoViewModel,
          builder: (context, child) {
            return TodoList(todos: todoViewModel.todos);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoWidget(
                todoViewModel: todoViewModel, //
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
