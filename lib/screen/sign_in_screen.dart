import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/utils/images.dart';

import '../helper/route_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(100, 56, 100, 60),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.background_sign_in),
                        fit: BoxFit.fill)),
                child: Image.asset(Images.logo),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    const Text(
                      "Login To Your Account",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 28),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(244, 244, 244, 1)),
                                borderRadius: BorderRadius.circular(15)),
                            hintText: "Email",
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(59, 59, 59, 1))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 28),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(244, 244, 244, 1)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(59, 59, 59, 1))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(28, 22, 20, 22),
                      child: const Text(
                        "Or Continue With",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1))),
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor: Colors.white,
                                    elevation: 0),
                                child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        22, 16, 12, 16),
                                    child: Row(children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: 25,
                                          height: 25,
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          child: Image.asset(Images.facebook)),
                                      const Text(
                                        "Facebook",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ]))),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                            color: Color.fromRGBO(
                                                244, 244, 244, 1))),
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor: Colors.white,
                                    elevation: 0),
                                child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        22, 16, 12, 16),
                                    child: Row(children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: 25,
                                          height: 25,
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          child: Image.asset(Images.google)),
                                      const Text(
                                        "Google",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ]))),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(28, 22, 20, 22),
                      child: const Text(
                        "Forgot Your Password?",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                          child: const Text("Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(21, 190, 119, 1))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.loading
                      ? const LinearProgressIndicator()
                      : Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You need to fill in all required fields')));
    } else {
      Get.find<AuthController>().login(username, password).then((value) => {
            if (value == 200)
              Get.offNamed(RouteHelper.main)
            else if (value == 400)
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Incorrect account or password")))
            else
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Some error happened. Please try again")))
          });
    }
  }
}
