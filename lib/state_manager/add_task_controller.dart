import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/network/url.dart';


class AddNewTaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxBool newTaskInProgress = false.obs;

  void addNewTask() async {
    newTaskInProgress.value = true;

    Map<String, dynamic> requestBody = {
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "status": "New",
    };

    Networkresponse response = await Networkcall().postRequest(urls.addnewtask, requestBody);

    newTaskInProgress.value = false;

    if (response.issuccess) {
      titleController.clear();
      descriptionController.clear();
      Get.snackbar(
        'Task Status',
        'Task added successfully',
      );
    } else {
      Get.snackbar(
        'Task Status',
        'Task add failed',
        backgroundColor: Colors.red,
      );
    }
  }
}