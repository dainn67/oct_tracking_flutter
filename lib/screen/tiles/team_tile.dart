import 'package:flutter/material.dart';
import 'package:timesheet/screen/dialogs/team_detail.dart';

import '../../data/model/response/team.dart';
import '../../utils/images.dart';

class TeamTile extends StatelessWidget {
  final Team team;

  const TeamTile({super.key, required this.team});

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
            SizedBox(height: 50, child: Image.asset(Images.teamwork)),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team.name,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text(team.code,
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 10),
                width: 120,
                child: Text(
                  team.description,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                )),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => TeamDetail(team: team)),
              child: SizedBox(
                  height: 30, width: 30, child: Image.asset(Images.edit_icon)),
            )
          ],
        ),
      ),
    );
  }
}
