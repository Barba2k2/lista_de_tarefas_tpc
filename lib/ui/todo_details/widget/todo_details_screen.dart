import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../commom/widgets/app_action_button.dart';
import '../../commom/widgets/app_animated_container.dart';
import '../../commom/widgets/app_empty_state_widget.dart';
import '../../commom/widgets/app_error_widget.dart';
import '../../commom/widgets/app_info_container.dart';
import '../../commom/widgets/app_loading_widget.dart';
import '../../commom/widgets/app_status_badge.dart';
import '../view_models/todo_details_view_model.dart';
import 'edit_todo_widget.dart';

class TodoDetailsScreen extends StatefulWidget {
  final TodoDetailsViewModel todoDetailsViewModel;

  const TodoDetailsScreen({super.key, required this.todoDetailsViewModel});

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final GlobalKey<AppAnimatedContainerState> _animationKey = GlobalKey();

  void _playAnimations() {
    _animationKey.currentState?.playAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
        elevation: AppDimensions.elevationM,
      ),
      body: ListenableBuilder(
        listenable: widget.todoDetailsViewModel.load,
        builder: (context, child) {
          if (widget.todoDetailsViewModel.load.running) {
            return const AppLoadingWidget(
              message: 'Carregando detalhes da tarefa...',
            );
          }

          if (widget.todoDetailsViewModel.load.error) {
            return AppErrorWidget(
              message: 'Ocorreu um erro ao carregar a tarefa',
              onRetry: () {
                widget.todoDetailsViewModel.load.execute(
                  widget.todoDetailsViewModel.todo.id,
                );
              },
            );
          }

          if (!widget.todoDetailsViewModel.isLoaded) {
            return const AppLoadingWidget(
              message: 'Aguardando carregamento dos dados...',
            );
          }

          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _playAnimations(),
          );

          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.todoDetailsViewModel,
          builder: (context, child) {
            final todo = widget.todoDetailsViewModel.todo;

            if (todo.id.isEmpty) {
              return const AppEmptyStateWidget(
                title: 'Tarefa não encontrada',
                subtitle: 'A tarefa solicitada não existe ou foi removida',
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppAnimatedContainer(
                      key: _animationKey,
                      autoPlay: false,
                      child: AppStatusBadge(
                        label: todo.done ? 'Concluída' : 'Pendente',
                        isActive: todo.done,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.spacingL),

                    AppAnimatedContainer(
                      child: AppInfoContainer(
                        label: 'Nome',
                        content: todo.name,
                        borderColor:
                            todo.done ? AppColors.success : AppColors.primary,
                        lineThrough: todo.done,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.spacingL),

                    if (todo.description.isNotEmpty) ...[
                      AppAnimatedContainer(
                        child: AppInfoContainer(
                          label: 'Descrição',
                          content: todo.description,
                          borderColor: AppColors.backgroundDark,
                          contentStyle: AppTextStyles.body,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.spacingL),
                    ],

                    AppAnimatedContainer(
                      child: SizedBox(
                        width: double.infinity,
                        child:
                            todo.done
                                ? AppActionButton.warning(
                                  label: 'Marcar como pendente',
                                  icon: Icons.restart_alt,
                                  onPressed: () {
                                    widget.todoDetailsViewModel.updateTodo
                                        .execute(
                                          todo.copyWith(done: !todo.done),
                                        );
                                  },
                                )
                                : AppActionButton.success(
                                  label: 'Marcar como concluída',
                                  icon: Icons.check_circle,
                                  onPressed: () {
                                    widget.todoDetailsViewModel.updateTodo
                                        .execute(
                                          todo.copyWith(done: !todo.done),
                                        );
                                  },
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: widget.todoDetailsViewModel.load,
        builder: (context, child) {
          if (!widget.todoDetailsViewModel.isLoaded ||
              widget.todoDetailsViewModel.load.running ||
              widget.todoDetailsViewModel.load.error) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusL,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.spacingL),
                      child: EditTodoWidget(
                        todo: widget.todoDetailsViewModel.todo,
                        todoDetailsViewModel: widget.todoDetailsViewModel,
                      ),
                    ),
                  );
                },
              );
            },
            tooltip: 'Editar tarefa',
            child: const Icon(Icons.edit),
          );
        },
      ),
    );
  }
}
