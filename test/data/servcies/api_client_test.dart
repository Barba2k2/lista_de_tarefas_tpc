import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas_tpc/data/services/api_client.dart';
import 'package:lista_de_tarefas_tpc/domain/models/todo.dart';
import 'package:lista_de_tarefas_tpc/utils/result/result.dart';

void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = ApiClient();
  });

  group("Should test [ApiClient]", () {
    test('Should return Result Ok when getTodos()', () async {
      final result = await apiClient.getTodos();

      expect(result.asOk.value, isA<List<Todo>>());
    });

    test('Should return Result Ok when postTodo()', () async {
      final todoToCreate = Todo(name: 'Todo created on TEST');

      final result = await apiClient.postTodo(todoToCreate);

      expect(result.asOk.value, isA<Todo>());
    });

    test('Should return Result Ok when deleteTodo()', () async {
      final todoToCreate = Todo(name: 'Todo created on TEST');

      final createdTodoResult = await apiClient.postTodo(todoToCreate);

      final result = await apiClient.deleteTodo(createdTodoResult.asOk.value);

      expect(result.asOk, isA<Result<void>>());
      
    });
  });
}
