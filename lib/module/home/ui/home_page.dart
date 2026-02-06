import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/home/ui/home_tab.dart';
import 'package:mym1_mobile/module/product/index.dart';
import 'package:mym1_mobile/module/profile/index.dart';
import 'package:mym1_mobile/ui/index.dart';

class HomePage extends ConsumerStatefulWidget {
  static const route = '/';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeTab(),
      ProductTab(),
      const ProfileTab(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (_index == 0) {
          showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('¿Salir?'),
              content: const Text('¿Estás seguro de salir?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Salir'),
                ),
              ],
            ),
          ).then((value) {
            if (value ?? false) SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            ;
          });
          return;
        } else {
          setState(() => _index = 0);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(CustomIcons.homeOutlined),
              selectedIcon: Icon(CustomIcons.homeFilled, color: Theme.of(context).colorScheme.surface),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(CustomIcons.cartOutlined),
              selectedIcon: Icon(CustomIcons.cartFilled, color: Theme.of(context).colorScheme.surface),
              label: 'Productos',
            ),
            NavigationDestination(
              icon: Icon(CustomIcons.userOutlined),
              selectedIcon: Icon(CustomIcons.userFilled, color: Theme.of(context).colorScheme.surface),
              label: 'Perfil',
            ),
          ],
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
        ),
      ),
    );
  }
}
