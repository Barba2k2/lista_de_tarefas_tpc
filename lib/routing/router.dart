import 'package:go_router/go_router.dart';

import '../data/repository/todos/todos_repository_remote.dart';
import '../data/services/api_client.dart';
import '../ui/todo/viewmodels/todo_view_model.dart';
import '../ui/todo/widgtes/todo_screen.dart';
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
              todosRepository: TodosRepositoryRemote(
                apiClient: ApiClient(
                  host: "192.168.0.238", //
                ),
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id'] ?? '';

              return TodoDetailsScreen(id: todoId);
            }, //
          ),
        ],
      ),
    ],
  );
}
