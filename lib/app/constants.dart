import 'package:currency_exchange/currency_converter/services/currency_converting_service.dart';
import 'package:currency_exchange/notes/models/note_model.dart';
import 'package:currency_exchange/notes/services/note_service.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final dir = await getApplicationDocumentsDirectory();

  final List<CollectionSchema<dynamic>> collections = [NoteSchema];
  final isar = await Isar.open(collections, directory: dir.path);

  getIt.registerSingleton<Isar>(isar);
  getIt.registerSingleton<NoteService>(NoteService());
  getIt.registerSingleton<CurrencyConvertingService>(
      CurrencyConvertingService());
}
