import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mym1_mobile/module/config/provider/config_provider.dart';
import 'package:mym1_mobile/provider/client_provider.dart';
import 'package:mym1_mobile/provider/settings_provider.dart';
import 'package:mym1_mobile/ui/theme/dark_theme.dart';
import 'package:mym1_mobile/ui/theme/light_theme.dart';
import '/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await bootstrap(container);

  runApp(MYMAPP(container: container));
}

Future<void> bootstrap(ProviderContainer container) async {
  await Future.wait([
    container.read(clientProvider.future),
    container.read(configProvider.future),
    container.read(settingsProvider.future),
  ]);
}

class MYMAPP extends StatelessWidget {
  final ProviderContainer container;
  const MYMAPP({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("es_419");
    return UncontrolledProviderScope(
      container: container,
      // observers: [ErrorLogger()],
      child: AppContainer(
        title: 'M&M Fragancias',
      ),
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key, this.title = 'M&M Fragancias'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final theme = ref.watch(settingsProvider);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
          child: MaterialApp(
            title: title,
            locale: const Locale('es', 'ES'),
            supportedLocales: const [
              Locale('es', 'ES'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            themeMode: theme.value?.themeMode ?? ThemeMode.dark,
            darkTheme: DarkTheme.data,
            theme: LightTheme.data,
            onGenerateRoute: LocalRoutes.get,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
