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
  });
}
