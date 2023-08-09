import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:module11/network/networkcall.dart';
import 'package:module11/network/networkresponse.dart';
import 'package:module11/utils/signin_Model.dart';
import 'package:module11/utils/signindata.dart';
import 'package:module11/widgets/profile.dart';
import '../utils/signindata.dart';
import 'package:image_picker/image_picker.dart';
import 'package:module11/network/url.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _firstNameETController = TextEditingController();
  final TextEditingController _lastNameETController = TextEditingController();
  final TextEditingController _mobileETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

  bool _inProgress = false;
  XFile? pickedImage;
  String? base64Image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailETController.text = Signindata.userinfo.data?.email ?? '';
    _firstNameETController.text = Signindata.userinfo.data?.firstName ?? '';
    _lastNameETController.text = Signindata.userinfo.data?.lastName ?? '';
    _mobileETController.text = Signindata.userinfo.data?.mobile ?? '';
  }

  void updateProfile() async {
    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    _inProgress = true;
    setState(() {});

    Map<String, String> body = {
      "firstName": _firstNameETController.text.trim(),
      "lastName": _lastNameETController.text.trim(),
      "mobile": _mobileETController.text.trim(),
    };

    if (_passwordETController.text.isNotEmpty) {
      body['password'] = _passwordETController.text;
    }

    final Networkresponse response =
        await Networkcall().postRequest(urls.profileupdate, body);

    if (response.issuccess) {
      Signindata.userinfo.data!.firstName = _firstNameETController.text.trim();
      Signindata.userinfo.data!.lastName = _lastNameETController.text.trim();
      Signindata.userinfo.data!.mobile = _mobileETController.text.trim();
      Signindata.updateInfo(Signindata.userinfo as Data);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile update successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profile update failed')));
    }
    _inProgress = false;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text("Update Profile"),
                  const SizedBox(
                    height: 8,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            imagePicker();
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    )),
                                child: Text('Photo',
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      )),
                                  child: Text(
                                    pickedImage?.name ?? '',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _emailETController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _firstNameETController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your First Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _lastNameETController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your Last Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _mobileETController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Mobile',
                          ),
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                (value!.length < 11)) {
                              return 'Enter Valid Mobile Number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _passwordETController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                (value!.length < 5)) {
                              return 'Enter your Password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  updateProfile();
                                },
                                child: const Icon(
                                    Icons.arrow_circle_right_rounded)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void imagePicker() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  pickedImage =
                      await ImagePicker().pickImage(source: ImageSource.camera);

                  if (mounted) {
                    if (pickedImage != null) {
                      setState(() {});
                      Navigator.pop(context);
                    }
                  }
                },
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (mounted) {
                    if (pickedImage != null) {
                      setState(() {});
                      Navigator.pop(context);
                    }
                  }
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ));
        });
  }
}
