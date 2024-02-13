import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/calculator/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryAppBar extends StatelessWidget {
  const HistoryAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
        child: Column(
          children: [
            Spacer(),
            Row(
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
            const Expanded(
              child: Divider(
                color: BaseColors.headerText,
                thickness: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
