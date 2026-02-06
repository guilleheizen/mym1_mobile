import 'package:flutter/material.dart';
import 'package:mym1_mobile/module/profile/ui/widget/menu/menu_list_widget.dart';
import 'package:mym1_mobile/module/profile/ui/widget/profile_card/profile_header_widget.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.onInverseSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 50,
        children: [
          ProfileHeader(
            name: "Guille Heizen",
            subtitle: "Lead Mobile Flutter",
            imageUrl: "https://i.ibb.co/hJ9f6kqQ/mimi.jpg",
          ),
          MenuList(
            items: [
              MenuItem("Tus pedidos", Icons.receipt_long_outlined, () {}),
              MenuItem("Dirección de envío", Icons.local_shipping_outlined, () {}),
              MenuItem("Información personal", Icons.person_outline_rounded, () {}),
              MenuItem("Centro de atención", Icons.help_outline_rounded, () {}),
              MenuItem("Configuración", Icons.settings_outlined, () {}),
              MenuItem("Cerrar sesión", Icons.logout_rounded, () {}),
            ],
          ),
        ],
      ),
    );
  }
}
