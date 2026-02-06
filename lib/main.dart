import 'package:flutter/material.dart';

import 'package:kuzco_app/kuzcco_app.dart';
import 'package:mym1_mobile/theme/custom_icons.dart';
import 'package:mym1_mobile/theme/light_theme.dart';
import 'package:mym1_mobile/theme/dark_theme.dart';
import 'package:mym1_mobile/env/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  KuzcoInitInformation(
    discoveryUrl: Env.discoveryUrl,
    fullImageUrl: Env.fullImageUrl,
    thumbnailImageUrl: Env.thumbnailImageUrl,
    privateKey: Env.privateKey,
    publicKey: Env.publicKey,
    version: Env.version,
    lightTheme: LightTheme.data,
    darkTheme: DarkTheme.data,
    appIcons: CustomIcons.instance,
  );

  final providerContainer = await bootstrap();

  runApp(KuzcoApp(
    container: providerContainer,
    title: 'M&M Fragancias',
  ));
}
