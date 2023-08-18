import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/screen/splashscrn.dart';
import 'package:module11/state_manager/Summery_Count_controller.dart';
import 'package:module11/state_manager/deletTaskController.dart';
import 'package:module11/state_manager/signin_controller.dart';
import 'package:module11/state_manager/signup_controller.dart';
import 'package:module11/state_manager/task_manage_controller.dart';

import 'state_manager/updateProfile_Controller.dart';
import 'utils/signindata.dart';

class TaskManager extends StatefulWidget {

  static GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

   const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

      ),
      initialBinding: ControllerBinding(),
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    themeMode: ThemeMode.light,
    home: const splashscrn()
    ,
    );
  }
}

class ControllerBinding extends Bindings{
  @override
  void dependencies() {

    Get.put<SignInController>(SignInController());
    Get.put<SummeryCountController>(SummeryCountController());
    Get.put<TaskkManageController>(TaskkManageController());
    Get.put<DeletTaskController>(DeletTaskController());
    Get.put<SignUpController>(SignUpController());
    Get.put<Signindata>(Signindata());
    Get.put<ProfileUpdateController>(ProfileUpdateController());

  }

}