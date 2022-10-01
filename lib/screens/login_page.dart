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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return SafeArea(
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
                        fontSize: height / 20, fontWeight: FontWeight.w900),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text("Forgot password?",
                          style: TextStyle(fontWeight: FontWeight.bold))
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
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black),
                      child: const Center(
                        child: Text("Log In",
                            style: TextStyle(color: Colors.white)),
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
                  children: const [
                    Text(
                      "By clicking sign in you agree to our",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text("Terms and Conditions",
                        style: TextStyle(fontWeight: FontWeight.w600))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.google)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.apple,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.facebookF))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
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
                      child: const Text("Sign up now!",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
