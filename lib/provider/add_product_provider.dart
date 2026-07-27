import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempod/service/api_service.dart';

import '../model/product_model.dart';

final addProductProvider = AsyncNotifierProvider(()=>AddProductProvider());

class AddProductProvider extends AsyncNotifier {
  final ApiService _apiService = ApiService();

  @override
  Future<void> build() async {}

  Future<void> addProduct(ProductModel product) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _apiService.addProduct(product);
    });
  }
}
