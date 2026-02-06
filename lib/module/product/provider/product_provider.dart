import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mym1_mobile/constant/search_status.dart';
import 'package:mym1_mobile/module/config/constant/services_constant.dart';
import 'package:mym1_mobile/module/config/index.dart';
import 'package:mym1_mobile/module/product/model/product_model.dart';
import 'package:mym1_mobile/module/product/model/product_search_settings_model.dart';
import 'package:mym1_mobile/provider/client_provider.dart';
import 'package:mym1_mobile/util/index.dart';

final productProvider = AsyncNotifierProvider<ProductNotifier, ProductState>(ProductNotifier.new);

class ProductNotifier extends AsyncNotifier<ProductState> {
  Timer? debounce;
  TextEditingController searchController = TextEditingController();

  @override
  Future<ProductState> build() async {
    final products = await getProducts();
    return ProductState(
      searchSettings: ProductSearchSettings(
        pageNumber: 2,
      ),
      products: products,
    );
  }

  Future<List<Product>> getProducts({int retry = 5}) async {
    try {
      final productEndpoint = ref.read(configProvider.notifier).getEndpointByCode(ServiceEndpoint.productList);
      if (productEndpoint == null) {
        return [];
      }
      final response = await ref.read(clientProvider.notifier).get(productEndpoint, queryParam: {
        "pageSize": state.value?.searchSettings.pageSize ?? 5,
        "pageNumber": state.value?.searchSettings.pageNumber ?? 1,
        "order": state.value?.searchSettings.order ?? 'DESC',
        "search": state.value?.searchSettings.query,
        "categoryCode": state.value?.searchSettings.categoryCode,
        "brandCode": state.value?.searchSettings.brandCode,
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

  void setProduct(Product product) {
    state = AsyncValue.data(state.value!.setProduct(product));
  }
}

class ProductState {
  ProductSearchSettings searchSettings;
  List<Product> products;
  Product? selectedProduct;
  SearchStatus status;

  ProductState({
    required this.searchSettings,
    required this.products,
    this.selectedProduct,
    this.status = SearchStatus.idle,
  });

  ProductState setSearchSettings(ProductSearchSettings newSearchSettings) {
    return ProductState(
      searchSettings: newSearchSettings,
      products: [],
      selectedProduct: selectedProduct,
      status: SearchStatus.searching,
    );
  }

  ProductState setProduct(Product newProduct) {
    return ProductState(
      searchSettings: searchSettings,
      products: products,
      selectedProduct: newProduct,
      status: status,
    );
  }

  ProductState setProducts(List<Product> newProducts) {
    SearchStatus changedStatus = newProducts.length < searchSettings.pageSize ? SearchStatus.lastPage : SearchStatus.done;
    if (searchSettings.isEqualTo(ProductSearchSettings())) {
      changedStatus = SearchStatus.idle;
    }
    return ProductState(
      searchSettings: ProductSearchSettings(
        query: searchSettings.query,
        categoryCode: searchSettings.categoryCode,
        brandCode: searchSettings.brandCode,
        pageSize: searchSettings.pageSize,
        pageNumber: searchSettings.pageNumber + 1,
      ),
      products: [...products, ...newProducts],
      selectedProduct: selectedProduct,
      status: changedStatus,
    );
  }
}
