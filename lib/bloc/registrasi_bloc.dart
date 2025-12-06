import 'dart:convert';
import '../helpers/api.dart';
import '../helpers/api_url.dart';
import '../model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {String? username, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {"username": username, "email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Registrasi.fromJson(jsonObj);
  }
}