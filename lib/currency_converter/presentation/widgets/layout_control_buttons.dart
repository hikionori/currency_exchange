import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LayoutControlButtons extends StatefulWidget {
  const LayoutControlButtons({
    super.key,
  });

  @override
  State<LayoutControlButtons> createState() => _LayoutControlButtonsState();
}

class _LayoutControlButtonsState extends State<LayoutControlButtons> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                // color: BaseColors.layoutButton,
                color: state == LayoutState.calculator ||
                        state == LayoutState.both ||
                        state == LayoutState.bothWithHistory ||
                        state == LayoutState.calculatorWithHistory
                    ? BaseColors.layoutButtonActive
                    : BaseColors.layoutButton,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: state == LayoutState.calculator ||
                        state == LayoutState.both ||
                        state == LayoutState.bothWithHistory ||
                        state == LayoutState.calculatorWithHistory
                    ? Border.all(
                        color: BaseColors.layoutButtonActiveBorder, width: 2)
                    : null,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<LayoutCubit>().toggleCalculator();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calculate,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text("Calculator",
                            style: GoogleFonts.candal(
                              fontSize: 12,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: state == LayoutState.notes ||
                        state == LayoutState.both ||
                        state == LayoutState.bothWithHistory
                    ? BaseColors.layoutButtonActive
                    : BaseColors.layoutButton,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: state == LayoutState.notes ||
                        state == LayoutState.both ||
                        state == LayoutState.bothWithHistory
                    ? Border.all(
                        color: BaseColors.layoutButtonActiveBorder, width: 2)
                    : null,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<LayoutCubit>().toggleNotes();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.notes,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text("Notes",
                            style: GoogleFonts.candal(
                              fontSize: 12,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
