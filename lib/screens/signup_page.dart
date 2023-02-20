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
        const snackBar = SnackBar(
          backgroundColor: Colors.black,
          content: Text('Please enter a vaild email'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (password != reEnteredPassword) {
        const snackBar = SnackBar(
          backgroundColor: Colors.black,
          content: Text('Password dosen\'t match'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (name == '') {
        const snackBar = SnackBar(
          backgroundColor: Colors.black,
          content: Text('Name cannot be empty'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }

      if (email == '') {
        const snackBar = SnackBar(
          content: Text('Email cannot be empty'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (password == '') {
        const snackBar = SnackBar(
          backgroundColor: Colors.black,
          content: Text('Password cannot be empty'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      if (age == "" || int.parse(age) <= 0) {
        const snackBar = SnackBar(
          backgroundColor: Colors.black,
          content: Text('Invalid Age'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
      return true;
    }

    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(child: Image.asset('assets/logo.png'))),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    40,
                  ),
                  topLeft: Radius.circular(
                    40,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 20,
                              fontWeight: FontWeight.w900,
                              color: getTheme()),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Full name",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CupertinoTextField(
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0, top: 8, left: 20, right: 20),
                      child: Text(
                        "Email",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CupertinoTextField(
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 5, left: 20, right: 20),
                      child: Text(
                        "Age",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CupertinoTextField(
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 5, left: 20, right: 20),
                      child: Text(
                        "Password",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CupertinoTextField(
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 5, left: 20, right: 20),
                      child: Text(
                        "Re-enter your password",
                        style: TextStyle(color: getTheme()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CupertinoTextField(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
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
                        child: Center(
                          child: Container(
                            // padding: EdgeInsets.only(left: 30, right: 20),
                            width: MediaQuery.of(context).size.width * 0.84,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: getTheme(),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const HomePage()),
                                  ),
                                ),
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: getThemeInv(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                      fontWeight: FontWeight.w600,
                                      color: getTheme()))
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
                                style: TextStyle(
                                    color: getTheme().withOpacity(0.6)),
                              ),
                              InkWell(
                                onTap: (() {
                                  Navigator.pop(context);

                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          curve: Curves.bounceOut,
                                          child: LoginPage(),
                                          type:
                                              PageTransitionType.leftToRight));
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
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
