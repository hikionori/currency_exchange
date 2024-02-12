import 'package:currency_exchange/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatingNotesAppBar extends StatelessWidget {
  const CreatingNotesAppBar({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: SizedBox(
        height: 40,
        child: TextField(
          cursorColor: BaseColors.headerText,
          controller: titleController,
          style: GoogleFonts.candal(
              color: BaseColors.headerText,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'Title',
            hintStyle: GoogleFonts.candal(
                color: BaseColors.headerText.withOpacity(0.5),
                fontSize: 14,
                fontWeight: FontWeight.w300),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: BaseColors.headerText,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: BaseColors.headerText,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: BaseColors.headerText,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
