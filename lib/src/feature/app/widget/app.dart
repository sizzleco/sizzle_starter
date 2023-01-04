import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sizzle_starter/src/core/widget/scopes_provider.dart';
import 'package:sizzle_starter/src/feature/app/widget/app_context.dart';
import 'package:sizzle_starter/src/feature/initialization/model/initialization_progress.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/repositories_scope.dart';

class App extends StatelessWidget {
  const App({
    required this.result,
    super.key,
  });

  void run() => runApp(
        DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: this,
        ),
      );

  final InitializationResult result;

  @override
  Widget build(BuildContext context) => ScopesProvider(
        buildScopes: [
          (child) => DependenciesScope(
                dependencies: result.dependencies,
                child: child,
              ),
          (child) => RepositoriesScope(
                repositories: result.repositories,
                child: child,
              ),
        ],
        child: const AppContext(),
      );
}
