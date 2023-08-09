import 'package:flutter/material.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/screen/otpverification.dart';
import 'package:module11/widgets/backscreen.dart';

class forgetpass extends StatelessWidget {
  const forgetpass({super.key});

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
                'Your Email Address',
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
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),

              const SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> otpverify()));
                    },
                    child: Icon(Icons.arrow_circle_right_rounded)),
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
