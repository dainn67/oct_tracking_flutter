import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/data/model/response/user.dart';
import 'package:timesheet/screen/common/CommonFunction.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';

class UserDetail extends StatefulWidget {
  final User? user;

  const UserDetail({super.key, this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  String selectedGender = 'MALE';
  List<bool> roles = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(children: [
        Container(
          height: MediaQuery.of(context).size.height *
              (widget.user == null ? 0.8 : 0.45),
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlueAccent),
                  child: Center(
                    child: Text(
                      widget.user?.username ?? 'new_user'.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(
                  child: Material(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle('username'.tr),
                        _buildTextField(
                            context,
                            widget.user?.username ?? 'enter_username'.tr,
                            'name',
                            Images.lock,
                            _nameController),
                        _buildTitle('email'.tr),
                        _buildTextField(
                            context,
                            widget.user?.email ?? 'enter_email'.tr,
                            'email',
                            Images.lock,
                            _emailController),
                        if (widget.user == null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTitle('password'.tr),
                              _buildTextField(context, 'enter_pass'.tr,
                                  'password', Images.lock, _passwordController),
                              _buildTitle('confirm_pass'.tr),
                              _buildTextField(
                                  context,
                                  'confirm_pass_hint'.tr,
                                  'password',
                                  Images.lock,
                                  _confirmPassController),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTitle('gender'.tr),
                                  _buildGenderOptions()
                                ],
                              ),
                              const SizedBox(height: 10),
                              _buildTitle('role'.tr),
                              _buildRoleOptions()
                            ],
                          )
                        else
                          _buildRoles()
                      ],
                    ),
                  ),
                ),
              )),
              if (widget.user == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('cancel'.tr)),
                    const SizedBox(width: 15),
                    ElevatedButton(
                        onPressed: _addNew,
                        child:
                            Text(widget.user != null ? 'update'.tr : 'add'.tr)),
                  ],
                )
            ],
          ),
        ),
      ]),
    );
  }

  _addNew() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPassController.text.isNotEmpty &&
        _passwordController.text == _confirmPassController.text &&
        isEmailValid(_emailController.text) &&
        roles.contains(true)) {
      Get.find<UserController>().addUser(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          selectedGender,
          roles);
      Navigator.pop(context);
    } else {
      if (_emailController.text.isNotEmpty &&
          !isEmailValid(_emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email format')));
      } else if (_passwordController.text != _confirmPassController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong confirm password')));
      } else if (!roles.contains(true)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Select roles')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Fill in all fields')));
      }
    }
  }

  //Local utils
  _buildGenderOptions() {
    return StatefulBuilder(
      builder: (context, setState) => Wrap(children: [
        Container(
          // width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: DropdownButton<String>(
                value: selectedGender,
                items: AppConstants.genderList
                    .map<DropdownMenuItem<String>>((String option) =>
                        DropdownMenuItem<String>(
                            value: option, child: Text(option)))
                    .toList(),
                onChanged: (String? newGender) {
                  if (newGender != null) {
                    setState(() {
                      selectedGender = newGender;
                    });
                  }
                }),
          ),
        ),
      ]),
    );
  }

  _buildRoleOptions() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('admin'.tr),
          value: roles[0],
          onChanged: (bool? value) {
            setState(() {
              roles[0] = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text('accountant'.tr),
          value: roles[1],
          onChanged: (bool? value) {
            setState(() {
              roles[1] = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text('manager'.tr),
          value: roles[2],
          onChanged: (bool? value) {
            setState(() {
              roles[2] = value!;
            });
          },
        ),
        CheckboxListTile(
          title: Text('staff'.tr),
          value: roles[3],
          onChanged: (bool? value) {
            setState(() {
              roles[3] = value!;
            });
          },
        ),
      ],
    );
  }

  _buildTextField(BuildContext context, String? hint, String type,
      String imgPath, TextEditingController controller) {
    String? errorText;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: Colors.grey.shade200),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          enabled: widget.user == null,
          controller: controller,
          onChanged: (value) {},
          obscureText: type == "password",
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent))),
        ),
      ),
    );
  }

  _buildTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 5),
      child: Text(title,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14)),
    );
  }

  _buildRoles() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                    value: widget.user!.roles!.contains('ROLE_ADMIN'),
                    onChanged: (bool? newValue) {}),
                Text('admin'.tr)
              ],
            ),
            SizedBox(
              width: 160,
              child: Row(
                children: [
                  Checkbox(
                      value: widget.user!.roles!.contains('ROLE_ACCOUNTANT'),
                      onChanged: (bool? newValue) {}),
                  Text('accountant'.tr)
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                    value: widget.user!.roles!.contains('ROLE_MANAGER'),
                    onChanged: (bool? newValue) {}),
                Text('manager'.tr)
              ],
            ),
            SizedBox(
              width: 160,
              child: Row(
                children: [
                  Checkbox(
                      value: widget.user!.roles!.contains('ROLE_STAFF'),
                      onChanged: (bool? newValue) {}),
                  Text('staff'.tr)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
