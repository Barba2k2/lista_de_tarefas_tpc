import 'package:flutter/material.dart';

import '../viewmodels/todo_view_model.dart';
import 'add_todo_widget.dart';
import 'todo_list.dart';

class TodoScreen extends StatefulWidget {
  final TodoViewModel todoViewModel;

  const TodoScreen({
    super.key,
    required this.todoViewModel, //
  });

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    widget.todoViewModel.deleteTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.todoViewModel.deleteTodo.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: IntrinsicHeight(
              child: Center(
                child: CircularProgressIndicator.adaptive(), //
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (widget.todoViewModel.deleteTodo.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            content: Text(
              'Tarefa removida com sucesso!', //
            ),
          ),
        );
      } else {
        if (widget.todoViewModel.deleteTodo.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 5),
              content: Text(
                'Ocorreu um erro ao remover a tarefa', //
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    widget.todoViewModel.deleteTodo.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'), //
      ),
      body: ListenableBuilder(
        listenable: widget.todoViewModel.load,
        builder: (context, child) {
          if (widget.todoViewModel.load.running) {
            return const Center(
              child: CircularProgressIndicator.adaptive(), //
            );
          }

          if (widget.todoViewModel.load.error) {
            return Center(
              child: Text('An error ocurred on load todos... =('), //
            );
          }

          return child!;
        },

        child: ListenableBuilder(
          listenable: widget.todoViewModel,
          builder: (context, child) {
            return TodoList(
              onDeleteTodo: (todo) {
                widget.todoViewModel.deleteTodo.execute(todo);
              },
              todos: widget.todoViewModel.todos,
              todoViewModel: widget.todoViewModel,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoWidget(
                todoViewModel: widget.todoViewModel, //
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
