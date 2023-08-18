import 'package:get/get.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/network/url.dart';
import 'package:module11/utils/taskListModel.dart';


class DeletTaskController extends GetxController {
  bool _delettask = false;
  final TaskListModel _taskListModel = TaskListModel();

  bool get deletTaskProgress => _delettask;

  Future<bool> delettask(String taskid) async {
    final Networkresponse response =
        await Networkcall().getRequest(urls.deletetask(taskid));
    if (response.issuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskid);
      update();
      return true;
    } else {
      return false;
    }
  }
}