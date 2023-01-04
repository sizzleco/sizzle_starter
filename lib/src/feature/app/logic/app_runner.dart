import 'package:blaze_starter/src/core/model/initialization_hook.dart';
import 'package:blaze_starter/src/feature/app/widget/app.dart';
import 'package:blaze_starter/src/feature/initialization/logic/initialization_processor.dart';
import 'package:blaze_starter/src/feature/initialization/logic/initialization_steps.dart';
import 'package:flutter/material.dart';

/// A class which is responsible for initialization and running the app.
class AppRunner
    with
        InitializationSteps,
        InitializationProcessor,
        InitializationFactoryImpl {
  /// run initialization
  ///
  /// if success -> run app
  Future<void> initializeAndRun(InitializationHook hook) async {
    final bindings = WidgetsFlutterBinding.ensureInitialized()
      ..deferFirstFrame();
    final result = await processInitialization(
      steps: initializationSteps,
      hook: hook,
      factory: this,
    );
    // Run application
    App(result: result).run();
    bindings.addPostFrameCallback((_) {
      bindings.allowFirstFrame();
    });
  }
}
