import 'package:flutter/material.dart';
import 'package:timesheet/data/model/response/Task.dart';
import 'package:timesheet/data/model/response/work_day.dart';
import '../../utils/images.dart';
import 'package:get/get.dart';
import 'dart:core';

class TrackingTile extends StatelessWidget {
  final WorkingDay workingDay;

  const TrackingTile({super.key, required this.workingDay});

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
      child: GestureDetector(
        onTap: () {
          if (workingDay.id != null && workingDay.dayOff != true) {
            _showDetail(context);
          }
        },
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
                  child: _getCorrespondingLeadingImage()),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      workingDay.id != null
                          ? Text(workingDay.member!.name,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold))
                          : Text('no_event'.tr,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                      if (workingDay.tasks != null &&
                          workingDay.dayOff == false)
                        Text('${workingDay.tasks!.length} ${'task_done'.tr}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              if (workingDay.tasks != null && workingDay.dayOff == false)
                Row(
                  children: [
                    SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(Images.office_hour)),
                    const SizedBox(width: 10),
                    Text(
                      _calculateDisplayTaskNumber().toString(),
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  _getCorrespondingLeadingImage() {
    return Image.asset(workingDay.dayOff != null && workingDay.dayOff!
        ? Images.off
        : (workingDay.tasks != null ? Images.working : Images.idle));
  }

  _showDetail(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Wrap(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
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
                              workingDay.member!.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Material(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: ListView.builder(
                              itemCount: workingDay.tasks!.length,
                              itemBuilder: (context, index) =>
                                  _customTaskTile(workingDay.tasks![index])),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ));
  }

  _calculateDisplayTaskNumber() {
    double total = 0;

    workingDay.tasks?.forEach((element) {
      total += element.officeHour + element.overtimeHour;
    });

    return total;
  }

  _customTaskTile(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Container(
                  height: 30,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(task.project.code,
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset(Images.office_hour),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'office_hour'.tr,
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                      '${task.officeHour} ${'hours'.tr}')
                ],
              ),
              const SizedBox(height: 30),
              Text(task.taskOffice),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Image.asset(Images.overtime_hour),
                      ),
                      const SizedBox(width: 10),
                      Text('overtime_hour'.tr,
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text(
                      '${task.overtimeHour} ${'hours'.tr}')
                ],
              ),
              const SizedBox(height: 30),
              Text(task.taskOverTime),
            ],
          )
        ],
      ),
    );
  }
}
