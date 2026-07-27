import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempod/model/login_model.dart';
import 'package:tempod/model/register_model.dart';
import 'package:tempod/service/api_service.dart';
import 'package:tempod/storage/token_storage.dart';

final registerProvider = AsyncNotifierProvider(() => RegisterProvider());

class RegisterProvider extends AsyncNotifier {
  final _apiService = ApiService();

  @override
  Future<void> build() async {}

  Future<void> registerUser(RegisterModel user) async {

    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _apiService.registerUser(user);
    });
  }

  Future loginUser(LoginModel user)async{
     state = AsyncValue.loading();

     state = await AsyncValue.guard(()async{
      final response =   await _apiService.loginUser(user);
      final token = response['access_token'];
       TokenStorage.saveToken(token);
     });

  }
}
