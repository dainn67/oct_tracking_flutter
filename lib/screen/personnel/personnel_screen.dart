import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:timesheet/controller/personnel_controller.dart';
import 'package:timesheet/screen/tiles/team_tile.dart';

import '../../utils/app_constants.dart';
import '../tiles/member_tile.dart';

class PersonnelScreen extends StatefulWidget {
  const PersonnelScreen({super.key});

  @override
  State<PersonnelScreen> createState() => _PersonnelScreenState();
}

class _PersonnelScreenState extends State<PersonnelScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<PersonnelController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonnelController>(
      builder: (controller) => Stack(
        children: [
          Opacity(
            opacity: controller.loading ? 0.6 : 1,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: GNav(
                      padding: const EdgeInsets.all(20),
                      gap: 30,
                      hoverColor: Colors.grey,
                      tabBorder: Border.all(color: Colors.black),
                      onTabChange: (index) {
                        index == 0 ? controller.resetTeamOptions() : controller.resetMemberOptions();
                      },
                      tabs: const [
                        GButton(icon: Icons.group, text: 'Team', ),
                        GButton(icon: Icons.man, text: 'Member')
                      ]),
                ),
                controller.pageCategory == 0
                    ? _mainTeamListBox(controller)
                    : _mainMemberListBox(controller),
                _teamDisplayOptions(controller)
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
    );
  }

  _mainTeamListBox(PersonnelController controller) {
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
              onRefresh: () => controller.getTeamList(),
              child: ListView.builder(
                  itemCount: controller.teamList.length,
                  itemBuilder: (context, index) =>
                      TeamTile(team: controller.teamList[index])),
            )),
      ),
    );
  }

  _mainMemberListBox(PersonnelController controller) {
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
              onRefresh: () => controller.getMemberList(),
              child: ListView.builder(
                  itemCount: controller.memberList.length,
                  itemBuilder: (context, index) =>
                      MemberTile(member: controller.memberList[index])),
            )),
      ),
    );
  }

  _teamDisplayOptions(PersonnelController controller) {
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
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text('Size',
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
                            Get.find<PersonnelController>().pageSize = newValue;
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
                            Get.find<PersonnelController>().pageIndex =
                                controller.pageIndex - 1;
                          }
                        },
                        child: const Icon(Icons.chevron_left),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Page ${controller.pageIndex}',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Opacity(
                      opacity:
                          controller.pageIndex == controller.maxPages ? 0 : 1,
                      child: GestureDetector(
                        onTap: () {
                          if (controller.pageIndex < controller.maxPages) {
                            Get.find<PersonnelController>().pageIndex =
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
      ),
    );
  }
}
