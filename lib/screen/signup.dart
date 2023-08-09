import 'dart:math';

import 'package:flutter/material.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/network/url.dart';
import 'package:module11/screen/forgetpass.dart';
import 'package:module11/screen/loginscreen.dart';

import '../widgets/backscreen.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();

}

class _signupState extends State<signup> {
  final TextEditingController _emailtecontroller = TextEditingController();
  final TextEditingController _fnametecontroller = TextEditingController();
  final TextEditingController _lnametecontroller = TextEditingController();
  final TextEditingController _numbertecontroller = TextEditingController();
  final TextEditingController _passtecontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _signupProgess = false;


  Future<void> usersignup() async {

    _signupProgess = true;
    if(mounted){
      setState(() {});
    }
    final Networkresponse response = await Networkcall().postRequest(urls.registrarion,<String,dynamic>{
      "email": _emailtecontroller.text.trim(),
      "firstName": _fnametecontroller.text.trim(),
      "lastName": _lnametecontroller.text.trim(),
      "mobile": _numbertecontroller.text.trim(),
      "password": _passtecontroller.text,
      "photo": "",
    });

print(response.body);
    if(response.issuccess){
      _emailtecontroller.clear();
    _fnametecontroller.clear();
    _lnametecontroller.clear();
    _numbertecontroller.clear();
    _passtecontroller.clear();
      if(mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration done ")));
      }
    }else{
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration failed ")));
      }
    }
    _signupProgess = false;
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: backimg(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Sign up ',
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
                  decoration: const InputDecoration(
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
                  controller: _fnametecontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your First Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _lnametecontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Last Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _numbertecontroller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || (value!.length < 11)) {
                      return 'Enter Valid Mobile Number';
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
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || (value!.length < 5)) {
                      return 'Enter your Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _signupProgess== false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {
                         if(!_formkey.currentState!.validate()){
                           return;
                         }
                         usersignup();
                        },
                        child: const Icon(Icons.arrow_circle_right_rounded)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an Account ?",
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
                        child: const Text("Sign in  ")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

