import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/env/env.dart';
import 'package:mym1_mobile/module/config/constant/services_constant.dart';
import 'package:mym1_mobile/module/config/model/remote_config_model.dart';
import 'package:mym1_mobile/module/config/model/service_model.dart';
import 'package:mym1_mobile/provider/client_provider.dart';
import 'package:collection/collection.dart' show IterableExtension;

final configProvider = AsyncNotifierProvider<ConfigNotifier, ConfigState>(ConfigNotifier.new);

class ConfigNotifier extends AsyncNotifier<ConfigState> {
  @override
  Future<ConfigState> build() async {
    final services = await getServices();
    final remoteConfigEndpoint = services.firstWhereOrNull((service) => service.code == ServiceEndpoint.remoteList)?.endpoint;
    final remoteConfigs = await getRemoteConfigs(remoteConfigEndpoint: remoteConfigEndpoint!);
    return ConfigState(
      services: services,
      remoteConfigs: remoteConfigs,
    );
  }

  Future<List<Service>> getServices({int retry = 5}) async {
    try {
      final response = await ref.read(clientProvider.notifier).get(Env.discoveryUrl);
      final services = List<Service>.from(
        response.data.map(
          (service) => Service.fromJson(service),
        ),
      );
      return services;
    } catch (e) {
      if (retry == 0) {
        rethrow;
      }
      await Future.delayed(Duration(seconds: 1));
      return getServices(retry: retry - 1);
    }
  }

  Future<List<RemoteConfig>> getRemoteConfigs({required String remoteConfigEndpoint, int retry = 5}) async {
    try {
      final response = await ref.read(clientProvider.notifier).get(remoteConfigEndpoint);
      final remoteConfigs = List<RemoteConfig>.from(
        response.data.map(
          (remoteConfig) => RemoteConfig.fromJson(remoteConfig),
        ),
      );
      return remoteConfigs;
    } catch (e) {
      if (retry == 0) {
        rethrow;
      }
      await Future.delayed(Duration(seconds: 1));
      return getRemoteConfigs(remoteConfigEndpoint: remoteConfigEndpoint, retry: retry - 1);
    }
  }

  String? getEndpointByCode(String code) {
    return state.value!.getEndpointByCode(code);
  }

  bool isRemoteConfigActiveByCode(String code) {
    return state.value!.isRemoteConfigActiveByCode(code);
  }
}

class ConfigState {
  List<Service> services;
  List<RemoteConfig> remoteConfigs;

  ConfigState({
    required this.services,
    required this.remoteConfigs,
  });

  String? getEndpointByCode(String code) {
    return services.firstWhereOrNull((service) => service.code == code)?.endpoint;
  }

  bool isRemoteConfigActiveByCode(String code) {
    final remoteConfig = remoteConfigs.firstWhereOrNull((remoteConfig) => remoteConfig.code == code);
    return remoteConfig != null;
  }
}
