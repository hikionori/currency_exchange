import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CurrencyConvertingModel extends Equatable {
  String from;
  String to;
  double amount;
  double result = 0;

  CurrencyConvertingModel(
      {required this.from,
      required this.to,
      required this.amount,
      required this.result});

  @override
  List<Object> get props => [from, to, amount, result];
}
