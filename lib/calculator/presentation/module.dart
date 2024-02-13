import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/calculator/presentation/widgets/calculator_full_view.dart';
import 'package:currency_exchange/calculator/presentation/widgets/calculator_split_history_view.dart';
import 'package:currency_exchange/calculator/presentation/widgets/calculator_split_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorModule extends StatefulWidget {
  const CalculatorModule({
    super.key,
    required this.calculatorWidth,
    required this.calculatorHeight,
  });

  final double calculatorWidth;
  final double calculatorHeight;

  @override
  State<CalculatorModule> createState() => _CalculatorModuleState();
}

class _CalculatorModuleState extends State<CalculatorModule> {
  final TextEditingController _expressionController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.calculatorWidth,
      height: widget.calculatorHeight,
      decoration: BoxDecoration(
        border: Border.all(color: BaseColors.headerText, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          if (state == LayoutState.both) {
            return CalculatorSplitView(
                expressionController: _expressionController,
                resultController: _resultController);
          }
          if (state == LayoutState.calculator) {
            return CalculatorFullView(
                expressionController: _expressionController,
                resultController: _resultController);
          }
          if (state == LayoutState.bothWithHistory) {
            return CalculatorSplitHistoryView(
                expressionController: _expressionController,
                resultController: _resultController);
          }
          if (state == LayoutState.calculatorWithHistory) {
            return CalculatorSplitHistoryView(
                expressionController: _expressionController,
                resultController: _resultController);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
