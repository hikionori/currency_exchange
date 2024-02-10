import 'package:currency_exchange/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyInputField extends StatefulWidget {
  final TextEditingController controller;
  final List<String> values;
  final TextEditingController initialValue;
  CurrencyInputField(
      {super.key,
      required this.controller,
      required this.values,
      required this.initialValue});

  @override
  State<CurrencyInputField> createState() => _CurrencyInputFieldState();
}

class _CurrencyInputFieldState extends State<CurrencyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 50,
      decoration: BoxDecoration(
        color: BaseColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: BaseColors.textFieldBorder, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 18),
            decoration: BoxDecoration(
              color: BaseColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: BaseColors.textFieldBorder,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  width: 2),
            ),
            child: DropdownButton(
              value: widget.initialValue.text.toUpperCase(),
              items: widget.values.map((String currency) {
                return DropdownMenuItem(
                  value: currency.toUpperCase(),
                  child: Text(currency.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  widget.initialValue.text = value!.toLowerCase();
                });
              },
              style: GoogleFonts.candal(
                  color: BaseColors.headerText,
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
              borderRadius: BorderRadius.circular(20),
              iconSize: 30,
              underline: Container(),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: BaseColors.headerText,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: TextField(
              controller: widget.controller,
              cursorColor: BaseColors.headerText,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: InputDecoration(
                hintText: "Amount",
                hintStyle: GoogleFonts.candal(
                    color: BaseColors.placeholderText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                border: InputBorder.none,
              ),
              style: GoogleFonts.candal(
                  color: BaseColors.inputText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ))
        ],
      ),
    );
  }
}
