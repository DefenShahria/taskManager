import 'package:flutter/material.dart';
import 'package:module11/app.dart';
import 'package:module11/screen/basescreen.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/utils/asset_utils.dart';
import 'package:module11/utils/signindata.dart';
import 'package:get/get.dart';

class splashscrn extends StatefulWidget {
  const splashscrn({super.key});

  @override
  State<splashscrn> createState() => _splashscrnState();
}

class _splashscrnState extends State<splashscrn> {



final Signindata signindata = Get.find<Signindata>();


  @override
  void initState() {
    super.initState();
    navigatetologin();
  }

  void navigatetologin() {
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedin = await signindata.checkinfo();
      if(mounted){
        Get.offAll(isLoggedin ? const BottomNave() : const loginscrn());
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  assetutils.splitscrn,
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Center(
          child: Image.asset(
            assetutils.logopng,
            height: 260,
            fit: BoxFit.scaleDown,
          ),
        )
      ]),
    );
  }
}
