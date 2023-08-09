import 'package:flutter/material.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/screen/updateTaskStatus.dart';
import 'package:module11/utils/taskListModel.dart';
import 'package:module11/widgets/listydesign.dart';
import 'package:module11/widgets/profile.dart';
import 'package:module11/network/url.dart';
import 'package:module11/widgets/taskcount.dart';
import '../utils/summarycountModel.dart';

class completed extends StatefulWidget {
  const completed({super.key});

  @override
  State<completed> createState() => _completedState();
}

class _completedState extends State<completed> {


  bool _getcountprogress = false,_getcompletedtask =false,_getnewtask =false;
  Summarycount _summarycount = Summarycount();
  TaskListModel _taskListModel = TaskListModel();


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCount();
      getcompletedtask();
    });
  }

  Future<void> getCount() async{
    _getcountprogress = true;
    if(mounted){
      setState(() {});
    }
    final Networkresponse response = await Networkcall().getRequest(urls.taskstatus);
    if(response.issuccess){
      _summarycount = Summarycount.fromJson(response.body!);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Summary faild')));
    }
    _getcountprogress = false;
    if(mounted){
      setState(() {});
    }

  }
  Future<void> getnewtask() async{
    _getnewtask = true;
    if(mounted){
      setState(() {});
    }
    final Networkresponse response = await Networkcall().getRequest(urls.newadttask);
    if(response.issuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Get new task faild')));
    }
    _getnewtask = false;
    if(mounted){
      setState(() {});
    }
  }

  Future<void> getcompletedtask() async{
    _getcompletedtask = true;
    if(mounted){
      setState(() {});
    }
    final Networkresponse response = await Networkcall().getRequest(urls.compleatedtask);
    if(response.issuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Get Completed task faild')));
    }
    _getcompletedtask = false;
    if(mounted){
      setState(() {});
    }
  }

  Future<void>delettask(String taskid) async{
    final Networkresponse response = await Networkcall().getRequest(urls.deletetask(taskid));
    if(response.issuccess){
      _taskListModel.data!.removeWhere((element) => element.sId == taskid);
      if(mounted){
        setState(() {

        });
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Deletion Failed')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const userinfo(),
            _getcountprogress
                ? const LinearProgressIndicator()
                : SizedBox(
              height: 80,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _summarycount.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: taskcount(
                      title: _summarycount.data![index].sId??'Completed',
                      number: _summarycount.data![index].sum??0,
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
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              getcompletedtask();
            },
            child: _getcompletedtask
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : ListView.separated(
              itemCount: _taskListModel.data?.length ?? 0,
              itemBuilder: (context, index) {
                return listdesign(
                  data: _taskListModel.data![index], onDeletTap: () { delettask(_taskListModel.data![index].sId!); }, onEditTap: () { statusdataBottomSheet(_taskListModel.data![index]); },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 4,
                );
              },
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
            _getnewtask;
          });
        });
  }
}
