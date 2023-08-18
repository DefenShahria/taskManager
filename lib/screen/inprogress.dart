import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/screen/updateTaskStatus.dart';
import 'package:module11/state_manager/Summery_Count_controller.dart';
import 'package:module11/state_manager/deletTaskController.dart';
import 'package:module11/state_manager/task_manage_controller.dart';
import 'package:module11/utils/summarycountModel.dart';
import 'package:module11/utils/taskListModel.dart';
import 'package:module11/utils/updateTask.dart';
import 'package:module11/widgets/listydesign.dart';
import 'package:module11/widgets/profile.dart';
import 'package:module11/widgets/taskcount.dart';
import 'package:module11/network/url.dart';


class Inprogress extends StatefulWidget {
  const Inprogress({super.key});

  @override
  State<Inprogress> createState() => _InprogressState();
}

class _InprogressState extends State<Inprogress> {


  TaskListModel _taskListModel = TaskListModel();

  final SummeryCountController _summarycountcontroller = Get.find<SummeryCountController>();
  final TaskkManageController _taskkManageController = Get.find<TaskkManageController>();
  final DeletTaskController _deletTaskController = Get.find<DeletTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _summarycountcontroller.getCount();
      _taskkManageController.getnewtask(urls.progesstask);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const userinfo(),
             SizedBox(
               height: 90,
               child: GetBuilder<SummeryCountController>(
                 builder: (_) {
                   if(_summarycountcontroller.getCountinProgress){
                     return const Center(
                       child: LinearProgressIndicator(),
                     );
                   }
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _summarycountcontroller.summarycount.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return SizedBox(
                          child: taskcount(
                            title: _summarycountcontroller
                                    .summarycount.data![index].sId ??
                                'Progress',
                            number: _summarycountcontroller
                                    .summarycount.data![index].sum ??
                                0,
                          ),
                        );
                      },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
            ),
                   );
                 }
               ),
             ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _taskkManageController.getnewtask(urls.progesstask);
                  _summarycountcontroller.getCount();
                },
                child: GetBuilder<TaskkManageController>(

                    builder: (_) {
                      return _taskkManageController.gettaskinprogress
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ListView.separated(
                        itemCount: _taskkManageController.tasklistmodel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return listdesign(
                            data: _taskkManageController.tasklistmodel.data![index],
                            onDeletTap: () {
                              _deletTaskController.delettask(_taskkManageController.tasklistmodel.data![index].sId!);
                            }, onEditTap: () {
                            statusdataBottomSheet(_taskkManageController.tasklistmodel.data![index]);
                          },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }




  void statusdataBottomSheet(TaskData task){

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return updateTaskStatus(task: task, onupdate: (){
            _taskkManageController.gettaskinprogress;
          });
        });
  }
}
