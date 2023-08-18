import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/network/url.dart';


class ProfileUpdateController extends GetxController {

  bool _inProgress = false;
bool get inProgress => _inProgress;
  String? base64Image;


  Future <bool> updateProfile(String firstname, String lastname,String mobile,String password,XFile? pickedImage ) async {


    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    _inProgress = true;
    update();

    Map<String, String> body = {
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,

    };

    if (password.isNotEmpty) {
      body['password'] = password;
    }

    final Networkresponse response =
    await Networkcall().postRequest(urls.profileupdate, body);

    _inProgress = false;
    update();

    if (response.issuccess) {
      return true;
    } else {
      return false;
    }

  }

  void updateUI (){

    update();

  }

}
