import 'package:flutter/material.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/screen/setpass.dart';
import 'package:module11/widgets/backscreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class otpverify extends StatelessWidget {
  const otpverify({super.key});

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
                'PIN Verification',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                'Give the given PIN on your Email',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8,),
              PinCodeTextField(
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
                onCompleted: (v) {

                },
                onChanged: (value) {

                },
                beforeTextPaste: (text) {
                 // print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                }, appContext: context,
              ),

              const SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>setpass()));
                    },
                    child: const Text('Verify'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have a Account ?",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscrn()));
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
