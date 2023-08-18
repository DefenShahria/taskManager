import 'package:get/get.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/utils/summarycountModel.dart';
import 'package:module11/network/url.dart';

class SummeryCountController extends GetxController {
  bool _getcountprogress = false;
  Summarycount _summarycount = Summarycount();

  bool get getCountinProgress => _getcountprogress;

  Summarycount get summarycount => _summarycount;

  Future<bool> getCount() async {
    _getcountprogress = true;
    update();
    final Networkresponse response =
        await Networkcall().getRequest(urls.taskstatus);
    _getcountprogress = false;

    if (response.issuccess) {
      _summarycount = Summarycount.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
    _getcountprogress = false;
  }
}
