import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tempod/model/create_product_model.dart';
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

  Future loginUser(LoginModel user) async {
    try {
      final response = await dio.post('auth/login', data: user.toJson());
      return response.data;
    } on DioException catch (e) {
      throw '$e';
    }
  }

  /*-------------------------Login with Google---------------------------------------*/

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  Future sigInWithGoogle() async{

    try{

      await _googleSignIn.initialize();

      //open google account picker
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      //Get google auth detail
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      //create firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken
      );

      //sign in to firebase
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    }catch(e){
      throw Exception('Google SingIn Failed: $e');
    }
  }

  /*-----------------------Product Services------------------------------------------*/
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('products');
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw '$e';
    }
  }

  Future productById(int id) async {
    try {
      final response = await dio.get('products/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '$e';
    }
  }

  Future<List<ProductModel>> paginationProduct({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        'products',
        queryParameters: {'offset': offset, 'limit': limit},
      );
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw '$e';
    }
  }

  Future addProduct(CreateProductModel body) async {
    try {
      final response = await dio.post('products/', data: body.toJson());
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await dio.post('products/$id');
    } on DioException catch (e) {
      throw e;
    }
  }
}
