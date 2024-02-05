import 'package:flutter/foundation.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/controller/traking_controller.dart';
import 'package:timesheet/screen/tiles/tracking_tile.dart';
import 'package:get/get.dart';
import 'package:timesheet/utils/app_constants.dart';
import '../../data/model/response/work_day.dart';
import '../common/CommonFunction.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<TrackingController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: GetBuilder<TrackingController>(
        builder: (controller) => Stack(
          children: [
            Opacity(
              opacity: controller.loading ? 0.6 : 1,
              child: Column(
                children: [
                  _filterBox(controller),
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

  //widgets
  _filterBox(TrackingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(15),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(3, 3))
      ]),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _selectFromDate(controller),
                    child: Text(getDisplayDateAndTime(controller.fromDate),
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
                const Icon(Icons.chevron_right),
                ElevatedButton(
                    onPressed: () => _selectToDate(controller),
                    child: Text(getDisplayDateAndTime(controller.toDate),
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Team',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: DropdownButton<String>(
                          value: controller.selectedTeam,
                          isExpanded: true,
                          items: controller.teamNameList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue != null) {
                                controller.selectedTeam = newValue;
                              }
                            });
                          }),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Member',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: DropdownButton<String>(
                          value: controller.selectedMember,
                          isExpanded: true,
                          items: controller.memberNameList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue != null) {
                                controller.selectedMember = newValue;
                              }
                            });
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _mainListBox(TrackingController controller) {
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
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: RefreshIndicator(
              onRefresh: () => controller.getWorkingDayList(),
              child: GroupedListView<WorkingDay, String>(
                elements: controller.workingDayList,
                groupBy: (WorkingDay workingDay) =>
                    _getDisplayDate(workingDay.dateWorking!),
                groupSeparatorBuilder: (String value) => Wrap(children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _getCorrespondingDateColor(value)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      value,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ]),
                itemBuilder: (context, workingDay) =>
                    TrackingTile(workingDay: workingDay),
              ),
            )),
      ),
    );
  }

  _displayOptions(TrackingController controller) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text('Page size',
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
                          Get.find<TrackingController>().pageSize = newValue;
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
                          Get.find<TrackingController>().pageIndex =
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
                    opacity: controller.pageIndex == controller.maxPages ? 0 : 1,
                    child: GestureDetector(
                      onTap: () {
                        if (controller.pageIndex < controller.maxPages) {
                          Get.find<TrackingController>().pageIndex =
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
    );
  }

  //actions
  _selectFromDate(TrackingController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.fromDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));

    if (pickedDate != null && pickedDate != controller.fromDate) {
      setState(() {
        controller.fromDate = pickedDate;
        if (kDebugMode) print(controller.fromDate.toString());
      });
    }
  }

  _selectToDate(TrackingController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.toDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));

    if (pickedDate != null && pickedDate != controller.toDate) {
      setState(() {
        controller.toDate = pickedDate;
        if (kDebugMode) print(controller.toDate.toString());
      });
    }
  }

  //util
  _getDisplayDate(String date) {
    List<String> data = date.split('-').toList();
    return '${data[2]}-${data[1]}-${data[0]}';
  }

  _getCorrespondingDateColor(String date) {
    List<int> data = date.split('-').map((e) => int.parse(e)).toList();
    DateTime dateTime = DateTime(data[0], data[1], data[2]);
    if (dateTime.weekday == 7 || dateTime.weekday == 6) {
      return Colors.red;
    } else {
      return Colors.lightBlueAccent.withOpacity(0.8);
    }
  }
}
