import 'package:get/get.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/utils/taskListModel.dart';
import 'package:module11/network/url.dart';


class TaskkManageController extends GetxController{

  bool _updateTaskInProgress = false;
  bool _gettaskinprogress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get gettaskinprogress => _gettaskinprogress;
  TaskListModel get tasklistmodel => _taskListModel;

  Future<bool> getnewtask(String url) async{

    _gettaskinprogress = true;
    update();
    final Networkresponse response = await Networkcall().getRequest(url);
    _gettaskinprogress = false;
    update();
    if(response.issuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    }else{
      return false;
    }

  }

void updateScreen (){
    update();
}


  Future<bool>updatetask(String taskid, String newstatus) async{
    _updateTaskInProgress = true;
    update();


    final Networkresponse response = await Networkcall().getRequest(urls.updatetask(taskid,newstatus));

    _updateTaskInProgress = false;
    update();
    if(response.issuccess){

      _taskListModel.data?.removeWhere((element) => true);
      update();
      return true;
    }
    else{
      return false;
    }
  }

}