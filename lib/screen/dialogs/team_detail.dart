import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/personnel_controller.dart';
import 'package:timesheet/data/model/response/team.dart';
import '../../utils/images.dart';

class TeamDetail extends StatefulWidget {
  final Team team;

  const TeamDetail({super.key, required this.team});

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlueAccent),
                  child: Center(
                    child: Text(
                      widget.team.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(
                  child: Material(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle('name'.tr),
                      _buildTextField(context, widget.team.name, 'name',
                          Images.lock, _nameController),
                      _buildTitle('code'.tr),
                      _buildTextField(context, widget.team.code, 'code',
                          Images.lock, _codeController),
                      _buildTitle('desc'.tr),
                      _buildTextField(context, widget.team.description, 'desc',
                          Images.lock, _descController)
                    ],
                  ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('cancel'.tr)),
                  const SizedBox(width: 15),
                  ElevatedButton(onPressed: _update, child: Text('update'.tr)),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  _update() {
    if (_nameController.text.isNotEmpty ||
        _codeController.text.isNotEmpty ||
        _descController.text.isNotEmpty) {
      Get.find<PersonnelController>().updateTeam(
          widget.team.id,
          _codeController.text.isEmpty
              ? widget.team.code
              : _codeController.text,
          _nameController.text.isEmpty
              ? widget.team.name
              : _nameController.text,
          _descController.text.isEmpty
              ? widget.team.description
              : _descController.text);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Finish all information')));
    }
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
}
