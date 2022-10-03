import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/screens/reccomendations.dart';
import 'package:watch/screens/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                          color: getTheme()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Email",
                      style: TextStyle(color: getTheme()),
                    ),
                  ),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(13),
                    style: TextStyle(color: getTheme()),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(52, 158, 158, 158)),
                    placeholder: "Enter your email",
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
                                fontWeight: FontWeight.bold, color: getTheme()))
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
                          child: Text("Log In",
                              style: TextStyle(color: getThemeInv())),
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
                              fontWeight: FontWeight.w600, color: getTheme()))
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
                        style: TextStyle(color: getTheme().withOpacity(0.7)),
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const SignUpPage(),
                                  type: PageTransitionType.rightToLeft));
                        }),
                        child: Text("Sign up now!",
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
    );
  }
}
