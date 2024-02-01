import 'package:flutter/material.dart';
import 'package:timesheet/data/model/response/work_day.dart';
import 'package:timesheet/screen/common/CommonWidgets.dart';

import '../../data/model/response/task.dart';
import '../../utils/images.dart';

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
                child: Image.asset(
                    workingDay.dayOff != null && workingDay.dayOff!
                        ? Images.off
                        : (workingDay.tasks != null
                            ? Images.working
                            : Images.idle))),
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
                        : const Text('No event',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                    if (workingDay.tasks != null && workingDay.dayOff == false)
                      Text('${workingDay.tasks!.length} task done',
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
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
    );
  }

  _calculateDisplayTaskNumber() {
    double total = 0;

    workingDay.tasks?.forEach((element) {
      total += element.officeHour + element.overtimeHour;
    });

    return total;
  }
}
