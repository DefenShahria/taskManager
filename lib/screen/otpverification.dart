import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/screen/setpass.dart';
import 'package:module11/state_manager/otp_verification_controller.dart';
import 'package:module11/widgets/backscreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class otpverify extends StatefulWidget {
  final String email;

  const otpverify({Key? key, required this.email}) : super(key: key);

  @override
  State<otpverify> createState() => _otpverifyState();
}

class _otpverifyState extends State<otpverify> {
  final TextEditingController _otpTEController = TextEditingController();
  bool _otpVerificationInProgress = false;
  final Otp_verification_controller otp_verification_controller = Get.find<Otp_verification_controller>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backimg(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 84,
                ),
                const Text(
                  'PIN Verification',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Give the given PIN on your Email',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                PinCodeTextField(
                  controller: _otpTEController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white54,
                    inactiveFillColor: Colors.white54,
                    inactiveColor: Colors.red,
                    selectedColor: Colors.white54,
                    selectedFillColor: Colors.black54,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {

                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _otpVerificationInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        otp_verification_controller.verifyOTP(widget.email, _otpTEController.text).then((value){
                          if(value == true){
                            Get.off(const setpass());
                          }

                        });
                      },
                      child: const Text('Verify'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have a Account ?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const loginscrn()));
                        },
                        child: const Text(
                          "Sign in ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
