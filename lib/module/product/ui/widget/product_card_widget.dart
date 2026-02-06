import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/banner/ui/widgets/image_loader.dart';
import 'package:mym1_mobile/module/product/index.dart';
import 'package:mym1_mobile/module/product/model/product_model.dart';
import 'package:mym1_mobile/module/product/provider/product_provider.dart';
import 'package:mym1_mobile/ui/widgets/space.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productNotifier = ref.read(productProvider.notifier);
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        productNotifier.setProduct(product);
        Navigator.of(context).pushNamed(ProductDetailPage.route);
      },
      child: Card(
        child: Row(
          spacing: 10,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ImageLoader(
                image: product.getThumbnail(),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Space(
                    bottom: 0,
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Space(
                    bottom: 0,
                    child: Text(product.categoryName),
                  ),
                  Space(
                    bottom: 0,
                    child: Text(product.brandName),
                  ),
                  Space(
                    bottom: 0,
                    child: Text(
                      product.getPrice(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
