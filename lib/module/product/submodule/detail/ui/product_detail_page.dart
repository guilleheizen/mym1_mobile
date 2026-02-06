import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/banner/ui/widgets/image_loader.dart';
import 'package:mym1_mobile/module/product/provider/product_provider.dart';
import 'package:mym1_mobile/ui/widgets/loader.dart';
import 'package:mym1_mobile/ui/widgets/space.dart';
import 'package:mym1_mobile/util/index.dart';

class ProductDetailPage extends ConsumerWidget {
  static const route = '/product/detail';

  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider);
    final theme = Theme.of(context);

    return product.when(
      data: (data) {
        final product = data.selectedProduct!;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ImageLoader(
                        image: product.getImage(),
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Space(
                        bottom: 3,
                        child: Text(
                          product.name,
                          style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Space(
                        child: Text(
                          '${product.brandName} · ${product.categoryName}',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Space(
                        bottom: 5,
                        child: Text(
                          product.getPrice(),
                          style: theme.textTheme.headlineMedium!.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          spacing: 6,
                          children: [
                            Icon(
                              product.stock > 0 ? Icons.check_circle : Icons.cancel,
                              color: product.stock > 0 ? Colors.green : Colors.red,
                              size: 18,
                            ),
                            Expanded(
                              child: Text(
                                product.stock > 0 ? 'Stock disponible (${product.stock})' : 'Sin stock',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Space(
                        bottom: 0,
                        child: Text(
                          'Descripción',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Space(
                        bottom: 50,
                        child: Text(
                          product.description,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: product.stock > 0 ? () {} : null,
                          child: Text(
                            'Agregar al carrito',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        Log.error('ERROR GETTING PRODUCT $error, $stackTrace');
        return Scaffold(
          body: Center(
            child: Text('Error'),
          ),
        );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: Loader(),
          ),
        );
      },
    );
  }
}
