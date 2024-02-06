import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/data/model/response/user.dart';
import '../../controller/project_controller.dart';
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
          height: MediaQuery.of(context).size.height * 0.8,
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
                      widget.user?.username ?? 'New user',
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
                        _buildTitle('Username'),
                        _buildTextField(context, widget.user?.username, 'name',
                            Images.lock, _nameController),
                        _buildTitle('Email'),
                        _buildTextField(context, widget.user?.email, 'email',
                            Images.lock, _emailController),
                        if (widget.user == null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTitle('Password'),
                              _buildTextField(context, widget.user?.email,
                                  'password', Images.lock, _passwordController),
                              _buildTitle('Confirm password'),
                              _buildTextField(
                                  context,
                                  widget.user?.email,
                                  'password',
                                  Images.lock,
                                  _confirmPassController),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTitle('Gender'),
                                  _buildGenderOptions()
                                ],
                              ),
                              const SizedBox(height: 10),
                              _buildTitle('Role'),
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
              if (widget.user != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                    const SizedBox(width: 15),
                    ElevatedButton(
                        onPressed: () {
                          _addNew();
                          Navigator.pop(context);
                        },
                        child: Text(widget.user != null ? 'Update' : 'Add')),
                  ],
                )
            ],
          ),
        ),
      ]),
    );
  }

  _addNew() {
    Get.find<UserController>().addUser(_nameController.text,
        _emailController.text, _passwordController.text, selectedGender, roles);
  }

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
          title: const Text('Admin'),
          value: roles[0],
          onChanged: (bool? value) {
            setState(() {
              roles[0] = value!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Accountant'),
          value: roles[1],
          onChanged: (bool? value) {
            setState(() {
              roles[1] = value!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Manager'),
          value: roles[2],
          onChanged: (bool? value) {
            setState(() {
              roles[2] = value!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Staff'),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: Colors.grey.shade200),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
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
          children: [
            Row(
              children: [
                Checkbox(
                    value: widget.user!.roles!.contains('ROLE_ADMIN'),
                    onChanged: (bool? newValue) {}),
                Text('Admin')
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: widget.user!.roles!.contains('ROLE_ACCOUNTANT'),
                    onChanged: (bool? newValue) {}),
                Text('Accountant')
              ],
            ),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Checkbox(
                    value: widget.user!.roles!.contains('ROLE_MANAGER'),
                    onChanged: (bool? newValue) {}),
                Text('Manager')
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: widget.user!.roles!.contains('ROLE_STAFF'),
                    onChanged: (bool? newValue) {}),
                Text('Staff')
              ],
            ),
          ],
        ),
      ],
    );
  }
}
