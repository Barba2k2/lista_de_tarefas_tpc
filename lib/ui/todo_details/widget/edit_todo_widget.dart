import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../domain/models/todo.dart';
import '../../../utils/result/result.dart';
import '../../commom/widgets/app_action_button.dart';
import '../../commom/widgets/app_status_switch.dart';
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
  bool _isSubmitting = false;
  bool _wasStatusUpdateOnly = false;

  late bool _isDone;

  @override
  void initState() {
    super.initState();

    _isDone = widget.todo.done;

    widget.todoDetailsViewModel.updateTodo.addListener(_onUpdateTodo);

    widget.todoDetailsViewModel.addListener(_onTodoChanged);
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _descriptionEC.dispose();
    widget.todoDetailsViewModel.updateTodo.removeListener(_onUpdateTodo);
    widget.todoDetailsViewModel.removeListener(_onTodoChanged);
    super.dispose();
  }

  void _onTodoChanged() {
    if (mounted) {
      if (widget.todoDetailsViewModel.todo.id == widget.todo.id) {
        setState(() {
          _isDone = widget.todoDetailsViewModel.todo.done;
        });
      }
    }
  }

  void _onUpdateTodo() {
    final command = widget.todoDetailsViewModel.updateTodo;
    if (command.running) {
      setState(() {
        _isSubmitting = true;
      });
    } else {
      setState(() {
        _isSubmitting = false;
      });

      if (command.completed) {
        if (command.result?.asOk.value != null) {
          setState(() {
            _isDone = command.result!.asOk.value.done;
          });
        }

        if (!_wasStatusUpdateOnly) {
          context.pop();
        } else {
          _wasStatusUpdateOnly = false;
        }

        _showSuccessSnackBar('Tarefa atualizada com sucesso');
      } else if (command.error) {
        _showErrorSnackBar('Ocorreu um erro ao atualizar a tarefa');
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Editar Tarefa',
            style: AppTextStyles.title.copyWith(
              color: AppColors.primary,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingS),
          Text(
            'Atualize os detalhes da sua tarefa',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimensions.spacingL),
          TextFormField(
            controller: _nameEC,
            decoration: const InputDecoration(
              labelText: 'Nome da Tarefa',
              prefixIcon: Icon(Icons.task_alt),
            ),
            style: AppTextStyles.inputText,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nome é obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(height: AppDimensions.spacingM),
          TextFormField(
            controller: _descriptionEC,
            decoration: const InputDecoration(
              labelText: 'Descrição (opcional)',
              prefixIcon: Icon(Icons.description),
            ),
            style: AppTextStyles.inputText,
            minLines: 3,
            maxLines: 5,
          ),
          const SizedBox(height: AppDimensions.spacingL),

          AppStatusSwitch(
            title: 'Status da tarefa',
            subtitle: _isDone ? 'Concluída' : 'Pendente',
            value: _isDone,
            onChanged: (value) {
              setState(() {
                _isDone = value;
              });

              _wasStatusUpdateOnly = true;

              widget.todoDetailsViewModel.updateTodo.execute(
                widget.todo.copyWith(done: value),
              );
            },
          ),

          const SizedBox(height: AppDimensions.spacingL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppActionButton.secondary(
                label: 'Cancelar',
                icon: Icons.close,
                onPressed: _isSubmitting ? () {} : () => context.pop(),
              ),
              AppActionButton(
                label: 'Salvar',
                icon: Icons.save,
                isLoading: _isSubmitting,
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _wasStatusUpdateOnly = false;

                    widget.todoDetailsViewModel.updateTodo.execute(
                      widget.todo.copyWith(
                        name: _nameEC.text,
                        description: _descriptionEC.text,
                        done: _isDone,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
