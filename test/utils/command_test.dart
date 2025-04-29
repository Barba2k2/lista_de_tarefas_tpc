import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas_tpc/utils/command/command.dart';
import 'package:lista_de_tarefas_tpc/utils/result/result.dart';

void main() {
  group('Should test Command', () {
    test('Should test Command0 returns Ok', () async {
      final command0 = Command0<String>(getOkResult);

      expect(command0.completed, false);

      expect(command0.running, false);

      expect(command0.error, false);

      expect(command0.result, isNull);

      await command0.execute();

      expect(command0.error, false);

      expect(command0.running, false);

      expect(command0.result, isNotNull);

      expect(command0.result!.asOk.value, 'The operation has Success');
    });

    test('Should test Command0 returns Ok', () async {
      final command0 = Command0<bool>(getErrorResult);

      expect(command0.completed, false);

      expect(command0.running, false);

      expect(command0.error, false);

      expect(command0.result, isNull);

      await command0.execute();

      expect(command0.error, true);

      expect(command0.running, false);

      expect(command0.result, isNotNull);

      expect(command0.result!.asError.error, isA<Exception>());
    });
  });

  test('Should test Command1 Ok result', () async {
    final command1 = Command1<String, String>(getOkResult1);

    expect(command1.running, false);

    expect(command1.error, false);

    expect(command1.completed, false);

    expect(command1.result, isNull);

    await command1.execute('Input parameter');

    expect(command1.running, false);

    expect(command1.error, false);

    expect(command1.completed, true);

    expect(command1.result, isNotNull);

    expect(command1.result!.asOk.value, 'Input parameter');
  });

  test('Should test Command1 Error result', () async {
    final command1 = Command1<bool, String>(getErrorResult1);

    expect(command1.running, false);

    expect(command1.error, false);

    expect(command1.completed, false);

    expect(command1.result, isNull);

    await command1.execute('Input parameter');

    expect(command1.running, false);

    expect(command1.error, true);

    expect(command1.completed, false);

    expect(command1.result, isNotNull);

    expect(command1.result!.asError.error, isA<Error>());
  });
}

Future<Result<String>> getOkResult() async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.ok('The operation has Success');
}

Future<Result<bool>> getErrorResult() async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.error(Exception('An error has ocurried on generate state'));
}

Future<Result<String>> getOkResult1(String params) async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.ok(params);
}

Future<Result<bool>> getErrorResult1(String params) async {
  await Future.delayed(const Duration(seconds: 1));
  return Result.error(Exception('An error has ocurried on generate state with params: $params'));
}
