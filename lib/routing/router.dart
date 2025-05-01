import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../ui/todo/viewmodels/todo_view_model.dart';
import '../ui/todo/widgtes/todo_screen.dart';
import '../ui/todo_details/view_models/todo_details_view_model.dart';
import '../ui/todo_details/widget/todo_details_screen.dart';
import 'routes.dart';

GoRouter routerConfig() {
  return GoRouter(
    initialLocation: Routes.todos,
    routes: [
      GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodoScreen(
            todoViewModel: TodoViewModel(
              todosRepository: context.read(),
              todoUpdateUseCase: context.read(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id'] ?? '';

              // Verificar se o ID é válido
              if (todoId.isEmpty) {
                return const Scaffold(
                  body: Center(
                    child: Text('ID de tarefa inválido'), //
                  ),
                );
              }

              final todoDetailsViewModel = TodoDetailsViewModel(
                todosRepository: context.read(),
                todoUpdateUseCase: context.read(),
              );

              // Executar o carregamento da tarefa
              WidgetsBinding.instance.addPostFrameCallback((_) {
                todoDetailsViewModel.load.execute(todoId);
              });

              return TodoDetailsScreen(
                todoDetailsViewModel: todoDetailsViewModel,
              );
            },
          ),
        ],
      ),
    ],
  );
}
