import 'package:currency_exchange/app/bloc/global_app_layout_bloc.dart';
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
          BlocProvider<GlobalAppLayoutBloc>(
            create: (context) => GlobalAppLayoutBloc(),
          ),
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

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: BaseColors.background,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [CurrencyConverterModule()],
      )),
    );
  }
}
