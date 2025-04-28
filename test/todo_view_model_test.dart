import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas_tpc/ui/todo/viewmodels/todo_view_model.dart';

void main() {
  group('Should test TodoVieModel', () {
    test('Verifying viewModel initialState', () {
      final TodoViewModel todoViewModel = TodoViewModel();

      expect(todoViewModel.todos, isEmpty);
    });

    test('Should add Todo', () async {
      final TodoViewModel todoViewModel = TodoViewModel();

      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('New Todo');

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.name, contains('New Todo'));

      expect(todoViewModel.todos.first.id, isNotNull);
    });

    test('Should remove Todo', () async {
      final TodoViewModel todoViewModel = TodoViewModel();

      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('New Todo');

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.name, contains('New Todo'));

      expect(todoViewModel.todos.first.id, isNotNull);

      await todoViewModel.deleteTodo.execute(todoViewModel.todos.first);

      expect(todoViewModel.todos, isEmpty);
    });
  });
}
