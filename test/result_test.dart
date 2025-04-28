import 'package:flutter_test/flutter_test.dart';
import 'package:lista_de_tarefas_tpc/core/result/result.dart';

void main() {
  group('Should test Ok Result', () {
    test('Should create a Ok Result', () {
      final result = Result.ok('Ok');

      expect(result.asOk.value, 'Ok');
    });

    test('Should create a Error Result', () {
      final result = Result.error(Exception('An error occurred'));

      expect(result.asError.error, isA<Exception>());
    });

    test('Should create a Ok Result with extension', () {
      final result = 'Ok'.ok();

      expect(result.asOk.value, 'Ok');
    });

    test('Should create a Error Result with extension', () {
      final result = Exception('An error occurred').error();

      expect(result.asError.error, isA<Exception>());
    });
  });
}
