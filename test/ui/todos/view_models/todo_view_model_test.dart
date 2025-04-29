import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas_tpc/data/repository/todos/todos_repository.dart';
import 'package:lista_de_tarefas_tpc/data/repository/todos/todos_repository_dev.dart';
import 'package:lista_de_tarefas_tpc/ui/todo/viewmodels/todo_view_model.dart';

void main() {
  group('Should test TodoVieModel', () {
    late TodoViewModel todoViewModel;
    late TodosRepository todosRepository;

    setUp(() {
      todosRepository = TodosRepositoryDev();

      todoViewModel = TodoViewModel(
        todosRepository: todosRepository, //
      );
    });

    test('Verifying viewModel initialState', () {
      expect(todoViewModel.todos, isEmpty);
    });

    test('Should add Todo', () async {
      expect(todoViewModel.todos, isEmpty);

      await todoViewModel.addTodo.execute('New Todo');

      expect(todoViewModel.todos, isNotEmpty);

      expect(todoViewModel.todos.first.name, contains('New Todo'));

      expect(todoViewModel.todos.first.id, isNotNull);
    });

    test('Should remove Todo', () async {
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
