import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:watch/screens/login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Scrollbar(
          child: ListView(children: [
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
                      "Sign Up",
                      style: TextStyle(
                          fontSize: height / 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5),
                    child: Text("Full name"),
                  ),
                  CupertinoTextField(
                    autofocus: true,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0x349E9E9E)),
                    placeholder: "Enter your full name",
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 8),
                    child: Text("Email"),
                  ),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(52, 158, 158, 158)),
                    placeholder: "Enter your email",
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5),
                    child: Text("Enter your age"),
                  ),
                  CupertinoTextField(
                    keyboardType: TextInputType.number,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0x349E9E9E)),
                    placeholder: "Enter your age here",
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5),
                    child: Text("Password"),
                  ),
                  CupertinoTextField(
                    obscureText: true,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0x349E9E9E)),
                    placeholder: "Enter your password",
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 5),
                    child: Text("Re-enter your password"),
                  ),
                  CupertinoTextField(
                    obscureText: true,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0x349E9E9E)),
                    placeholder: "Re-enter your password",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                          color: Colors.black),
                      child: const Center(
                        child: Text("Sign up",
                            style: TextStyle(color: Colors.white)),
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
                    children: const [
                      Text(
                        "By clicking sign up you agree to our",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text("Terms and Conditions",
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Alreday have an account? ",
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              PageTransition(
                                  curve: Curves.bounceOut,
                                  child: const LoginPage(),
                                  type: PageTransitionType.leftToRight));
                        }),
                        child: const Text("Sign in!",
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
