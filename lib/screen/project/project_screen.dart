import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/screen/dialogs/project_detail.dart';
import 'package:timesheet/screen/tiles/project_tile.dart';

import '../../controller/project_controller.dart';
import '../../utils/app_constants.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<ProjectController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: GetBuilder<ProjectController>(
        builder: (controller) => Stack(
          children: [
            Opacity(
              opacity: controller.loading ? 0.6 : 1,
              child: Column(
                children: [
                  _mainListBox(controller),
                  _displayOptions(controller)
                ],
              ),
            ),
            Center(
              child: Visibility(
                visible: controller.loading,
                child: const CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _mainListBox(ProjectController controller) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(2, 2))
        ]),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: RefreshIndicator(
              onRefresh: () => controller.getProjectList(),
              child: ListView.builder(
                  itemCount: controller.projectList.length,
                  itemBuilder: (context, index) =>
                      ProjectTile(project: controller.projectList[index])),
            )),
      ),
    );
  }

  _displayOptions(ProjectController controller) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 2,
            offset: const Offset(2, 2))
      ]),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text('page_size'.tr,
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 12),
                        DropdownButton<int>(
                            value: controller.pageSize,
                            items: AppConstants.pageSizes
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                Get.find<ProjectController>().pageSize =
                                    newValue;
                              }
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Opacity(
                          opacity: controller.pageIndex == 1 ? 0 : 1,
                          child: GestureDetector(
                            onTap: () {
                              if (controller.pageIndex > 1) {
                                Get.find<ProjectController>().pageIndex =
                                    controller.pageIndex - 1;
                              }
                            },
                            child: const Icon(Icons.chevron_left),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${'page'.tr} ${controller.pageIndex}',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Opacity(
                          opacity: controller.pageIndex == controller.maxPages
                              ? 0
                              : 1,
                          child: GestureDetector(
                            onTap: () {
                              if (controller.pageIndex < controller.maxPages) {
                                Get.find<ProjectController>().pageIndex =
                                    controller.pageIndex + 1;
                              }
                            },
                            child: const Icon(Icons.chevron_right),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => const ProjectDetail());
                    },
                    child: Text('add_new'.tr))),
          ],
        ),
      ),
    );
  }
}
