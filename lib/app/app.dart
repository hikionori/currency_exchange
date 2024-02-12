import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_exchange/currency_converter/presentation/module.dart';
import 'package:currency_exchange/notes/bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NoteBloc>(
            create: (context) => NoteBloc(),
          ),
          BlocProvider<CurrencyBloc>(
            create: (context) => CurrencyBloc(),
          ),
          BlocProvider(create: (context) => LayoutCubit())
        ],
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.background,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CurrencyConverterModule(),
            BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (state == LayoutState.notes || state == LayoutState.both)
                  //   Container(
                  //     width: 200,
                  //     height: 200,
                  //     color: Colors.blue,
                  //     child: Center(
                  //       child: const Text("Notes"),
                  //     ),
                  //   ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: state == LayoutState.initial ||
                            state == LayoutState.calculator
                        ? 0
                        : state == LayoutState.notes ||
                                state == LayoutState.both ||
                                state == LayoutState.bothWithHistory
                            ? 310
                            : state == LayoutState.calculatorWithHistory
                                ? 0
                                : 310, // 200 is default value that never been reached
                    height: state == LayoutState.initial ||
                            state == LayoutState.calculator
                        ? 0
                        : state == LayoutState.notes
                            ? 440
                            : state == LayoutState.both
                                ? 279
                                : state == LayoutState.bothWithHistory
                                    ? 50
                                    : state == LayoutState.calculatorWithHistory
                                        ? 0
                                        : 50, // 200 is default value that never been reached
                    child: Transform.translate(
                      offset: const Offset(0, 0),
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.blue,
                        child: Center(
                          child: const Text("Notes"),
                        ),
                      ),
                    ),
                  ),
                  state == LayoutState.both ||
                          state == LayoutState.bothWithHistory
                      ? const SizedBox(height: 20)
                      : const SizedBox(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: state == LayoutState.initial ||
                            state == LayoutState.notes
                        ? 0
                        : state == LayoutState.notes ||
                                state == LayoutState.both ||
                                state == LayoutState.bothWithHistory
                            ? 310
                            : 310, // 200 is default value that never been reached
                    height: state == LayoutState.initial ||
                            state == LayoutState.notes
                        ? 0
                        : state == LayoutState.calculator
                            ? 440
                            : state == LayoutState.both
                                ? 151
                                : state == LayoutState.bothWithHistory
                                    ? 375
                                    : 440, // 200 is default value that never been reached
                    child: Transform.translate(
                      offset: const Offset(0, 0),
                      child: Container(
                        color: Colors.red,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Calculator"),
                            // button for turn history
                            ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<LayoutCubit>()
                                      .toggleCalculatorHistory();
                                },
                                child: const Text("Turn history"))
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
