import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/screen/basescreen.dart';
import 'package:module11/screen/forgetpass.dart';
import 'package:module11/screen/signup.dart';
import 'package:module11/state_manager/signin_controller.dart';
import '../widgets/backscreen.dart';

class loginscrn extends StatefulWidget {
  const loginscrn({super.key});

  @override
  State<loginscrn> createState() => _loginscrnState();
}

class _loginscrnState extends State<loginscrn> {
  final TextEditingController _emailtecontroller = TextEditingController();
  final TextEditingController _passtecontroller = TextEditingController();

  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: backimg(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 90,
              ),
              const Text(
                'Get Started With',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _emailtecontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your Email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _passtecontroller,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (String? value) {
                  if ((value?.isEmpty ?? true) || (value!.length < 5)) {
                    return 'Enter your 6 digit Password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<SignInController>(
                  builder: (signinController) {
                return SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: signinController.signinprogress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          signinController
                              .signin(_emailtecontroller.text.trim(),
                                  _passtecontroller.text)
                              .then((result) {
                            if (result == true) {
                              Get.offAll(BottomNave());
                            } else {
                              Get.snackbar('Failed', 'Login failed');
                            }
                          });
                        },
                        child: Icon(Icons.arrow_circle_right_rounded)),
                  ),
                );
              }),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Get.off(const forgetpass());
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have an Account ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.off(SignupScreen());
                      },
                      child: Text("Sign up ")),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
