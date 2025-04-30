import 'package:flutter/material.dart';

import '../viewmodels/todo_view_model.dart';

class AddTodoWidget extends StatefulWidget {
  final TodoViewModel todoViewModel;

  const AddTodoWidget({
    super.key,
    required this.todoViewModel, //
  });

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _todoEC = TextEditingController();

  @override
  void initState() {
    widget.todoViewModel.addTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.todoViewModel.addTodo.running) {
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
      if (widget.todoViewModel.addTodo.completed) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            content: Text('Tarefa adicionada com sucesso!'),
          ),
        );
      }
      if (widget.todoViewModel.addTodo.error) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 5),
            content: Text('Ocorreu um erro ao adicionar a tarefa!'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _todoEC.dispose();
    widget.todoViewModel.addTodo.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicHeight(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              Row(
                children: [
                  Text('Adicione novas tarefas'), //
                ],
              ),
              TextFormField(
                controller: _todoEC,
                decoration: InputDecoration(
                  hintText: 'Tarefa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim() == '') {
                    return 'Por favor, prrencha o campo de tarefa';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    widget.todoViewModel.addTodo.execute(
                      (_todoEC.text, "", false), //
                    );
                  }
                },
                child: const Text('Adicionar'), //
              ),
            ], //
          ),
        ),
      ),
    );
  }
}
