import 'package:flutter/cupertino.dart' show CupertinoSliverRefreshControl;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/constant/search_status.dart';
import 'package:mym1_mobile/module/product/model/product_search_settings_model.dart';
import 'package:mym1_mobile/module/product/submodule/product_group/provider/product_group_provider.dart';
import 'package:mym1_mobile/module/product/ui/widget/product_card_widget.dart';
import 'package:mym1_mobile/ui/widgets/index.dart';
import 'package:mym1_mobile/util/log.dart';

class ProductGroupPage extends ConsumerWidget {
  static const route = '/product/group';
  const ProductGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productGroupProvider);
    final productGroupNotifier = ref.read(productGroupProvider.notifier);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final metrics = notification.metrics;

            if (metrics.pixels >= metrics.maxScrollExtent) {
              productGroupNotifier.nextPage();
            }
          }
          return false;
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: product.when(
            data: (data) {
              return [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    productGroupNotifier.search(
                      searchSettings: ProductSearchSettings(
                        productGroupCode: data.searchSettings.productGroupCode,
                        productGroupTitle: data.searchSettings.productGroupTitle,
                      ),
                    );
                  },
                ),
                SliverSafeArea(
                  bottom: false,
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 35,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Space(
                          top: 20,
                          horizontal: 16,
                          bottom: 5,
                          child: Text(
                            'Selección de productos',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                        Space(
                          horizontal: 16,
                          bottom: 30,
                          child: Text(
                            data.searchSettings.productGroupTitle ?? 'Lo que encontramos...',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverVisibility(
                  visible: data.status != SearchStatus.searching,
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        data.products.map((product) => ProductCard(product: product)).toList(),
                      ),
                    ),
                  ),
                ),
                SliverVisibility(
                  visible: data.status == SearchStatus.searching,
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          5,
                          (index) => Shimmer(
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 20),
                            height: 120,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverVisibility(
                  visible: data.products.isEmpty,
                  sliver: SliverFillRemaining(
                    child: Center(
                      child: Text('¡Ups! No encontramos registros.'),
                    ),
                  ),
                ),
                SliverVisibility(
                  visible: data.status == SearchStatus.lastPage,
                  sliver: SliverToBoxAdapter(
                    child: Space(
                      child: Text(
                        'Ya no hay más registros',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ];
            },
            error: (error, stackTrace) {
              Log.error('ERROR GETTING PRODUCTS $error, $stackTrace');
              return [];
            },
            loading: () {
              return [];
            },
          ),
        ),
      ),
    );
  }
}
