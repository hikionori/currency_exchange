import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/calculator/bloc/calculator_bloc.dart';
import 'package:currency_exchange/calculator/models/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: BaseColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => {
                    BlocProvider.of<LayoutCubit>(context)
                        .toggleCalculatorHistory()
                  },
                  child: Container(
                    child: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text("History",
                    style: GoogleFonts.candal(
                      color: BaseColors.headerText,
                      fontSize: 20,
                    )),
                const Spacer(),
                GestureDetector(
                  onTap: () => {
                    BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculatorClearHistory())
                  },
                  child: Container(
                    child: const Icon(
                      Icons.delete,
                      size: 25,
                      color: BaseColors.headerText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

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
                      if (state is CalculatorHistory) {
                        final history = state.calculations;
                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              history.length,
                              (index) {
                                final calculation = history[index];
                                return ListTile(
                                  title: Text(calculation.expression!),
                                  subtitle: Text(calculation.result.toString()),
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
                  const SizedBox(height: 10),
                  Text('Current value of controllers:'),
                  Text('Expression: ${widget._expressionController.text}'),
                  Text('Result: ${widget._resultController.text}'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
