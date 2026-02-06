import 'package:flutter/material.dart';

class MenuItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  MenuItem(this.label, this.icon, this.onTap);
}

class MenuList extends StatelessWidget {
  const MenuList({super.key, required this.items});
  final List<MenuItem> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.onInverseSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          final isLast = i == items.length - 1;
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: Icon(item.icon, color: cs.primary),
                title: Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                trailing: Icon(Icons.chevron_right_rounded, color: cs.outline),
                onTap: item.onTap,
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: cs.outlineVariant.withAlpha(80),
                  indent: 56,
                  endIndent: 12,
                ),
            ],
          );
        }),
      ),
    );
  }
}
