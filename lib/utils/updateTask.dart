import 'package:flutter/material.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/utils/taskListModel.dart';
import 'package:module11/network/url.dart';


class Updatetask extends StatefulWidget {

  final TaskData task;
  final VoidCallback onUpdate;

  const Updatetask({super.key, required this.task, required this.onUpdate});

  @override
  State<Updatetask> createState() => _UpdatetaskState();
}

class _UpdatetaskState extends State<Updatetask> {
  late  TextEditingController _titleEditcontroller ;

  late  TextEditingController _descriptionEditController ;

  bool _updatetaskprogress = false;

  void initState(){
    _titleEditcontroller = TextEditingController(text: widget.task.title);
    _descriptionEditController = TextEditingController(text:  widget.task.description);

    super.initState();
  }

  Future<void> updateTask() async{
    _updatetaskprogress = true;
    if(mounted){
      setState(() {});
    }
    Map<String,dynamic> requestbody = {
      "title":_titleEditcontroller.text.trim(),
      "description":_descriptionEditController.text.trim(),
    };
    final Networkresponse response = await Networkcall().postRequest(urls.addnewtask, requestbody);

    _updatetaskprogress = false;
    if(mounted){
      setState(() {});}

    if(response.issuccess){
      _titleEditcontroller.clear();
      _descriptionEditController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task update Successfully')));
        widget.onUpdate;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task update failed')));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Update Task',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),),
              Spacer(),
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.close))
            ],
          ),
          const SizedBox(height: 20,),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _titleEditcontroller,
            decoration: const InputDecoration(labelText: 'Title',border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _descriptionEditController,
            decoration: const InputDecoration(labelText: 'Description',border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: Visibility(
              visible: _updatetaskprogress == false,
              replacement: const Center(child: CircularProgressIndicator(),) ,
              child: ElevatedButton(
                onPressed: () {
                  updateTask();
                },
                child: const Icon(Icons.arrow_circle_right_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
