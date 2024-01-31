import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/localization_controller.dart';

import '../controller/auth_controller.dart';
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
  DrawerState();

  // var showCCDC = false.obs;
  // var showShopping = false.obs;
  List<String> _langs = ["lang_vi", "lang_en"];
  var _lang = "lang_vi".obs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff7377c5),
      child: ListView(
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
                    'Tracking',
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
                      GetBuilder<AuthController>(
                        builder: (controller) =>
                            Text(
                              controller.user.displayName ?? "Admin",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade200,
                                  fontWeight: FontWeight.normal),
                            ),
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
              Icons.grid_view_rounded,
              color: Colors.white,
            ),
            title: Text(
              'Tracking'.tr,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () {
              widget.changePage('home');
            },
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<LocalizationController>(
                    builder: (controller) {
                      return Text(
                          controller.locale.languageCode == 'vi'
                              ? 'lang_vi'.tr
                              : 'lang_en'.tr,
                          style: const TextStyle(color: Colors.white));
                    },
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white)
                ]),
            leading: const Icon(
              Icons.language,
              color: Colors.white,
            ),
            onTap: () {
              _showPopupMenu(
                      (index) =>
                  {
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
              'terms'.tr,
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.policy,
              color: Colors.white,
            ),
            onTap: () {},
          ),

          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15), child: Divider()),
          ListTile(
            title: Text(
              'About us'.tr,
              style: const TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Log out'.tr,
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
    );
  }

  List<String> listCCDC() {
    return [
      'Danh sách CCDC',
      'Cấp phát CCDC',
      'Điều chuyển CCDC',
      'Kiểm kê CCDC',
      'Thanh lý CCDC',
      'CCDC chuyển đi'
    ];
  }

  void onItemClick(String index) {
    widget.changePage(index);
  }

  void _showPopupMenu(Function(int) onTap, BuildContext context) async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(120, 260, 100, 100),
      items: [
        PopupMenuItem(
          value: 'lang_vi',
          onTap: () => onTap(0),
          child: Text('lang_vi'.tr),
        ),
        PopupMenuItem(
          value: 'lang_en',
          onTap: () => onTap(1),
          child: Text("lang_en".tr),
        ),
      ],
      elevation: 8.0,
    );
  }
}