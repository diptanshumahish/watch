import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../app/utils/snackbar/snackbar.dart';
import '../../../../../app/utils/textfield_validators.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/loading_dialog.dart';
import '../../app/controller/login_controller.dart';
import '../../app/state/login_state.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginControllerProvider, (previous, next) {
      if (next is LoginLoading) {
        context.showLoaderDialog();
      }
      if (next is LoginFailure) {
        context.hideLoaderDialog();
        context.showSnackBar(next.error.message, isError: true);
      }
      if (next is LoginSuccess) {
        context.hideLoaderDialog();
        context.showSnackBar(next.message);
        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
      }
    });
    Size size = MediaQuery.of(context).size;
    var emailController = useTextEditingController();
    var passwordController = useTextEditingController();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Center(
                  child:
                      Image.asset('assets/logo.png', height: size.height / 5),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.25),
                  height: size.height * 0.7,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 10),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: size.height / 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        CupertinoTextField(
                          padding: const EdgeInsets.all(13),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          style: const TextStyle(color: Colors.grey),
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(52, 158, 158, 158)),
                          placeholder: 'Enter your email',
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 5),
                          child: Text(
                            'Password',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        CupertinoTextField(
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          padding: const EdgeInsets.all(13),
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          style: const TextStyle(color: Colors.grey),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0x349E9E9E)),
                          placeholder: 'Enter your password',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, resetPasswordRoute),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: ValueListenableBuilder(
                                  valueListenable: emailController,
                                  builder: (_, val, child) {
                                    return ElevatedButton(
                                      onPressed: (val.text.isEmpty)
                                          ? null
                                          : () async {
                                              if (validateForm(context,
                                                  emailController:
                                                      emailController,
                                                  passwordController:
                                                      passwordController)) {
                                                await ref
                                                    .read(
                                                        loginControllerProvider
                                                            .notifier)
                                                    .loginWithEmail(
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                    );
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size.fromHeight(45),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        disabledBackgroundColor:
                                            Colors.grey.shade400,
                                        disabledForegroundColor:
                                            Colors.grey.shade800,
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.1,
                                        ),
                                      ),
                                    );
                                  },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'By clicking sign in you agree to our',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'Terms and Conditions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
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
                                              icon: const Icon(
                                                  FontAwesomeIcons.google)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0x2C9E9E9E)),
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              FontAwesomeIcons.apple,
                                            ),
                                          ),
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
                                            icon: const Icon(
                                              FontAwesomeIcons.facebookF,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Navigator.pushNamed(
                                          context, signUpRoute);
                                    },
                                    child: const Text(
                                      'Sign up now!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
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
        ),
      ),
    );
  }

  bool validateForm(
    BuildContext context, {
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    if (!emailController.text.isValidEmail()) {
      context.showSnackBar('Please enter a valid email', isError: true);
      return false;
    }
    if (passwordController.text.isEmpty) {
      context.showSnackBar('Please enter your password', isError: true);
      return false;
    }
    return true;
  }
}
