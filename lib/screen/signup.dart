import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/state_manager/signup_controller.dart';
 // Import the controller

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your Email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _firstNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'First Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _lastNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Last Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: 'Mobile'),
                validator: (value) {
                  if ((value?.isEmpty ?? true) || (value!.length < 11)) {
                    return 'Enter a valid Mobile Number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
                validator: (value) {
                  if ((value?.isEmpty ?? true) || (value!.length < 5)) {
                    return 'Enter a Password with at least 5 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),

              GetBuilder<SignUpController>(
                builder: (signupController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: signupController.signupProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          signupController
                              .signUp(
                            _emailController.text.trim(),
                            _firstNameController.text.trim(),
                            _lastNameController.text.trim(),
                            _mobileController.text.trim(),
                            _passwordController.text,
                          )
                              .then((result) {
                            if (result == true) {
                              Get.offAll(const loginscrn());
                            } else {
                              Get.snackbar('Failed', 'Signup failed');
                            }
                          });
                        },
                        child: Icon(Icons.arrow_circle_right_rounded)
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an Account?"),
                  TextButton(
                    onPressed: () {

                      Get.off(const loginscrn());
                    },
                    child: Text("Sign in"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
