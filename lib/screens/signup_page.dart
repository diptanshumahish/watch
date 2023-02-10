// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/screens/homepage.dart';
import 'package:watch/screens/login_page.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  String fullName = "";
  String email = "";
  String age = "";
  String password = "";
  String reEnteredPassword = "";

  @override
  Widget build(BuildContext context) {
    getTheme() {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    getThemeInv() {
      if (Theme.of(context).brightness == Brightness.light) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }

    bool snackBar({
      required String name,
      required String email,
      required String password,
      required String reEnteredPassword,
      required String age,
    }) {
      if (!email.contains('@')) {
        final snackBar = SnackBar(
          content: const Text('Please enter a vaild email'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (password != reEnteredPassword) {
        final snackBar = SnackBar(
          content: const Text('Password dosen\'t match'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (name == '') {
        final snackBar = SnackBar(
          content: const Text('Name cannot be empty'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }

      if (email == '') {
        final snackBar = SnackBar(
          content: const Text('Email cannot be empty'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (password == '') {
        final snackBar = SnackBar(
          content: const Text('Password cannot be empty'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (age == "" || int.parse(age) <= 0) {
        final snackBar = SnackBar(
          content: const Text('Invalid Age'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      return true;
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: Scrollbar(
            child: ListView(children: [
              SizedBox(
                height: height / 8,
                width: width,
                child: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.black),
                  ),
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Watch",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: height / 20),
                      ),
                      const Text(
                        "The best movie/web series reccomendations",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const Divider(
                        thickness: 1, // thickness of the line
                        indent:
                            20, // empty space to the leading edge of divider.
                        endIndent:
                            20, // empty space to the trailing edge of the divider.
                        color: Colors
                            .grey, // The color to use when painting the line.
                        height: 20, // The divider's height extent.
                      ),
                    ],
                  ))
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: height / 20,
                            fontWeight: FontWeight.w900,
                            color: getTheme()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                      child: Text(
                        "Full name",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    CupertinoTextField(
                      autofocus: true,
                      padding: const EdgeInsets.all(13),
                      style: TextStyle(color: getTheme()),
                      onChanged: (value) {
                        fullName = value;
                      },
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0x349E9E9E)),
                      placeholder: "Enter your full name",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, top: 8),
                      child: Text(
                        "Email",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    CupertinoTextField(
                      padding: const EdgeInsets.all(13),
                      style: TextStyle(color: getTheme()),
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(52, 158, 158, 158)),
                      placeholder: "Enter your email",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                      child: Text(
                        "Age",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    CupertinoTextField(
                      keyboardType: TextInputType.number,
                      padding: const EdgeInsets.all(13),
                      style: TextStyle(color: getTheme()),
                      onChanged: (value) {
                        age = value;
                      },
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0x349E9E9E)),
                      placeholder: "Enter your age here",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                      child: Text(
                        "Password",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    CupertinoTextField(
                      obscureText: true,
                      padding: const EdgeInsets.all(13),
                      style: TextStyle(color: getTheme()),
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0x349E9E9E)),
                      placeholder: "Enter your password",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                      child: Text(
                        "Re-enter your password",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    CupertinoTextField(
                      obscureText: true,
                      padding: const EdgeInsets.all(13),
                      style: TextStyle(color: getTheme()),
                      onChanged: (value) {
                        reEnteredPassword = value;
                      },
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0x349E9E9E)),
                      placeholder: "Re-enter your password",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: InkWell(
                        onTap: () {
                          if (snackBar(
                            name: fullName,
                            email: email,
                            password: password,
                            reEnteredPassword: reEnteredPassword,
                            age: age,
                          )) {}
                        },
                        child: Container(
                          width: width,
                          height: 45,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(4, 1),
                                  spreadRadius: -10,
                                  blurRadius: 17,
                                  color: Color.fromRGBO(0, 0, 0, 0.43),
                                )
                              ],
                              borderRadius: BorderRadius.circular(5),
                              color: getTheme()),
                          child: Center(
                            child: InkWell(
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => HomePage()))),
                              child: Text("Sign up",
                                  style: TextStyle(color: getThemeInv())),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "By clicking sign up you agree to our",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("Terms and Conditions",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: getTheme()))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alreday have an account? ",
                          style: TextStyle(color: getTheme().withOpacity(0.6)),
                        ),
                        InkWell(
                          onTap: (() {
                            Navigator.pop(context);

                            Navigator.push(
                                context,
                                PageTransition(
                                    curve: Curves.bounceOut,
                                    child: LoginPage(),
                                    type: PageTransitionType.leftToRight));
                          }),
                          child: Text("Sign in!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: getTheme())),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
