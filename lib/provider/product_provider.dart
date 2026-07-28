import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempod/model/product_model.dart';
import 'package:tempod/service/api_service.dart';

final _apiService = ApiService();
final productProvider = FutureProvider((ref) => _apiService.getProducts());
final productByIdProvider = FutureProvider.family((ref, int id) {
  return _apiService.productById(id);
});
final paginationProvider = AsyncNotifierProvider(
  () => PaginationProductProvider(),
);

final delProductProvider = FutureProvider.family((ref,int id)=>_apiService.deleteProduct(id));


class PaginationProductProvider extends AsyncNotifier<List<ProductModel>> {
  int offset = 0;
  final int limit = 10;

  @override
  FutureOr<List<ProductModel>> build() async {
    return await _apiService.paginationProduct(offset: offset, limit: limit);
  }

  Future loadMore() async {
    offset += limit;

    final newProducts = await _apiService.paginationProduct(
      offset: offset,
      limit: limit,
    );
    state = AsyncData([...state.value ?? [], ...newProducts]);
  }

  /*-------------------Product Add-----------------------------------------------*/

}
