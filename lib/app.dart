import 'package:flutter/material.dart';
import 'package:module11/screen/splashscrn.dart';

class TaskManager extends StatefulWidget {

  static GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

   TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: TaskManager.globalKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white54,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Color for disabled state
                }
                return Colors.blue; // Color for enabled state
              },
            ),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black54,
            padding: EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.deepPurpleAccent,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    themeMode: ThemeMode.light,
    home: splashscrn()
    ,
    );
  }
}