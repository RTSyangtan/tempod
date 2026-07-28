import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempod/model/create_product_model.dart';
import 'package:tempod/model/product_model.dart';
import 'package:tempod/service/api_service.dart';

final createdProductProvider = AsyncNotifierProvider(
  () => CreatedProductProvider(),
);

class CreatedProductProvider extends AsyncNotifier<List<ProductModel>> {
  final ApiService _apiService = ApiService();

  @override
  Future<List<ProductModel>> build() async {
    return [];
  }

  Future addCreatedProduct(CreateProductModel model) async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newProduct = await _apiService.addProduct(model);

      return [...state.value ?? [], newProduct];
    });
  }
}
