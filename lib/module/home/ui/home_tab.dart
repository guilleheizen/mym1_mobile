import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/banner/ui/mossaic/mossaic_banner_widget.dart';
import 'package:mym1_mobile/module/banner/ui/promotion/promotion_banner_widget.dart';
import 'package:mym1_mobile/module/home/provider/home_provider.dart';
import 'package:mym1_mobile/module/product/ui/widget/product_list_widget.dart';
import 'package:mym1_mobile/ui/widgets/index.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeProvider);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: home.when(
        data: (data) {
          return [
            SliverSafeArea(
              bottom: false,
              sliver: SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image(
                    image: Theme.of(context).brightness == Brightness.dark ? const AssetImage('assets/images/dark_logo.png') : const AssetImage('assets/images/light_logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: data.isHomeMossaicBannerAvailable,
                    child: MossaicBanner(),
                  ),
                  Visibility(
                    visible: data.isHomePromotionBannerAvailable,
                    child: PromotionBanner(),
                  ),
                  Visibility(
                    visible: data.isHomeProductAvailable,
                    child: ProductList(),
                  ),
                ],
              ),
            ),
          ];
        },
        error: (error, stackTrace) {
          return [];
        },
        loading: () {
          return [
            SliverFillRemaining(
              child: Center(
                child: Loader(),
              ),
            )
          ];
        },
      ),
    );
  }
}
