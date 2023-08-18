import 'package:get/get.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/network/url.dart';


class Otp_verification_controller extends GetxController{
  bool _otpVerificationInProgress = false;

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  Future<bool> verifyOTP(String email, String otp) async {
    _otpVerificationInProgress = true;
    update();
    final Networkresponse response = await Networkcall().getRequest(urls.otpverification(email, otp));
    _otpVerificationInProgress = false;
    update();
    if (response.body!['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }


}