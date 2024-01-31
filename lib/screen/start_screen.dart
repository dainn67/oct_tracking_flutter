import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/screen/tiles/TrackingTile.dart';

import '../data/model/response/work_day.dart';
import 'common/CommonFunction.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String selectedTeam = 'Team 1';
  String selectedMember = 'Member 1';
  int pageIndex = 1;
  int pageSize = 10;

  // Map<String, dynamic> workingDayData = {
  //   "createDate": "2024-01-04T18:50:18",
  //   "createdBy": "ND122",
  //   "modifyDate": "2024-01-04T18:50:18",
  //   "modifiedBy": "ND122",
  //   "id": "862e1858-f4ff-4a45-9bc6-67b1f5a6048c",
  //   "dayOff": false,
  //   "dateWorking": "2024-01-01",
  //   "member": {
  //     "createDate": "2023-05-18T17:12:18",
  //     "createdBy": "admin",
  //     "modifyDate": "2023-05-18T17:12:18",
  //     "modifiedBy": "admin",
  //     "id": "5fa53abe-11cc-47de-940f-34ea2ebc784f",
  //     "name": "Bách",
  //     "code": "ND122",
  //     "gender": "MALE",
  //     "type": "MEMBER",
  //     "email": "hwangdoo99@gmail.com",
  //     "position": "DEV_FULLSTACK",
  //     "level": "L3",
  //     "status": "INTERNSHIP",
  //     "dateJoin": "2023-05-06",
  //     "team": null,
  //     "user": {
  //       "createDate": "2023-05-18T17:12:18",
  //       "createdBy": "admin",
  //       "modifyDate": "2023-05-18T17:12:18",
  //       "modifiedBy": "admin",
  //       "id": 21,
  //       "gender": null,
  //       "username": "ND122",
  //       "accountNonExpired": true,
  //       "accountNonLocked": true,
  //       "active": true,
  //       "credentialsNonExpired": true,
  //       "email": "hwangdoo99@gmail.com",
  //       "phone": null,
  //       "justCreated": true,
  //       "lastLoginFailures": null,
  //       "lastLoginTime": null,
  //       "totalLoginFailures": null,
  //       "orgId": null,
  //       "roles": null,
  //       "authorities": null
  //     }
  //   },
  //   "tasks": [
  //     {
  //       "createDate": "2024-01-20T01:12:59",
  //       "createdBy": "ND122",
  //       "modifyDate": "2024-01-20T01:12:59",
  //       "modifiedBy": "ND122",
  //       "id": "150dea9c-b1d0-4c22-a18c-3e7a4547f289",
  //       "overtimeHour": 0.0,
  //       "officeHour": 1.0,
  //       "taskOffice": "eqt",
  //       "taskOverTime": "",
  //       "project": {
  //         "id": "a485ec26-4920-43d7-8614-34f03aa8fde9",
  //         "name": "eQA/ePT",
  //         "code": "eQA/ePT",
  //         "status": "PENDING",
  //         "description": "",
  //         "tasks": null
  //       }
  //     },
  //     {
  //       "createDate": "2024-01-20T01:12:59",
  //       "createdBy": "ND122",
  //       "modifyDate": "2024-01-20T01:12:59",
  //       "modifiedBy": "ND122",
  //       "id": "2070d5c7-ac38-4f12-90fc-c6be1ebe5cac",
  //       "overtimeHour": 0.0,
  //       "officeHour": 3.0,
  //       "taskOffice": "cxfc",
  //       "taskOverTime": "",
  //       "project": {
  //         "id": "c5d0e385-54b4-4250-b4b0-d47fa91b0418",
  //         "name": "Block",
  //         "code": "TU",
  //         "status": "WORKING",
  //         "description": "",
  //         "tasks": null
  //       }
  //     },
  //     {
  //       "createDate": "2024-01-20T01:12:59",
  //       "createdBy": "ND122",
  //       "modifyDate": "2024-01-20T01:12:59",
  //       "modifiedBy": "ND122",
  //       "id": "ce8124c1-c20b-452f-b520-18de35deb8ac",
  //       "overtimeHour": 0.0,
  //       "officeHour": 1.0,
  //       "taskOffice": "12345",
  //       "taskOverTime": "",
  //       "project": {
  //         "id": "a285d341-39e1-4503-9971-b201ec70773c",
  //         "name": "Khảo sát Phần mềm HIS",
  //         "code": "HIS_BA",
  //         "status": "WORKING",
  //         "description": "",
  //         "tasks": null
  //       }
  //     }
  //   ]
  // };
  // WorkingDay workingDay = WorkingDay.fromJson(workingDayData);
  // json.decode(workingDayData, WorkingDay);
  //
  // List<TrackingTile> placeHolderList = [
  //   TrackingTile(workingDay: WorkingDay('', '', '', '', '', true, '', Member())),
  //   TrackingTile(),
  //   TrackingTile(),
  //   TrackingTile(),
  //   TrackingTile(),
  //   TrackingTile(),
  //   TrackingTile(),
  // ];

  @override
  Widget build(BuildContext context) {
    fromDate = DateTime(fromDate.year, fromDate.month, 1, 0, 0, 0);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          //Filter box
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
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
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: fromDate,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2025));

                            if (pickedDate != null && pickedDate != fromDate) {
                              setState(() {
                                fromDate = pickedDate;
                                if (kDebugMode) print(fromDate.toString());
                              });
                            }
                          },
                          child: Text(
                              'From: ${getDisplayDateAndTime(fromDate)}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                      const Icon(Icons.chevron_right),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text('To: ${getDisplayDateAndTime(toDate)}',
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
                                fontWeight: FontWeight.bold)),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: DropdownButton<String>(
                                value: selectedTeam,
                                items: [
                                  'Team 1',
                                  'Team 2',
                                  'Team 3',
                                  'Team 4',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if (newValue != null)
                                      selectedTeam = newValue;
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
                                fontWeight: FontWeight.bold)),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: DropdownButton<String>(
                                value: selectedMember,
                                items: [
                                  'Member 1',
                                  'Member 2',
                                  'Member 3',
                                  'Member 4',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if (newValue != null)
                                      selectedMember = newValue;
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
          ),

          //List box
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 2,
                        offset: const Offset(2, 2))
                  ]),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: GroupedListView<TrackingTile, String>(
                    elements: [],
                    groupBy: (TrackingTile tile) => tile.workingDay.dateWorking,
                    groupSeparatorBuilder: (String value) => Wrap(children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.lightBlueAccent.withOpacity(0.8)),
                        padding: const EdgeInsets.all(5.0),
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
                    itemBuilder: (context, tile) =>
                        TrackingTile(workingDay: tile.workingDay),
                  )),
            ),
          ),

          //Page and Size options
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
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
                            value: pageSize,
                            items: [
                              '10',
                              '20',
                              '50',
                            ].map<DropdownMenuItem<int>>((String value) {
                              return DropdownMenuItem<int>(
                                value: int.parse(value),
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                if (newValue != null) {}
                                // selectedMember = newValue;
                              });
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (pageIndex > 1) {
                              setState(() {
                                pageIndex--;
                              });
                            }
                          },
                          child: const Icon(Icons.chevron_left),
                        ),
                        const SizedBox(width: 10),
                        Text('Page $pageIndex',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            if (pageIndex < 5) {
                              setState(() {
                                pageIndex++;
                              });
                            }
                          },
                          child: const Icon(Icons.chevron_right),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _pickFromDate() {}

  _pickToDate() {}
}
