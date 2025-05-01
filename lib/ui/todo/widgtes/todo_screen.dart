import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../commom/widgets/app_empty_state_widget.dart';
import '../../commom/widgets/app_error_widget.dart';
import '../../commom/widgets/app_loading_widget.dart';
import '../viewmodels/todo_view_model.dart';
import 'add_todo_widget.dart';
import 'todo_list.dart';

class TodoScreen extends StatefulWidget {
  final TodoViewModel todoViewModel;

  const TodoScreen({super.key, required this.todoViewModel});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    widget.todoViewModel.deleteTodo.addListener(_onDeleteResult);
    super.initState();
  }

  void _onDeleteResult() {
    if (widget.todoViewModel.deleteTodo.running) {
      _showLoadingDialog();
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (widget.todoViewModel.deleteTodo.completed) {
        _showSuccessSnackBar('Tarefa removida com sucesso!');
      } else {
        if (widget.todoViewModel.deleteTodo.error) {
          _showErrorSnackBar('Ocorreu um erro ao remover a tarefa');
        }
      }
    }
  }

  void _showLoadingDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
          ),
          content: const AppLoadingWidget(
            message: 'Removendo tarefa...', //
          ),
        );
      },
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppDimensions.spacingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        ),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: AppDimensions.spacingS),
            Expanded(
              child: Text(message), //
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppDimensions.spacingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        ),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: AppDimensions.spacingS),
            Expanded(
              child: Text(message), //
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.todoViewModel.deleteTodo.removeListener(_onDeleteResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        elevation: AppDimensions.elevationM,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppDimensions.spacingM,
            bottom: AppDimensions.spacingM,
          ),
          child: ListenableBuilder(
            listenable: widget.todoViewModel.load,
            builder: (context, child) {
              if (widget.todoViewModel.load.running) {
                return const AppLoadingWidget(
                  message: 'Carregando tarefas...', //
                );
              }

              if (widget.todoViewModel.load.error) {
                return AppErrorWidget(
                  message: 'Erro ao carregar tarefas',
                  onRetry: () {
                    widget.todoViewModel.load.execute();
                  },
                );
              }

              return child!;
            },
            child: ListenableBuilder(
              listenable: widget.todoViewModel,
              builder: (context, child) {
                final todos = widget.todoViewModel.todos;

                if (todos.isEmpty) {
                  return AppEmptyStateWidget(
                    title: 'Nenhuma tarefa encontrada',
                    subtitle:
                        'Crie sua primeira tarefa tocando no botão abaixo',
                    icon: Icons.task_alt,
                    onAction: _showAddTodoDialog,
                    actionLabel: 'Nova Tarefa',
                  );
                }

                return TodoList(
                  onDeleteTodo: (todo) {
                    widget.todoViewModel.deleteTodo.execute(todo);
                  },
                  todos: todos,
                  todoViewModel: widget.todoViewModel,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTodoDialog,
        icon: const Icon(Icons.add),
        label: const Text('Nova Tarefa'),
        elevation: AppDimensions.elevationM,
      ),
    );
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTodoWidget(
          todoViewModel: widget.todoViewModel, //
        );
      },
    );
  }
}
