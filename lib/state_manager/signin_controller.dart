import 'package:get/get.dart';
import 'package:module11/network/url.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/utils/signin_Model.dart';
import 'package:module11/utils/signindata.dart';

class SignInController extends GetxController {
  bool _signinprogress = false;
  bool get signinprogress =>_signinprogress;

  Future<bool> signin(String email, String password) async {
    _signinprogress = true;
    update();
    Map<String, dynamic> requestbody = {"email": email, "password": password};
    print(requestbody);
    final Networkresponse response =
        await Networkcall().postRequest(urls.login, requestbody, islogin: true);
    _signinprogress = false;
    update();
    if (response.issuccess) {
      await Signindata.saveinfo(Signinmodel.fromJson(response.body!));
      return true;
    } else {
      return false;
    }
  }
}
