import 'dart:async';

import 'package:currency_exchange/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_exchange/currency_converter/presentation/widgets/convert_button.dart';
import 'package:currency_exchange/currency_converter/presentation/widgets/currency_input_field.dart';
import 'package:currency_exchange/currency_converter/presentation/widgets/layout_control_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverterModule extends StatefulWidget {
  const CurrencyConverterModule({super.key});

  @override
  State<CurrencyConverterModule> createState() =>
      _CurrencyConverterModuleState();
}

class _CurrencyConverterModuleState extends State<CurrencyConverterModule> {
  StreamSubscription? _subscription;

  final List<String> _currencies = [];

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  final TextEditingController _fromCurrencyController =
      TextEditingController(text: 'usd');
  final TextEditingController _toCurrencyController =
      TextEditingController(text: 'uah');

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CurrencyBloc>(context).add(FetchCurrencies());
    // now read the bloc and place state from CurrenciesLoaded to the _currencies list
    _subscription =
        BlocProvider.of<CurrencyBloc>(context).stream.listen((state) {
      if (state is CurrenciesLoaded) {
        setState(() {
          _currencies.clear();
          _currencies.addAll(state.currencies.keys);
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 410,
      height: 212,
      child: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyConverted) {
            if (_fromController.text.isNotEmpty) {
              _toController.text =
                  state.currencyConvertingModel.result.toString();
            }
            // change state to initial
            context.read<CurrencyBloc>().add(WaitActions());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const LayoutControlButtons(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            final String from = _fromCurrencyController.text;
                            final String to = _toCurrencyController.text;
                            _fromCurrencyController.text = to;
                            _toCurrencyController.text = from;

                            final String fromValue = _fromController.text;
                            _fromController.text = _toController.text;
                            _toController.text = fromValue;
                          });
                        },
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        icon: const Icon(
                          Icons.swap_vert,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 14),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _toController.clear();
                            _fromController.clear();
                          });
                        },
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        icon: const Icon(
                          Icons.clear,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CurrencyInputField(
                        controller: _fromController,
                        values: _currencies,
                        initialValue: _fromCurrencyController,
                      ),
                      const SizedBox(height: 14),
                      CurrencyInputField(
                        controller: _toController,
                        values: _currencies,
                        initialValue: _toCurrencyController,
                      ),
                    ],
                  ),
                ],
              ),
              ConvertButton(
                onTap: () {
                  context.read<CurrencyBloc>().add(
                        ConvertCurrency(
                            from: _fromCurrencyController.text,
                            to: _toCurrencyController.text,
                            amount: double.parse(_fromController.text)),
                      );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
