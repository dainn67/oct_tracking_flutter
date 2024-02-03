import 'package:flutter/material.dart';
import 'package:timesheet/screen/common/CommonWidgets.dart';
import 'package:timesheet/utils/images.dart';

import '../../data/model/response/Task.dart';

class ProjectTile extends StatelessWidget {
  final Project project;

  const ProjectTile({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _codeController = TextEditingController();
    TextEditingController _descController = TextEditingController();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(3, 3))
      ]),
      height: 68,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(_getCorrespondingStatusImage())),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.name,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    Text(project.code,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () => _showDetail(context, _nameController,
                        _codeController, _descController),
                    child: const Icon(Icons.edit, color: Colors.blue)),
                const SizedBox(width: 15),
                GestureDetector(
                    onTap: () => _confirmDelete(context),
                    child: const Icon(Icons.delete, color: Colors.red))
              ],
            )
          ],
        ),
      ),
    );
  }

  _getCorrespondingStatusImage() {
    switch (project.status) {
      case 'PENDING':
        return Images.pending;
      case 'WORKING':
        return Images.working_project;
      case 'FINISH':
        return Images.checked;
    }
  }

  _showDetail(
      BuildContext context,
      TextEditingController _nameController,
      TextEditingController _codeController,
      TextEditingController _descController) {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Wrap(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
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
                              project.code,
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
                              _buildTitle('Project code'),
                              _buildTextField(context, project.code, 'name',
                                  Images.lock, _nameController),
                              _buildTitle('Project status'),
                              _buildTextField(context, project.status, 'name',
                                  Images.lock, _codeController),
                              _buildTitle('Project description'),
                              _buildTextField(context, project.description,
                                  'name', Images.lock, _descController),
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
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Update')),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ));
  }

  _confirmDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Action'),
          content: const Text('Are you sure you want to perform this action?'),
          actions: [
            TextButton(
              onPressed: () {
                // Dismiss the dialog
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the action and then dismiss the dialog
                // _performAction();
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  _buildTextField(BuildContext context, String hint, String type,
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
