import 'package:flutter/material.dart';
import 'package:module11/network/url.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/screen/basescreen.dart';
import 'package:module11/screen/forgetpass.dart';
import 'package:module11/screen/signup.dart';
import 'package:module11/utils/signin_Model.dart';
import 'package:module11/utils/signindata.dart';

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

  bool _signin = false;

  Future<void> signin() async {
    _signin = true;
if(mounted){
  setState(() {

  });
}
    Map<String, dynamic> requestbody = {
      "email": _emailtecontroller.text.trim(),
      "password": _passtecontroller.text
    };
print(requestbody);
    final Networkresponse response =
        await Networkcall().postRequest(urls.login, requestbody , islogin:true );
    _signin = false;
    if(mounted){
      setState(() {

      });
    }
    if (response.issuccess) {
      Signinmodel model = Signinmodel.fromJson(response.body!);
      await Signindata.saveinfo(model);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const bottomnave()),
            (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Sign in Failed -_-")));
      }
    }
  }

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
                  if (value?.isEmpty ?? true)  {
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
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _signin == false,
                  replacement: const Center(child: CircularProgressIndicator(),),
                  child: ElevatedButton(
                      onPressed: () {
                        signin();
                      },
                      child: Icon(Icons.arrow_circle_right_rounded)),
                ),
              ),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgetpass()));
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => signup()));
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
