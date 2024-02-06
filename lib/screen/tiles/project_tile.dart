import 'package:flutter/material.dart';
import 'package:timesheet/controller/project_controller.dart';
import 'package:timesheet/screen/dialogs/confirm_delete.dart';
import 'package:timesheet/screen/dialogs/project_detail.dart';
import 'package:timesheet/utils/images.dart';
import 'package:get/get.dart';

import '../../data/model/response/Task.dart';

class ProjectTile extends StatefulWidget {
  final Project project;

  const ProjectTile({super.key, required this.project});

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {

  @override
  Widget build(BuildContext context) {
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
                    Text(widget.project.name,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    Text(widget.project.code,
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
                    onTap: () => _showDetail(context),
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
    switch (widget.project.status) {
      case 'PENDING':
        return Images.pending;
      case 'WORKING':
        return Images.working_project;
      case 'FINISH':
        return Images.checked;
    }
  }

  _showDetail(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => GetBuilder<ProjectController>(
          builder: (controller) => ProjectDetail(project: widget.project,)
        ));
  }

  _confirmDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDelete(callback: () {
          Get.find<ProjectController>().deleteProject(widget.project.id);
        });
      },
    );
  }
}
