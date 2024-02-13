import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/calculator/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorSplitView extends StatelessWidget {
  const CalculatorSplitView({
    super.key,
    required TextEditingController expressionController,
    required TextEditingController resultController,
  }) : _expressionController = expressionController, _resultController = resultController;

  final TextEditingController _expressionController;
  final TextEditingController _resultController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // text field for expression
        // text field for result
        // button for view history
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: BaseColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _expressionController,
                  onSubmitted: (value) {
                    context
                        .read<CalculatorBloc>()
                        .add(CalculatorCalculate(value));
                    // then get the result from the state
                  },
                  textAlign: TextAlign.right,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9\+\-\*\/]'))
                  ],
                  style: GoogleFonts.candal(
                    color: BaseColors.headerText,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      hintText: "Expression",
                      // change hint position
                      hintStyle: GoogleFonts.candal(
                          color: BaseColors.headerText.withOpacity(0.5),
                          fontSize: 16),
                      border: InputBorder.none),
                ),
                const SizedBox(height: 10),
                BlocListener<CalculatorBloc, CalculatorState>(
                  listener: (context, state) {
                    if (state is CalculatorCalculated) {
                      _resultController.text = "${state.result}";
                    }
                  },
                  child: TextField(
                    controller: _resultController,
                    textAlign: TextAlign.right,
                    enabled: false,
                    style: GoogleFonts.candal(
                      color: BaseColors.headerText.withOpacity(0.8),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "Result",
                      // change hint position
                      hintStyle: GoogleFonts.candal(
                        color: BaseColors.headerText.withOpacity(0.5),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: BaseColors.headerText,
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => {
                        BlocProvider.of<LayoutCubit>(context)
                            .toggleCalculatorHistory()
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: BaseColors.button,
                          border: Border.all(
                              color: BaseColors.headerText, width: 2),
                        ),
                        child: const Icon(
                          Icons.history,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
