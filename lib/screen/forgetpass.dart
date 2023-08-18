import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/network/url.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/screen/otpverification.dart';
import 'package:module11/widgets/backscreen.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({super.key});

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  bool _emailVerficatinInProgress = false;
  final TextEditingController _emailTEController = TextEditingController();

  Future<void> sendOTPToEmail() async {
    _emailVerficatinInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Networkresponse response = await Networkcall()
        .getRequest(urls.emailverification(_emailTEController.text.trim()));
    _emailVerficatinInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.issuccess) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => otpverify(
                  email: _emailTEController.text.trim(),
                )));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email verification has been failed!')));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backimg(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 84,),
              const Text(
                'Enter your Email ',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                'A 6 digit verification pin will send to your email address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8,),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),

              const SizedBox(height: 16,),
          SizedBox(
            width: double.infinity,
            child: Visibility(
              visible: _emailVerficatinInProgress == false,
              replacement: const Center(child: CircularProgressIndicator(),),
              child: ElevatedButton(
                onPressed: () {
                  sendOTPToEmail();
                },
                child: const Icon(Icons.arrow_circle_right_outlined),
              ),
            ),
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have a Account ?",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),),
                  TextButton(onPressed: () {
                    Get.off(const loginscrn());

                  }, child: Text("Sign in ",style: TextStyle(fontWeight: FontWeight.w500),)),
                ],
              ),
            ],
          ),
        ),
      ),),
    );
  }
}
