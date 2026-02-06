import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/product/provider/product_provider.dart';
import 'package:mym1_mobile/module/product/ui/widget/product_card_widget.dart';
import 'package:mym1_mobile/ui/widgets/shimmer.dart';
import 'package:mym1_mobile/ui/widgets/space.dart';
import 'package:mym1_mobile/util/index.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider);

    return product.when(
      data: (data) {
        return Column(
          children: [
            Space(
              horizontal: 16,
              child: Text(
                'Ultimos lanzamientos',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            ...data.products.map(
              (product) => ProductCard(product: product),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        Log.error('ERROR GETTING PRODUCTS $error, $stackTrace');
        return SizedBox();
      },
      loading: () {
        return Column(
          children: List.generate(
            3,
            (index) => Shimmer(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
              height: 120,
            ),
          ),
        );
      },
    );
  }
}
