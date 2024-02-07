import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/screen/personnel/personnel_screen.dart';
import 'package:timesheet/screen/project/project_screen.dart';
import 'package:timesheet/screen/user/user_screen.dart';
import '../controller/auth_controller.dart';
import '../helper/route_helper.dart';
import '../widgets/drawer.dart';
import 'tracking/start_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> widgetList = [
    const StartScreen(),
    const ProjectScreen(),
    const PersonnelScreen(),
    const UserScreen(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //RX variables, notify listeners to rebuild their UI whenever value change
  var index = 0.obs;
  var title = "Home".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xff7377c5),
        title: Obx(() => Text(title.value)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Obx(() => widgetList[index.value]),
      drawer: CustomDrawer(
        logOut: logOut,
        changePage: (p0) => changePage(p0),
      ),
    );
  }

  void logOut() {
    Get.find<AuthController>().logOut().then((value) => {
          if (value == 200)
            Get.offNamed(RouteHelper.signIn)
          else
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Logged out")))
        });
  }

  void changePage(String s) {
    navigator?.pop(context);
    title.value = s.tr;
    switch (s) {
      case 'home':
        {
          index.value = 0;
          break;
        }
      case 'Project':
        {
          index.value = 1;
          break;
        }
      case 'Personnel':
        {
          index.value = 2;
          break;
        }
      case 'User':
        {
          index.value = 3;
        }
    }
  }
}
