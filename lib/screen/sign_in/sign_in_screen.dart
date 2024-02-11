import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/screen/home_screen.dart';
import 'package:timesheet/utils/images.dart';
import '../common/CommonWidgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _showPass = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (controller) => Stack(
              children: [
                Opacity(
                  opacity: controller.loading ? 0.6 : 1,
                  child: Scaffold(
                      appBar: buildAppBar("Sign in"),
                      body: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                  height: 320,
                                  width: 320,
                                  child: Image.asset(Images.logo)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: reusableText("email".tr),
                                  ),
                                  buildTextField(
                                      context,
                                      "enter_username".tr,
                                      "username",
                                      Images.user,
                                      _usernameController),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: reusableText("password".tr),
                                  ),
                                  buildTextField(
                                      context,
                                      "enter_pass".tr,
                                      "password",
                                      Images.lock,
                                      _passwordController),
                                  const SizedBox(height: 30),
                                  buildButton("sign_in".tr, "signin", _login),
                                  buildButton("register".tr, "toregister", () {}),
                                  _forgetPassword(),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                Center(
                  child: Visibility(
                    visible: controller.loading,
                    child: const CircularProgressIndicator(),
                  ),
                )
              ],
            ));
  }

  _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      const snackBar = SnackBar(
        content: Text('You need to fill in your account and password.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Get.find<AuthController>().login(username, password).then((value) => {
            if (value == 200)
                Get.to(const HomeScreen(),
                    transition: Transition.size,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn)
            else if (value == 400)
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Incorrect account or password")))
            else
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("An error happened. Please try again"))),
          });
    }
  }

  Widget buildTextField(BuildContext context, String hint, String type,
      String imgPath, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.shade200
          // border: Border.all(color: Colors.black)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(left: 15, right: 10),
            child: Image.asset(imgPath),
          ),
          Container(
            width: 270,
            padding: const EdgeInsets.only(right: 10),
            child: TextField(
              controller: controller,
              onChanged: (value) {},
              obscureText: type == "password",
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
          )
        ],
      ),
    );
  }

  Widget _forgetPassword() {
    return SizedBox(
      height: 44,
      child: GestureDetector(
        onTap: () {},
        child: Center(
          child: Text(
            "forget_password".tr,
            style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: 12,
                decorationColor: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget buildButton(String name, String type, void Function()? func) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              type == 'signin' || type == 'signup'
                  ? Colors.lightBlueAccent
                  : Colors.blueAccent),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        onPressed: func,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
