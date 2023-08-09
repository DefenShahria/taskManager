import 'package:flutter/material.dart';

class taskcount extends StatelessWidget {
  const taskcount({
    super.key,
    required this.title,
    required this.number,
  });

  final String title;
  final int number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Text(
                '$number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(title,style: TextStyle(fontSize: 12),),
            ],
          ),
        ),
      ),
    );
  }
}