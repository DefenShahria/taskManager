import 'dart:convert';

import 'package:module11/utils/signin_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signindata {
  Signindata._();
  static Signinmodel userinfo = Signinmodel();

  static Future<void> saveinfo(Signinmodel model) async {
    print(model.data!.firstName);
    SharedPreferences _logindata = await SharedPreferences.getInstance();
    await _logindata.setString('User-data', jsonEncode(model.toJson()));
    userinfo=model;
  }

  static Future<void> updateInfo(Data data) async {
    print(data.firstName);
    userinfo.data = data;
    SharedPreferences _logindata = await SharedPreferences.getInstance();
    await _logindata.setString('User-data', jsonEncode(userinfo.toJson()));
  }

  static Future<Signinmodel?> getinfo() async {
    SharedPreferences _logindata = await SharedPreferences.getInstance();
    String? value = _logindata.getString('User-data');
    return Signinmodel.fromJson(jsonDecode(value!));

  }

  static Future<void> clearinfo() async {
    SharedPreferences _logindata = await SharedPreferences.getInstance();
    await _logindata.clear();
  }

  static Future<bool> checkinfo() async {
    SharedPreferences _logindata = await SharedPreferences.getInstance();
    bool isSignin = _logindata.containsKey('User-data');
    if (isSignin) {
      userinfo = await getinfo() ?? Signinmodel(); // Provide a default value when getinfo() returns null.
    }
    return isSignin;
  }


}
