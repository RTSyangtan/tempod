import 'package:get_storage/get_storage.dart';

class TokenStorage {

  static final GetStorage _box = GetStorage();
  static final String _accessToken = 'access_token';

  static void saveToken(String accessToken){
    _box.write(_accessToken, accessToken);
  }

  //read token
  static String? get getToken{
   return _box.read(_accessToken);
  }

  //del
  static void removeToken(){
    _box.remove(_accessToken);
  }
}