import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/calculator/bloc/calculator_bloc.dart';
import 'package:currency_exchange/calculator/models/calculation_model.dart';
import 'package:currency_exchange/calculator/presentation/widgets/current_values_in_history.dart';
import 'package:currency_exchange/calculator/presentation/widgets/history_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorSplitHistoryView extends StatefulWidget {
  const CalculatorSplitHistoryView({
    super.key,
    required TextEditingController expressionController,
    required TextEditingController resultController,
  })  : _expressionController = expressionController,
        _resultController = resultController;

  final TextEditingController _expressionController;
  final TextEditingController _resultController;

  @override
  State<CalculatorSplitHistoryView> createState() =>
      _CalculatorSplitHistoryViewState();
}

class _CalculatorSplitHistoryViewState
    extends State<CalculatorSplitHistoryView> {
  List<Calculation> history = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // app bar for leaving history view
        const HistoryAppBar(),
        // view
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: BaseColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  BlocBuilder<CalculatorBloc, CalculatorState>(
                    builder: (context, state) {
                      if (state is CalculatorCalculated) {
                        // resend history view event
                        context
                            .read<CalculatorBloc>()
                            .add(CalculatorViewHistory());
                      }
                      if (state is CalculatorHistory) {
                        final history = state.calculations.reversed
                            .toList()
                            .take(context.read<LayoutCubit>().state ==
                                    LayoutState.calculatorWithHistory
                                ? 4
                                : 3)
                            .toList();

                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              history.length > 4 ? 4 : history.length,
                              (index) {
                                final calculation =
                                    history[history.length - index - 1];
                                return ListTile(
                                  titleTextStyle: GoogleFonts.candal(
                                    color: BaseColors.headerText,
                                    fontSize: 20,
                                  ),
                                  subtitleTextStyle: GoogleFonts.candal(
                                    color:
                                        BaseColors.headerText.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
                                  title: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(calculation.expression!)),
                                  subtitle: Align(
                                      alignment: Alignment.bottomRight,
                                      child:
                                          Text(calculation.result.toString())),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container(); // return an empty container when there's no history
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        // show current expression and result
        CurrentValuesInHistory(
            expressionController: widget._expressionController,
            resultController: widget._resultController),
      ],
    );
  }
}
