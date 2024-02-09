import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/localization_controller.dart';
import '../controller/tracking_controller.dart';
import '../utils/app_constants.dart';

class CustomDrawer extends StatefulWidget {
  final VoidCallback logOut;
  final void Function(String) changePage;

  const CustomDrawer(
      {super.key, required this.logOut, required this.changePage});

  @override
  State<StatefulWidget> createState() => DrawerState();
}

class DrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff7377c5),
      child: GetBuilder<LocalizationController>(
        builder: (controller) => ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //header
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff5f62a1)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Tracking'.tr,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade200,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.person_sharp,
                          color: Colors.grey.shade200,
                          size: 60,
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade200,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //Options
            ListTile(
              leading: const Icon(
                Icons.track_changes_rounded,
                color: Colors.white,
              ),
              title: Text(
                'tracking'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                widget.changePage('tracking');
              },
            ),
            ListTile(
              title: Text(
                'project'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.account_tree_rounded,
                color: Colors.white,
              ),
              onTap: () {
                widget.changePage('project');
              },
            ),
            ListTile(
              title: Text(
                'personnel'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.group,
                color: Colors.white,
              ),
              onTap: () {
                widget.changePage('personnel');
              },
            ),
            ListTile(
              title: Text(
                'user'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.supervised_user_circle_rounded,
                color: Colors.white,
              ),
              onTap: () {
                widget.changePage('user');
              },
            ),

            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider()),

            ListTile(
              leading: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        controller.locale.languageCode == 'vi'
                            ? 'lang_vi'.tr
                            : 'lang_en'.tr,
                        style: const TextStyle(color: Colors.white)),
                    const Icon(Icons.arrow_drop_down, color: Colors.white)
                  ]),
              onTap: () {
                _showPopupMenu(
                    (index) => {
                          Get.find<LocalizationController>().setLanguage(Locale(
                            AppConstants.languages[index].languageCode,
                            AppConstants.languages[index].countryCode,
                          ))
                        },
                    this.context);
              },
            ),

            ListTile(
              title: Text(
                'about_us'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text(
                'logout'.tr,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onTap: widget.logOut,
            ),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(
      Function(int) changeLanguage, BuildContext context) async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(120, 460, 100, 100),
      items: [
        PopupMenuItem(
          value: 'lang_vi',
          onTap: () {
            changeLanguage(0);
            widget.changePage('tracking');
          },
          child: Text('lang_vi'.tr),
        ),
        PopupMenuItem(
          value: 'lang_en',
          onTap: () {
            changeLanguage(1);
            widget.changePage('tracking');
          },
          child: Text("lang_en".tr),
        ),
      ],
      elevation: 8.0,
    );
  }
}
