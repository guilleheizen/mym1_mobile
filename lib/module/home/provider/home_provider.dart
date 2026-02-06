import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/module/config/constant/remote_config_constant.dart';
import 'package:mym1_mobile/module/config/index.dart';

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);

class HomeNotifier extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    final configNotifier = ref.read(configProvider.notifier);
    return HomeState(
      isHomeMossaicBannerAvailable: configNotifier.isRemoteConfigActiveByCode(RemoteConfigAvailable.homeMossaicBanner),
      isHomePromotionBannerAvailable: configNotifier.isRemoteConfigActiveByCode(RemoteConfigAvailable.homePromotionBanner),
      isHomeProductAvailable: configNotifier.isRemoteConfigActiveByCode(RemoteConfigAvailable.homeProduct),
    );
  }
}

class HomeState {
  bool isHomeMossaicBannerAvailable;
  bool isHomePromotionBannerAvailable;
  bool isHomeProductAvailable;

  HomeState({
    required this.isHomeMossaicBannerAvailable,
    required this.isHomePromotionBannerAvailable,
    required this.isHomeProductAvailable,
  });
}
