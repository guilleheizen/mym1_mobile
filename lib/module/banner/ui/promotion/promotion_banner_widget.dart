import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/banner/index.dart';
import 'package:mym1_mobile/module/banner/ui/widgets/image_loader.dart';
import 'package:mym1_mobile/module/product/model/product_search_settings_model.dart';
import 'package:mym1_mobile/module/product/submodule/product_group/provider/product_group_provider.dart';
import 'package:mym1_mobile/module/product/submodule/product_group/ui/prduct_group_page.dart';
import 'package:mym1_mobile/ui/widgets/index.dart';

class PromotionBanner extends ConsumerStatefulWidget {
  const PromotionBanner({super.key});

  @override
  ConsumerState<PromotionBanner> createState() => _PromotionBannerState();
}

int currentPage = 0;

class _PromotionBannerState extends ConsumerState<PromotionBanner> {
  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
    final bannerNotifier = ref.read(bannerProvider.notifier);
    final productGroupNotifier = ref.read(productGroupProvider.notifier);

    return banners.when(
      data: (data) {
        final promotionBanners = bannerNotifier.getBannersByTypeAndPlacement(type: 'promotion', placement: 'center');
        if (promotionBanners.isEmpty) {
          return SizedBox();
        }

        final double viewportFraction = promotionBanners.length > 1 ? .8 : 1;
        final PageController pageController = PageController(initialPage: 0, viewportFraction: viewportFraction, keepPage: true);
        return Column(
          children: [
            Space(
              horizontal: 16,
              child: Text(
                'Promociones',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            Space(
              left: 16,
              child: SizedBox(
                height: 160,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                  padEnds: false,
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (context, i) => Space(
                    bottom: 0,
                    right: 16,
                    child: InkWell(
                      onTap: () {
                        productGroupNotifier.search(
                          searchSettings: ProductSearchSettings(
                            productGroupCode: promotionBanners[i].productGroupCode,
                            productGroupTitle: promotionBanners[i].name,
                          ),
                        );
                        Navigator.of(context).pushNamed(ProductGroupPage.route);
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                        clipBehavior: Clip.hardEdge,
                        child: ImageLoader(
                          image: promotionBanners[i].getImage(),
                        ),
                      ),
                    ),
                  ),
                  itemCount: promotionBanners.length,
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
          height: 160,
        );
      },
    );
  }
}
