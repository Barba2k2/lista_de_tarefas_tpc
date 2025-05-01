import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';
import '../viewmodels/todo_view_model.dart';

class AddTodoWidget extends StatefulWidget {
  final TodoViewModel todoViewModel;

  const AddTodoWidget({
    super.key,
    required this.todoViewModel,
  });

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _todoNameEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    widget.todoViewModel.addTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.todoViewModel.addTodo.running) {
      setState(() {
        _isSubmitting = true;
      });
    } else {
      setState(() {
        _isSubmitting = false;
      });

      if (widget.todoViewModel.addTodo.completed) {
        Navigator.of(context).pop();
        _showSuccessSnackBar('Tarefa adicionada com sucesso!');
      }

      if (widget.todoViewModel.addTodo.error) {
        _showErrorSnackBar('Ocorreu um erro ao adicionar a tarefa!');
      }
    }
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
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(color: AppColors.textLight),
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
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(color: AppColors.textLight),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _todoNameEC.dispose();
    _descriptionEC.dispose();
    widget.todoViewModel.addTodo.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
      ),
      elevation: AppDimensions.elevationM,
      backgroundColor: AppColors.background,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nova Tarefa',
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primary,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingS),
                Text(
                  'Adicione uma nova tarefa à sua lista',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingL),
                TextFormField(
                  controller: _todoNameEC,
                  decoration: const InputDecoration(
                    labelText: 'Nome da Tarefa',
                    hintText: 'Ex: Comprar leite',
                    prefixIcon: Icon(Icons.task_alt),
                  ),
                  style: AppTextStyles.inputText,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, preencha o nome da tarefa';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.spacingM),
                TextFormField(
                  controller: _descriptionEC,
                  decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                    hintText: 'Ex: Comprar leite no supermercado perto de casa',
                    prefixIcon: Icon(Icons.description),
                  ),
                  style: AppTextStyles.inputText,
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: AppDimensions.spacingXL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: _isSubmitting
                          ? null
                          : () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('Cancelar'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isSubmitting
                          ? null
                          : () {
                        if (_formKey.currentState?.validate() == true) {
                          widget.todoViewModel.addTodo.execute(
                            (
                            _todoNameEC.text,
                            _descriptionEC.text,
                            false,
                            ),
                          );
                        }
                      },
                      icon: _isSubmitting
                          ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                          : const Icon(Icons.add),
                      label: Text(_isSubmitting ? 'Adicionando...' : 'Adicionar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}