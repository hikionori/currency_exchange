import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/app/utils.dart';
import 'package:currency_exchange/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_exchange/currency_converter/presentation/module.dart';
import 'package:currency_exchange/notes/bloc/note_bloc.dart';
import 'package:currency_exchange/notes/presentation/module.dart';
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
  @override
  void initState() {
    BlocProvider.of<NoteBloc>(context).add(FetchNotes());
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
            BlocBuilder<LayoutCubit, LayoutState>(
              builder: (context, state) {
                final notesWidth = getNotesWidth(state);
                final notesHeight = getNotesHeight(state);
                final calculatorWidth = getCalculatorWidth(state);
                final calculatorHeight = getCalculatorHeight(state);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NotesModule(
                        notesWidth: notesWidth, notesHeight: notesHeight),
                    state == LayoutState.both ||
                            state == LayoutState.bothWithHistory
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: calculatorWidth,
                      height: calculatorHeight,
                      child: Transform.translate(
                        offset: const Offset(0, 0),
                        child: Container(
                          color: Colors.red,
                          child: SingleChildScrollView(
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
