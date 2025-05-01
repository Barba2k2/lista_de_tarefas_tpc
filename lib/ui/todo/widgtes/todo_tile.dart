import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../routing/routes.dart';
import '../../../utils/typedefs/todos.dart';
import '../../../domain/models/todo.dart';
import '../viewmodels/todo_view_model.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final TodoViewModel todoViewModel;
  final OnDeleteTodo onDeleteTodo;

  const TodoTile({
    super.key,
    required this.todo,
    required this.todoViewModel,
    required this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppDimensions.spacingS,
          horizontal: AppDimensions.spacingM,
        ),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppDimensions.spacingL),
        child: const Icon(
          Icons.delete_sweep,
          color: AppColors.textLight,
          size: AppDimensions.iconSizeL,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDeleteTodo(todo);
      },
      child: GestureDetector(
        onTap: () {
          context.push(
            Routes.todoDetails(todo.id),
          );
        },
        child: Card(
          elevation: AppDimensions.elevationS,
          margin: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacingS,
            horizontal: AppDimensions.spacingM,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
              color: todo.done ? AppColors.taskCompleted : AppColors.background,
              border: Border.all(
                color: todo.done ? AppColors.success.withOpacity(0.3) : Colors.transparent,
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingM,
                vertical: AppDimensions.spacingS,
              ),
              leading: Checkbox(
                value: todo.done,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusS),
                ),
                activeColor: AppColors.success,
                onChanged: (value) {
                  todoViewModel.updateTodo.execute(
                    todo.copyWith(done: value!),
                  );
                },
              ),
              title: Text(
                todo.name,
                style: todo.done
                    ? AppTextStyles.taskTitleCompleted
                    : AppTextStyles.taskTitle,
              ),
              subtitle: todo.description.isNotEmpty
                  ? Text(
                todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.taskDescription,
              )
                  : null,
              trailing: IconButton(
                onPressed: () {
                  onDeleteTodo(todo);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                ),
                tooltip: 'Remover tarefa',
              ),
            ),
          ),
        ),
      ),
    );
  }
}