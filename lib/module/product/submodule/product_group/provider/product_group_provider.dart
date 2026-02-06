import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/constant/search_status.dart';
import 'package:mym1_mobile/module/config/constant/services_constant.dart';
import 'package:mym1_mobile/module/config/index.dart';
import 'package:mym1_mobile/module/product/model/product_model.dart';
import 'package:mym1_mobile/module/product/model/product_search_settings_model.dart';
import 'package:mym1_mobile/provider/client_provider.dart';
import 'package:mym1_mobile/util/index.dart';

final productGroupProvider = AsyncNotifierProvider<ProductGroupNotifier, ProductGroupState>(ProductGroupNotifier.new);

class ProductGroupNotifier extends AsyncNotifier<ProductGroupState> {
  @override
  Future<ProductGroupState> build() async {
    return ProductGroupState(
      searchSettings: ProductSearchSettings(),
      products: [],
      status: SearchStatus.searching,
    );
  }

  Future<List<Product>> getProducts({int retry = 5}) async {
    try {
      final productGroupEndpoint = ref.read(configProvider.notifier).getEndpointByCode(ServiceEndpoint.productByGroup);
      if (productGroupEndpoint == null) {
        return [];
      }
      final response = await ref.read(clientProvider.notifier).get("$productGroupEndpoint/${state.value?.searchSettings.productGroupCode ?? ''}", queryParam: {
        "pageSize": state.value?.searchSettings.pageSize ?? 6,
        "pageNumber": state.value?.searchSettings.pageNumber ?? 1,
        "order": state.value?.searchSettings.order ?? 'DESC',
      });
      final products = List<Product>.from(
        response.data['data'].map(
          (banner) => Product.fromJson(banner),
        ),
      );
      return products;
    } catch (error, stackTrace) {
      Log.error('Error $error $stackTrace');
      if (retry == 0) {
        rethrow;
      }
      await Future.delayed(Duration(seconds: 1));
      return getProducts(retry: retry - 1);
    }
  }

  Future<void> search({required ProductSearchSettings searchSettings}) async {
    state = AsyncValue.data(state.value!.setSearchSettings(searchSettings));
    final products = await getProducts();
    state = AsyncValue.data(state.value!.setProducts(products));
  }

  Future<void> nextPage() async {
    if (state.value?.status != SearchStatus.idle && state.value?.status != SearchStatus.done) {
      return;
    }
    final products = await getProducts();
    state = AsyncValue.data(state.value!.setProducts(products));
  }
}

class ProductGroupState {
  ProductSearchSettings searchSettings;
  List<Product> products;
  SearchStatus status;

  ProductGroupState({
    required this.searchSettings,
    required this.products,
    this.status = SearchStatus.idle,
  });

  ProductGroupState setSearchSettings(ProductSearchSettings newSearchSettings) {
    return ProductGroupState(
      searchSettings: newSearchSettings,
      products: [],
      status: SearchStatus.searching,
    );
  }

  ProductGroupState setProducts(List<Product> newProducts) {
    SearchStatus changedStatus = newProducts.length < searchSettings.pageSize ? SearchStatus.lastPage : SearchStatus.done;
    if (searchSettings.isEqualTo(ProductSearchSettings())) {
      changedStatus = SearchStatus.idle;
    }
    return ProductGroupState(
      searchSettings: ProductSearchSettings(
        query: searchSettings.query,
        categoryCode: searchSettings.categoryCode,
        brandCode: searchSettings.brandCode,
        pageSize: searchSettings.pageSize,
        pageNumber: searchSettings.pageNumber + 1,
        productGroupCode: searchSettings.productGroupCode,
        productGroupTitle: searchSettings.productGroupTitle,
      ),
      products: [...products, ...newProducts],
      status: changedStatus,
    );
  }
}
