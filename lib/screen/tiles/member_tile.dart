import 'package:flutter/material.dart';
import 'package:timesheet/data/model/response/member.dart';
import 'package:timesheet/screen/common/CommonWidgets.dart';
import 'package:timesheet/utils/images.dart';

class MemberTile extends StatelessWidget {
  final Member member;

  const MemberTile({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 7, left: 40),
              padding: const EdgeInsets.only(left: 45, right: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(member.name,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Text('${member.type} (${member.email})',
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ],
                  )),
                  SizedBox(
                    width: 36,
                    child: Image.asset(Images.edit_icon),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
              height: 70, width: 70, child: _getCorrespondingGenderImage()),
        ],
      ),
    );
  }

  _getCorrespondingGenderImage() {
    switch (member.gender) {
      case 'MALE':
        return Image.asset(Images.male);
      case 'FEMALE':
        return Image.asset(Images.female);
      case 'LGBT':
        return Image.asset(Images.lgbtq);
      case 'OTHER':
        return Image.asset(Images.other);
    }
  }
}
