import 'package:currency_exchange/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LayoutControlButtons extends StatelessWidget {
  const LayoutControlButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: BaseColors.layoutButton,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  print("First button");
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
          decoration: const BoxDecoration(
            color: BaseColors.layoutButton,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  print("Second button");
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
  }
}
