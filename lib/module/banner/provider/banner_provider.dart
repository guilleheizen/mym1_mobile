import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/banner/model/banner_model.dart';
import 'package:mym1_mobile/module/config/constant/services_constant.dart';
import 'package:mym1_mobile/module/config/index.dart';
import 'package:mym1_mobile/provider/client_provider.dart';
import 'package:mym1_mobile/util/index.dart';

final bannerProvider = AsyncNotifierProvider<BannerNotifier, BannerState>(BannerNotifier.new);

class BannerNotifier extends AsyncNotifier<BannerState> {
  @override
  Future<BannerState> build() async {
    final banners = await getBanners();
    return BannerState(
      banners: banners,
    );
  }

  Future<List<KZBanner>> getBanners({int retry = 5}) async {
    try {
      final bannerEndpoint = ref.read(configProvider.notifier).getEndpointByCode(ServiceEndpoint.bannerList);
      if (bannerEndpoint == null) {
        return [];
      }
      final response = await ref.read(clientProvider.notifier).get(bannerEndpoint);
      final banners = List<KZBanner>.from(
        response.data['data'].map(
          (banner) => KZBanner.fromJson(banner),
        ),
      );
      return banners;
    } catch (error, stackTrace) {
      Log.error('Error $error $stackTrace');
      if (retry == 0) {
        rethrow;
      }
      await Future.delayed(Duration(seconds: 1));
      return getBanners(retry: retry - 1);
    }
  }

  List<KZBanner> getBannersByTypeAndPlacement({required String type, required String placement}) {
    final banners = state.value?.banners ?? [];
    final lowerType = type.toLowerCase();
    final lowerPlacement = placement.toLowerCase();
    return banners.where((b) {
      final bType = (b.type).toLowerCase();
      final bPlacement = (b.placement).toLowerCase();
      return bType == lowerType && lowerPlacement == bPlacement;
    }).toList();
  }
}

class BannerState {
  List<KZBanner> banners;

  BannerState({
    required this.banners,
  });
}
