import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repository/todos/todos_repository.dart';
import '../data/repository/todos/todos_repository_dev.dart';
import '../domain/use_cases/todo_update_use_case.dart';

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider(
      create: (context) {
        return TodosRepositoryDev() as TodosRepository;
      },
    ),
    ..._sharedProviders,
  ];
}

List<SingleChildWidget> get _sharedProviders {
  return [
    Provider(
      create: (context) {
        return TodoUpdateUseCase(
          todosRepository: context.read(), //
        );
      },
    ),
  ];
}
