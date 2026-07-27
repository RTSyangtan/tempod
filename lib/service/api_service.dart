import 'package:dio/dio.dart';
import 'package:tempod/model/login_model.dart';
import 'package:tempod/model/product_model.dart';
import 'package:tempod/model/register_model.dart';
import 'package:tempod/storage/token_storage.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.escuelajs.co/api/v1/',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        sendTimeout: Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = TokenStorage.getToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }
/*--------------------------User in-----------------------------------------------*/
  Future<void> registerUser(RegisterModel user) async {
    try {
      await dio.post('users', data: user.toJson());
    } on DioException catch (e) {
      throw '$e';
    }
  }

  Future loginUser(LoginModel user) async{
    try{
      final response = await dio.post('auth/login',data: user.toJson());
      return response.data;
    }on DioException catch(e){
      throw '$e';
    }
  }

  /*-----------------------Product Services------------------------------------------*/
  Future<List<ProductModel>> getProducts()async{
    try{
      final response = await dio.get('products');
      return (response.data as List).map((e)=>ProductModel.fromJson(e)).toList();
    }on DioException catch(e){
      throw '$e';
    }
  }

  Future productById(int id)async{
    try{
      final response = await dio.get('products/$id');
      return ProductModel.fromJson(response.data);
    }on DioException catch(e){
      throw '$e';
    }
  }

  Future<List<ProductModel>> paginationProduct({required int offset, required int limit})async{
    try{
      final response = await dio.get('products',queryParameters:
      {
          'offset':offset,
        'limit':limit
      });
      return (response.data as List).map((e)=>ProductModel.fromJson(e)).toList();
    }on DioException catch(e){
      throw '$e';
    }
  }

  Future<void> addProduct(ProductModel body)async{
    try{
      await dio.post('products/',data: body.toJson());
    }on DioException catch(e){
      throw e;
    }
  }
}
