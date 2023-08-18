import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/state_manager/task_manage_controller.dart';
import 'package:module11/utils/taskListModel.dart';


class updateTaskStatus extends StatefulWidget {
  final TaskData task;
  final VoidCallback onupdate;
  const updateTaskStatus({super.key, required this.task, required this.onupdate});

  @override
  State<updateTaskStatus> createState() => _updateTaskStatusState();
}

class _updateTaskStatusState extends State<updateTaskStatus> {
  List<String> TaskStatus =['New', 'Progress','Cancel','Completed'];
   late String _selectedTask;
   bool updateTaskprog = false;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }
  // Future<void>updatetask(String taskid, String newstatus) async{
  //   updateTaskprog = true;
  //   if(mounted) {
  //     setState(() {});
  //   }
  //   print(newstatus);
  //   print(taskid);
  //   final Networkresponse response = await Networkcall().getRequest(urls.updatetask(taskid,newstatus));
  //   print(response.body);
  //   updateTaskprog = false;
  //   if(mounted) {
  //     setState(() {});
  //   }
  //   if(response.issuccess){
  //     widget.onupdate();
  //     if(mounted) {
  //       Navigator.pop(context);
  //     }
  //     }
  //   else{
  //     if(mounted){
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text('Update Failed')));
  //     }
  //   }
  // }


  final TaskkManageController taskkManageController = Get.find<TaskkManageController>();



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          Padding(padding:EdgeInsets.all(16),
            child :Text('Update Status'),),
          Expanded(
            child: ListView.builder(
                itemCount: TaskStatus.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      _selectedTask = TaskStatus[index];

                      setState(() {

                      });
                    },
                    title: Text(TaskStatus[index].toUpperCase()),
                    trailing: _selectedTask == TaskStatus[index]? const Icon(Icons.check) : null,
                  );
                }),
          ),

          SizedBox(
            width: double.infinity,
            child: Visibility(
              visible: updateTaskprog == false,
              replacement: const Center(child: CircularProgressIndicator(),) ,
              child: ElevatedButton(
                onPressed: () {
                  taskkManageController.updatetask(widget.task.sId!, _selectedTask);
                },
                child: const Icon(Icons.update),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
