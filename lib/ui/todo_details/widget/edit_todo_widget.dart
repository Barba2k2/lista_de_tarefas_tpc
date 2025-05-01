import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/todo.dart';
import '../view_models/todo_details_view_model.dart';

class EditTodoWidget extends StatefulWidget {
  final Todo todo;
  final TodoDetailsViewModel todoDetailsViewModel;

  const EditTodoWidget({
    super.key,
    required this.todo,
    required this.todoDetailsViewModel,
  });

  @override
  State<EditTodoWidget> createState() => _EditTodoWidgetState();
}

class _EditTodoWidgetState extends State<EditTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  late final _nameEC = TextEditingController(text: widget.todo.name);
  late final _descriptionEC = TextEditingController(
    text: widget.todo.description,
  );

  @override
  void initState() {
    widget.todoDetailsViewModel.updateTodo.addListener(_onUpdateTodo);
    super.initState();
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _descriptionEC.dispose();
    widget.todoDetailsViewModel.updateTodo.removeListener(_onUpdateTodo);
    super.dispose();
  }

  void _onUpdateTodo() {
    final command = widget.todoDetailsViewModel.updateTodo;
    if (command.running) {
      showDialog(
        context: context,
        barrierDismissible: false,
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
      context.pop();
      if (command.completed) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Tarefa atualizada com sucesso'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ocorreu um erro ao atualizar a tarefa'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            Text('Editar tarefa'),
            TextFormField(
              controller: _nameEC,
              decoration: InputDecoration(
                hintText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == '') {
                  return 'Nome é obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              minLines: 3,
              maxLines: null,
              controller: _descriptionEC,
              decoration: InputDecoration(
                hintText: 'Descrição',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        widget.todoDetailsViewModel.updateTodo.execute(
                          widget.todo.copyWith(
                            name: _nameEC.text,
                            description: _descriptionEC.text,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 110,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
