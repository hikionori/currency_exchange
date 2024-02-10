import 'package:currency_exchange/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConvertButton extends StatelessWidget {
  final VoidCallback onTap;

  const ConvertButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 167,
        height: 50,
        decoration: BoxDecoration(
          color: BaseColors.button,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: BaseColors.textFieldBorder,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            "Convert",
            style: GoogleFonts.candal(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: BaseColors.layoutButtonText,
            ),
          ),
        ),
      ),
    );
  }
}