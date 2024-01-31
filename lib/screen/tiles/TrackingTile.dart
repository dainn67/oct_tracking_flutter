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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: const Offset(3, 3))
        ]
      ),
      height: 68,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            SizedBox(height: 30, width: 30, child: Image.asset(Images.working)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(workingDay.member.name, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    Text('${workingDay.tasks.length} task done', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(height: 24, width: 24, child: Image.asset(Images.office_hour)),
                const SizedBox(width: 10),
                reusableText(_calculateDisplayTaskNumber())
              ],
            )
          ],
        ),
      ),
    );
  }

  _calculateDisplayTaskNumber(){
    double total = 0;
    // for(Task task in workingDay.tasks){
    //   total += task.officeHour + task.overtimeHour;
    // }

    return total;
  }
}
