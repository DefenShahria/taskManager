import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:module11/app.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/utils/signindata.dart';

class Networkcall {
  Future<Networkresponse> getRequest(String url) async {

    try {
      Response response = await get(Uri.parse(url),headers: {'token': Signindata.userinfo.token.toString()});
      if (response.statusCode == 200) {
        return Networkresponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if(response.statusCode == 401){
        login();
      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return Networkresponse(false, -1, null);
  }

  Future<Networkresponse> postRequest(
      String url, Map<String, dynamic> body,{bool islogin = false }) async {
    try {
      print(body);
      Response response = await post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', 'token' : Signindata.userinfo.token.toString()},
        body: jsonEncode(body),
      );
      //log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return Networkresponse(
            true, response.statusCode, jsonDecode(response.body));
      }else if(response.statusCode == 401){
       if(islogin) {
          login();
        }
      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return Networkresponse(false, -1, null);
  }

  Future<void> login() async {
    await Signindata.clearinfo();
    Navigator.pushAndRemoveUntil(TaskManager.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) => loginscrn()), (route) => false);
  }
}
