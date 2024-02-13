import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/calculator/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentValuesInHistory extends StatefulWidget {
  final TextEditingController expressionController;
  final TextEditingController resultController;

  const CurrentValuesInHistory({
    super.key,
    required this.expressionController,
    required this.resultController,
  });

  @override
  State<CurrentValuesInHistory> createState() => _CurrentValuesInHistoryState();
}

class _CurrentValuesInHistoryState extends State<CurrentValuesInHistory> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current",
              style: GoogleFonts.candal(
                color: BaseColors.headerText,
                fontSize: 14,
              ),
            ),
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                return TextField(
                  controller: widget.expressionController,
                  onSubmitted: (value) {
                    context
                        .read<CalculatorBloc>()
                        .add(CalculatorCalculate(value));

                    // and send history reload event
                    context.read<CalculatorBloc>().add(CalculatorViewHistory());
                  },
                  textAlign: TextAlign.right,
                  inputFormatters: [
                    FilteringTextInputFormatter(
                      RegExp(
                          r'[0-9\+\-\*\/%\(\)]|(sin|cos|tan|asin|acos|atan|log|exp|sqrt|pow|pi|e)(\([0-9\+\-\*\/%]*\))?'),
                      allow: true,
                      replacementString: "",
                    ),
                  ],
                  style: GoogleFonts.candal(
                    color: BaseColors.headerText,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      hintText: "Expression",
                      hintStyle: GoogleFonts.candal(
                        color: BaseColors.headerText.withOpacity(0.5),
                        fontSize: 16,
                      ),
                      border: InputBorder.none),
                );
              },
            ),
            BlocListener<CalculatorBloc, CalculatorState>(
              listener: (context, state) {
                if (state is CalculatorCalculated) {
                  widget.resultController.text = "${state.result}";
                }
              },
              child: TextField(
                controller: widget.resultController,
                textAlign: TextAlign.right,
                enabled: false,
                readOnly: true,
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
          ],
        ),
      ),
    );
  }
}
