import 'package:currency_exchange/app/constants.dart';
import 'package:currency_exchange/calculator/models/calculation_model.dart';
import 'package:isar/isar.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorService {
  final Isar isar = getIt.get<Isar>();

  double _calculateExpression(String expression) {
    try {
      Expression exp = Parser().parse(expression);
      return exp.evaluate(EvaluationType.REAL, ContextModel());
    } catch (e) {
      rethrow;
    }
  }

  // Functions for work with database and calculations
  // add new calculation to database
  Future<double> calculate(String expression) async {
    try {
      double result = _calculateExpression(expression);
      // add new calculation to database
      await isar.writeTxn(() async {
        final calculation = Calculation()
          ..expression = expression
          ..result = result.toString()
          ..createdAt = DateTime.now();
        await isar.calculations.put(calculation);
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }

  // get all calculations from database, sort by createdAt, like history
  // return list of calculations
  Future<List<Calculation>> getCalculations() async {
    try {
      final result =
          await isar.calculations.where().sortByCreatedAt().findAll();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  // clean calculations history
  Future<void> clearHistory() async {
    try {
      await isar.writeTxn(() async {
        await isar.calculations.clear();
      });
    } catch (e) {
      rethrow;
    }
  }
}
