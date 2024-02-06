import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/project_controller.dart';
import '../../data/model/response/Task.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';

class ProjectDetail extends StatefulWidget {
  final Project? project;

  const ProjectDetail({super.key, this.project});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String selectedStatus = '';

  @override
  Widget build(BuildContext context) {
    selectedStatus = widget.project?.status ?? 'PENDING';

    return Center(
      child: Wrap(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlueAccent),
                  child: Center(
                    child: Text(
                      widget.project?.code ?? 'New project',
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
                          _buildTitle('Project name'),
                          _buildTextField(context, widget.project?.name, 'name',
                              Images.lock, _nameController),
                          _buildTitle('Project code'),
                          _buildTextField(context, widget.project?.code, 'code',
                              Images.lock, _codeController),
                          _buildTitle('Project description'),
                          _buildTextField(context, widget.project?.description,
                              'desc', Images.lock, _descController),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTitle('Project status'),
                              _buildStatusOptions(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  const SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: () {
                        _updateOrAddNew();
                        Navigator.pop(context);
                      },
                      child: Text(widget.project != null ? 'Update' : 'Add')),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  _updateOrAddNew() {
    if(widget.project != null){
      Get.find<ProjectController>().updateProject(
          widget.project!.id,
          _codeController.text.isEmpty ? widget.project!.code : _codeController.text,
          _nameController.text.isEmpty ? widget.project!.name : _nameController.text,
          _descController.text.isEmpty
              ? widget.project!.description
              : _descController.text,
          selectedStatus);
    } else {
      Get.find<ProjectController>().addNewProject(
        _nameController.text,
        _codeController.text,
        selectedStatus,
        _descController.text
      );
    }
  }

  _buildStatusOptions() {
    return StatefulBuilder(
      builder: (context, setState) => Wrap(
        children: [
          Container(
            // width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: DropdownButton<String>(
                  value: selectedStatus,
                  items: AppConstants.projectStatusOptions
                      .map<DropdownMenuItem<String>>((String option) =>
                      DropdownMenuItem<String>(value: option, child: Text(option)))
                      .toList(),
                  onChanged: (String? newStatus) {
                    if (newStatus != null){
                      setState(() {
                        selectedStatus = newStatus;
                      });
                    }
                  }),
            ),
          ),
        ]
      ),
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
}
