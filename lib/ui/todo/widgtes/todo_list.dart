import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../domain/models/todo.dart';
import '../../../utils/typedefs/todos.dart';
import '../../commom/widgets/app_empty_state_widget.dart';
import '../viewmodels/todo_view_model.dart';
import 'todo_list_item.dart';

class TodoList extends StatelessWidget {
  final OnDeleteTodo onDeleteTodo;
  final TodoViewModel todoViewModel;
  final List<Todo> todos;

  const TodoList({
    super.key,
    required this.todos,
    required this.todoViewModel,
    required this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const AppEmptyStateWidget(
        title: 'Nenhuma tarefa encontrada',
        subtitle: 'Adicione novas tarefas tocando no botão abaixo',
        icon: Icons.task_alt,
      );
    }

    final completedTodos = todos.where((todo) => todo.done).toList();
    final pendingTodos = todos.where((todo) => !todo.done).toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Tarefas pendentes
        if (pendingTodos.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.spacingM,
                right: AppDimensions.spacingM,
                top: AppDimensions.spacingM,
                bottom: AppDimensions.spacingS,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: AppColors.warning,
                    size: AppDimensions.iconSizeM,
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  Text(
                    'Tarefas pendentes (${pendingTodos.length})',
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.primary,
                      fontSize: AppTextStyles.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TodoListItem(
                  todo: pendingTodos[index],
                  todoViewModel: todoViewModel,
                  onDeleteTodo: onDeleteTodo,
                );
              },
              childCount: pendingTodos.length, //
            ),
          ),
        ],

        // Tarefas concluídas
        if (completedTodos.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.spacingM,
                right: AppDimensions.spacingM,
                top: AppDimensions.spacingL,
                bottom: AppDimensions.spacingS,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.success,
                    size: AppDimensions.iconSizeM,
                  ),
                  const SizedBox(width: AppDimensions.spacingS),
                  Text(
                    'Tarefas concluídas (${completedTodos.length})',
                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.success,
                      fontSize: AppTextStyles.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TodoListItem(
                  todo: completedTodos[index],
                  todoViewModel: todoViewModel,
                  onDeleteTodo: onDeleteTodo,
                );
              },
              childCount: completedTodos.length, //
            ),
          ),
        ],

        const SliverToBoxAdapter(
          child: SizedBox(height: 80), //
        ),
      ],
    );
  }
}
