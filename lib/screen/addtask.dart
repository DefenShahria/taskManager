import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/state_manager/add_task_controller.dart';
import 'package:module11/widgets/profile.dart';

class AddNewTaskPage extends StatelessWidget {
  final AddNewTaskController controller = Get.put(AddNewTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const userinfo(), // Assuming this is a widget you have defined
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50,),
                      const Text(
                        'Add New Task',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controller.titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value){
                          if(value?.isEmpty?? true){
                            return "*Enter subject";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 10,
                        controller: controller.descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value){
                          if(value?.isEmpty?? true){
                            return "*Enter description";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12,),
                      Obx(() {
                        return SizedBox(
                          width: double.infinity,
                          child: controller.newTaskInProgress.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                            onPressed: () {
                              controller.addNewTask();
                            },
                            child: const Icon(Icons.arrow_circle_right_rounded),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


