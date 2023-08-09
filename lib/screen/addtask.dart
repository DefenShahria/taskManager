import 'package:flutter/material.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:module11/network/url.dart';
import 'package:module11/widgets/profile.dart';

class addnewtask extends StatefulWidget {
  const addnewtask({super.key});

  @override
  State<addnewtask> createState() => _addnewtaskState();
}

class _addnewtaskState extends State<addnewtask> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _newtaskinprogress = false;

  Future<void> addnewtask() async{
    _newtaskinprogress = true;
    if(mounted){
      setState(() {});
    }
    Map<String,dynamic> requestbody = {
      "title":_titlecontroller.text.trim(),
      "description":_descriptionController.text.trim(),
      "status":"New"
    };
    final Networkresponse response = await Networkcall().postRequest(urls.addnewtask, requestbody);

    _newtaskinprogress = false;
    if(mounted){
      setState(() {});}

    if(response.issuccess){
      _titlecontroller.clear();
      _descriptionController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task added Successfully')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task add failed')));

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const userinfo(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 90,),
                    const Text('Add New Task',style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                    ),),
                    const SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _titlecontroller,
                      decoration: const InputDecoration(labelText: 'Title',border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Description',border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _newtaskinprogress == false,
                        replacement: const Center(child: CircularProgressIndicator(),) ,
                        child: ElevatedButton(
                          onPressed: () {
                            addnewtask();
                          },
                          child: const Icon(Icons.arrow_circle_right_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
