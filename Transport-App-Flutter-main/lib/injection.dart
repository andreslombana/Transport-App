import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:indriver_clone_flutter/injection.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', 
  preferRelativeImports: true, 
  asExtension: true, 
)
Future<void> configureDependencies() async => await locator.init();