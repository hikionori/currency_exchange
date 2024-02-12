import 'package:currency_exchange/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewEditField extends StatelessWidget {
  const ViewEditField({
    super.key,
    required this.titleController,
    required this.isEditing,
  });

  final TextEditingController titleController;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: BaseColors.headerText,
      controller: titleController,
      enabled: isEditing,
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
    );
  }
}
