import 'package:flutter/material.dart';
import 'package:timesheet/controller/user_controller.dart';
import 'package:timesheet/utils/images.dart';
import 'package:get/get.dart';
import '../../data/model/response/user.dart';
import '../dialogs/confirm_delete.dart';
import '../dialogs/user_detail.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({super.key, required this.user});

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
                          Text(user.username,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          Text(user.email,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ],
                      )),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showDetail(context),
                        child: SizedBox(
                          width: 34,
                          child: Image.asset(Images.edit_icon),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _confirmDelete(context),
                        child: const Icon(Icons.delete, color: Colors.red, size: 30),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
              height: 70, width: 70, child: Image.asset(Images.general_user)),
        ],
      ),
    );
  }

  _showDetail(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => UserDetail(user: user));
  }

  _confirmDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDelete(callback: () {
          Get.find<UserController>().deleteUser(user.id);
        });
      },
    );
  }
}
