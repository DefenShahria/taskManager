import 'package:flutter/material.dart';
import 'package:module11/screen/forgetpass.dart';
import 'package:module11/screen/loginscreen.dart';

import '../widgets/backscreen.dart';

class setpass extends StatelessWidget {
  const setpass({super.key});

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
              const SizedBox(height: 90,),
              const Text(
                'Set Password',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                'Minimum password should be 8 latter ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8,),
             const TextField(
               keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'New password',
                ),
              ),

              const SizedBox(height: 12,),

              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscrn()));

                    },
                    child: Text('Confirm')),
              ),
              Center(child: TextButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>forgetpass()));
              }, child: Text('Forgot Password?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have an Account ?",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscrn()));
                  }, child: Text("Sign in ")),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
