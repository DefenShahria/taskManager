import 'package:module11/utils/asset_utils.dart';
import 'package:flutter/material.dart';

class backimg extends StatelessWidget {
  final Widget child;
  const backimg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  assetutils.backgroundimg,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

class backimg2 extends StatelessWidget {
  final Widget child;
  const backimg2({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  assetutils.backgroundimg2,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}