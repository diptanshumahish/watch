// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/screens/reccomendations.dart';
import 'package:watch/screens/signup_page.dart';
import 'package:watch/util/color_theme.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    bool snackBar({
      required String email,
      required String password,
    }) {
      if (!email.contains('@')) {
        final snackBar = SnackBar(
          content: const Text('Please enter a vaild email'),
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
          extendBody: true,
          body: ListView(children: [
            SizedBox(
              height: height / 3.5,
              width: width,
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.black),
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Watch",
                      style:
                          TextStyle(color: Colors.white, fontSize: height / 20),
                    ),
                    const Text(
                      "The best movie/web series reccomendations",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    )
                  ],
                ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: height / 20,
                          fontWeight: FontWeight.w900,
                          color: ColorTheme.getTheme(context)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Email",
                      style: TextStyle(color: ColorTheme.getTheme(context)),
                    ),
                  ),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(13),
                    style: TextStyle(color: ColorTheme.getTheme(context)),
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
                      "Password",
                      style: TextStyle(color: ColorTheme.getTheme(context)),
                    ),
                  ),
                  CupertinoTextField(
                    obscureText: true,
                    padding: const EdgeInsets.all(13),
                    style: TextStyle(color: ColorTheme.getTheme(context)),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0x349E9E9E)),
                    placeholder: "Enter your password",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot password?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.getTheme(context)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: InkWell(
                      onTap: (() {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            PageTransition(
                                curve: Curves.bounceOut,
                                child: const Reccomendations(),
                                type: PageTransitionType.rightToLeft));
                      }),
                      child: InkWell(
                        onTap: () {
                          if (snackBar(email: email, password: password)) {
                          }
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
                              color: ColorTheme.getTheme(context)),
                          child: Center(
                            child: Text("Log In",
                                style: TextStyle(
                                    color: ColorTheme.getThemeInv(context))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "By clicking sign in you agree to our",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text("Terms and Conditions",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorTheme.getTheme(context)))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0x2C9E9E9E)),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(FontAwesomeIcons.google)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0x2C9E9E9E)),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(FontAwesomeIcons.apple)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0x2C9E9E9E)),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(FontAwesomeIcons.facebookF)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            color:
                                ColorTheme.getTheme(context).withOpacity(0.7)),
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: SignUpPage(),
                                  type: PageTransitionType.rightToLeft));
                        }),
                        child: Text("Sign up now!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorTheme.getTheme(context))),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
