import 'package:get/get.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/network/url.dart';

class SignUpController extends GetxController {
  bool _signupProgress = false;
  bool get signupProgress => _signupProgress;

  Future<bool> signUp(
      String email, String firstName, String lastName, String mobile, String password) async {
    _signupProgress = true;
    update();

    Map <String, dynamic> requestBody = {
      "email": email.trim(),
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "mobile": mobile.trim(),
      "password": password,
      "photo": "",
    };
    final Networkresponse response =
    await Networkcall().postRequest(urls.registrarion, requestBody);

    _signupProgress = false;
    update();

    if (response.issuccess) {
      return true;
    } else {
      return false;
    }
  }
}
