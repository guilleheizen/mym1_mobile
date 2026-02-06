import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/banner/provider/banner_provider.dart';
import 'package:mym1_mobile/module/banner/ui/widgets/image_loader.dart';
import 'package:mym1_mobile/module/banner/ui/widgets/image_swiper.dart';
import 'package:mym1_mobile/module/product/index.dart';
import 'package:mym1_mobile/module/product/model/product_search_settings_model.dart';
import 'package:mym1_mobile/module/product/submodule/product_group/provider/product_group_provider.dart';
import 'package:mym1_mobile/ui/widgets/index.dart';

class MossaicBanner extends ConsumerWidget {
  const MossaicBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banner = ref.watch(bannerProvider);
    final bannerNotifier = ref.read(bannerProvider.notifier);
    final productGroupNotifier = ref.read(productGroupProvider.notifier);
    final width = MediaQuery.of(context).size.width - 32;

    return banner.when(
      data: (data) {
        final leftBanners = bannerNotifier.getBannersByTypeAndPlacement(type: 'mossaic', placement: 'left');
        final topBanners = bannerNotifier.getBannersByTypeAndPlacement(type: 'mossaic', placement: 'right-top');
        final bottomBanners = bannerNotifier.getBannersByTypeAndPlacement(type: 'mossaic', placement: 'right-bottom');
        return Column(
          children: [
            Space(
              horizontal: 16,
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            Space(
              horizontal: 16,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                height: width,
                clipBehavior: Clip.hardEdge,
                child: Row(
                  children: [
                    SizedBox(
                      width: width / 2,
                      height: width,
                      child: FadeCardSwiper(
                        banners: leftBanners
                            .map(
                              (banner) => InkWell(
                                onTap: () {
                                  productGroupNotifier.search(searchSettings: ProductSearchSettings(productGroupCode: banner.productGroupCode, productGroupTitle: banner.name));
                                  Navigator.of(context).pushNamed(ProductGroupPage.route);
                                },
                                child: ImageLoader(
                                  image: banner.getImage(),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: width / 2,
                          height: width / 2,
                          child: FadeCardSwiper(
                            banners: topBanners
                                .map(
                                  (banner) => InkWell(
                                    onTap: () {
                                      productGroupNotifier.search(searchSettings: ProductSearchSettings(productGroupCode: banner.productGroupCode, productGroupTitle: banner.name));
                                      Navigator.of(context).pushNamed(ProductGroupPage.route);
                                    },
                                    child: ImageLoader(
                                      image: banner.getImage(),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          width: width / 2,
                          height: width / 2,
                          child: FadeCardSwiper(
                            banners: bottomBanners
                                .map(
                                  (banner) => InkWell(
                                    onTap: () {
                                      productGroupNotifier.search(searchSettings: ProductSearchSettings(productGroupCode: banner.productGroupCode, productGroupTitle: banner.name));
                                      Navigator.of(context).pushNamed(ProductGroupPage.route);
                                    },
                                    child: ImageLoader(
                                      image: banner.getImage(),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return SizedBox();
      },
      loading: () {
        return Shimmer(
          height: width,
        );
      },
    );
  }
}
