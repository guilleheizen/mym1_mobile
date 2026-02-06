import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/constant/search_status.dart';
import 'package:mym1_mobile/module/product/model/product_search_settings_model.dart';
import 'package:mym1_mobile/module/product/provider/product_provider.dart';
import 'package:mym1_mobile/module/product/ui/widget/product_card_widget.dart';
import 'package:mym1_mobile/ui/index.dart';
import 'package:mym1_mobile/ui/widgets/index.dart';
import 'package:mym1_mobile/util/log.dart';

class ProductTab extends ConsumerWidget {
  const ProductTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider);
    final productNotifier = ref.read(productProvider.notifier);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(25),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Space(
                    top: 20,
                    horizontal: 16,
                    child: Text(
                      'Buscar productos',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Space(
                    horizontal: 16,
                    child: TextFormField(
                      onChanged: (String? query) {
                        if (productNotifier.debounce?.isActive ?? false) productNotifier.debounce!.cancel();
                        productNotifier.debounce = Timer(const Duration(milliseconds: 500), () {
                          if (query != null) {
                            productNotifier.search(searchSettings: ProductSearchSettings(query: query));
                          }
                        });
                      },
                      controller: productNotifier.searchController,
                      onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.surface,
                        hintText: 'Buscar...',
                        suffixIcon: product.value?.status == SearchStatus.idle
                            ? IconButton(
                                icon: Icon(
                                  CustomIcons.searchOutlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {},
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                onPressed: () {
                                  productNotifier.search(searchSettings: ProductSearchSettings());
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  productNotifier.searchController.clear();
                                },
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final metrics = notification.metrics;

            if (metrics.pixels >= metrics.maxScrollExtent) {
              productNotifier.nextPage();
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
                    productNotifier.searchController.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                    productNotifier.search(searchSettings: ProductSearchSettings());
                  },
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
