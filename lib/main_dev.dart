import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'data/repository/todos/todos_repository.dart';
import 'data/repository/todos/todos_repository_dev.dart';
import 'data/services/storage_service.dart';
import 'domain/use_cases/todo_update_use_case.dart';
import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((log) {
    debugPrint('[${log.level}] - [${log.loggerName}] - ${log.message}');
    if (log.stackTrace != null) {
      debugPrint(log.stackTrace.toString());
    }
  });

  runApp(
    MultiProvider(
      providers: [
        // Serviço de armazenamento
        Provider<StorageService>(create: (_) => StorageService()),

        // Repositório de tarefas
        ChangeNotifierProvider<TodosRepository>(
          create:
              (context) => TodosRepositoryDev(
                storageService: context.read<StorageService>(),
              ),
        ),

        // Caso de uso para atualização de tarefas
        Provider<TodoUpdateUseCase>(
          create:
              (context) => TodoUpdateUseCase(
                todosRepository: context.read<TodosRepository>(),
              ),
        ),
      ],
      child: const ListaDeTarefasApp(),
    ),
  );
}
