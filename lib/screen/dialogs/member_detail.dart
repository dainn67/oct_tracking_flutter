import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/personnel_controller.dart';
import 'package:timesheet/data/model/response/member.dart';
import 'package:timesheet/screen/common/CommonFunction.dart';
import 'package:timesheet/screen/common/CommonWidgets.dart';
import 'package:timesheet/utils/app_constants.dart';
import '../../utils/images.dart';

class MemberDetail extends StatefulWidget {
  final Member member;

  const MemberDetail({super.key, required this.member});

  @override
  State<MemberDetail> createState() => _MemberDetailState();
}

class _MemberDetailState extends State<MemberDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String selectedGender = '';
  String selectedLevel = '';
  String selectedPosition = '';
  String selectedStatus = '';
  String selectedTeamName = '';
  String selectedType = '';

  @override
  Widget build(BuildContext context) {
    selectedGender = widget.member.gender.replaceAll('_', ' ');
    selectedLevel = widget.member.level.replaceAll('_', ' ');
    selectedPosition = widget.member.position.replaceAll('_', ' ');
    selectedStatus = widget.member.status.replaceAll('_', ' ');
    selectedTeamName = widget.member.team!.name.replaceAll('_', ' ');
    selectedType = widget.member.type.replaceAll('_', ' ');

    return Center(
      child: Wrap(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
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
                      widget.member.name,
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
                      _buildTextField(context, widget.member.name, 'name',
                          Images.lock, _nameController),
                      _buildTitle('email'.tr),
                      _buildTextField(context, widget.member.email, 'email',
                          Images.lock, _emailController),
                      _buildFixedData(),
                      _buildDropdownButton(
                          'position'.tr, 'position', AppConstants.positionList),
                      _buildDropdownButton(
                          'gender'.tr, 'gender', AppConstants.genderList),
                      _buildDropdownButton(
                          'type'.tr, 'type', AppConstants.typeList),
                      _buildDropdownButton(
                          'status'.tr, 'status', AppConstants.statusList),
                      _buildDropdownButton('team'.tr, 'team',
                          Get.find<PersonnelController>().teamNameList),
                      _buildDropdownButton(
                          'skill_level'.tr, 'skill', AppConstants.skillList),
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
                  ElevatedButton(
                      onPressed: () {
                        _updateMember();
                      },
                      child: Text('update'.tr)),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  _updateMember() {
    if (_nameController.text.isNotEmpty ||
        (_emailController.text.isNotEmpty && isEmailValid(_emailController.text))||
        selectedPosition != widget.member.position.replaceAll('_', ' ') ||
        selectedGender != widget.member.gender ||
        selectedType != widget.member.type.replaceAll('_', ' ') ||
        selectedStatus != widget.member.status ||
        selectedTeamName != widget.member.team!.name ||
        selectedLevel != widget.member.level
    ) {
      Get.find<PersonnelController>().updateMember(
          widget.member.id,
          widget.member.code,
          widget.member.dateJoin,
          _emailController.text.isEmpty
              ? widget.member.email
              : _emailController.text,
          selectedGender,
          selectedLevel,
          _nameController.text.isEmpty
              ? widget.member.name
              : _nameController.text,
          selectedPosition,
          selectedStatus,
          selectedTeamName,
          selectedType);
      Navigator.pop(context);
    } else {
      if(_emailController.text.isNotEmpty && !isEmailValid(_emailController.text)){
        showAlertDialog(context, 'invalid_email'.tr, 'invalid_email_detail'.tr);
      } else {
        showAlertDialog(context, 'no_change'.tr, 'no_change_detail'.tr);
      }
    }
  }

  //Local utils
  _buildFixedData(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle('date_joined'.tr),
                Text(widget.member.dateJoin,
                    style: const TextStyle(
                        fontSize: 18, color: Colors.green)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle('code'.tr),
                Text(widget.member.code,
                    style: const TextStyle(
                        fontSize: 18, color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTextField(BuildContext context, String? hint, String type,
      String imgPath, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 50,
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
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  _buildDropdownButton(String title, String valueType, List<String> items) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitle(title),
          SizedBox(
              width: 150,
              child: DropdownButton(
                isExpanded: true,
                value: _getCorrespondingValue(valueType),
                items: items
                    .map<DropdownMenuItem<String>>((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (newValue) => setState(() {
                  _setCorrespondingValue(valueType, newValue);
                }),
              )),
        ],
      ),
    );
  }

  void _setCorrespondingValue(String valueType, String? newValue) {
    if (newValue != null) {
      switch (valueType) {
        case 'position':
          selectedPosition = newValue;
        case 'gender':
          selectedGender = newValue;
        case 'type':
          selectedType = newValue;
        case 'status':
          selectedStatus = newValue;
        case 'skill':
          selectedLevel = newValue;
        case 'team':
          selectedTeamName = newValue;
      }
    }
  }

  String _getCorrespondingValue(String type) {
    switch (type) {
      case 'position':
        return selectedPosition;
      case 'gender':
        return selectedGender;
      case 'type':
        return selectedType;
      case 'status':
        return selectedStatus;
      case 'skill':
        return selectedLevel;
      case 'team':
        return selectedTeamName;
      default:
        return selectedPosition;
    }
  }
}
