import 'package:isar/isar.dart';

part "calculation_model.g.dart";

@Collection()
class Calculation {
  Id? id = null;
  String? expression;
  String? result;
  DateTime? createdAt;
}
