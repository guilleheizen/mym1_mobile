import 'package:flutter/material.dart';
import 'package:mym1_mobile/module/home/index.dart';
import 'package:mym1_mobile/module/product/index.dart';

class LocalRoutes {
  static Route<dynamic>? get(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case HomePage.route:
        builder = (_) => HomePage();
        break;
      case ProductDetailPage.route:
        builder = (_) => ProductDetailPage();
        break;
      case ProductGroupPage.route:
        builder = (_) => ProductGroupPage();
        break;

      default:
        throw Exception('Ruta no definida');
    }
    return MaterialPageRoute(builder: (context) => builder(context));
  }
}
