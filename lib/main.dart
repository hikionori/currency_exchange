import 'package:currency_exchange/app/app.dart';
import 'package:currency_exchange/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Isar
  await setup();

  // Setup WindowManager
  await windowManager.ensureInitialized();

  WindowOptions options = const WindowOptions(
    size: Size(756, 544),
    maximumSize: Size(756, 544),
    minimumSize: Size(756, 544),
    center: true,
  );

  await windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.show();
    await windowManager.setSize(options.size!);

    await windowManager.setResizable(false);
    await windowManager.setMinimizable(true);
    await windowManager.setMaximizable(false);
    await windowManager.setFullScreen(false);

    await windowManager.setAlwaysOnTop(false);
    await windowManager.setTitle("ValutaVerse");
    await windowManager.focus();
  });

  // Run the app
  runApp(const MyApp());
}
