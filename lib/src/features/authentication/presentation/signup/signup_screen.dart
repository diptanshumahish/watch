import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/app/utils/snackbar/snackbar.dart';
import 'package:watch/app/utils/textfield_validators.dart';
import 'package:watch/src/routes/app_routes.dart';
import 'package:watch/src/shared/loading_dialog.dart';

import '../../app/controller/signup_controller.dart';
import '../../app/state/signup_state.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final ageController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    ref.listen<SignUpState>(signUpControllerProvider, (old, next) {
      if (next is SignUpLoading) {
        context.showLoaderDialog();
      }
      if (next is SignupSuccess) {
        context.hideLoaderDialog();
        context.showSnackBar(next.message);
        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
      } else if (next is SignUpFailure) {
        context.hideLoaderDialog();
        context.showSnackBar(next.error.message, isError: true);
      }
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(child: Image.asset('assets/logo.png')),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
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
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "Full name",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CupertinoTextField(
                          autofocus: true,
                          autofillHints: const [AutofillHints.name],
                          controller: fullNameController,
                          textInputAction: TextInputAction.next,
                          padding: const EdgeInsets.all(13),
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          style: const TextStyle(color: Colors.black),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0x349E9E9E)),
                          placeholder: "Enter your full name",
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(
                            bottom: 5.0, top: 8, left: 20, right: 20),
                        child: Text(
                          "Email",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CupertinoTextField(
                          controller: emailController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          ],
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          padding: const EdgeInsets.all(13),
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          style: const TextStyle(color: Colors.black),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(52, 158, 158, 158)),
                          placeholder: "Enter your email",
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 5, left: 20, right: 20),
                        child: Text(
                          "Age",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CupertinoTextField(
                          controller: ageController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2)
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          padding: const EdgeInsets.all(13),
                          style: const TextStyle(color: Colors.black),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0x349E9E9E)),
                          placeholder: "Enter your age here",
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 5, left: 20, right: 20),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CupertinoTextField(
                          obscureText: true,
                          autofillHints: const [AutofillHints.password],
                          controller: passwordController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          ],
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          padding: const EdgeInsets.all(13),
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          style: const TextStyle(color: Colors.black),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0x349E9E9E)),
                          placeholder: "Enter your password",
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 5, left: 20, right: 20),
                        child: Text(
                          "Re-enter your password",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CupertinoTextField(
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          ],
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          controller: confirmPasswordController,
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          padding: const EdgeInsets.all(13),
                          style: const TextStyle(color: Colors.black),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0x349E9E9E)),
                          placeholder: "Re-enter your password",
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: InkWell(
                          onTap: () async {
                            if (validateForm(
                              fullNameController: fullNameController,
                              emailController: emailController,
                              ageController: ageController,
                              passwordController: passwordController,
                              confirmPasswordController:
                                  confirmPasswordController,
                            )) {
                              await ref
                                  .read(signUpControllerProvider.notifier)
                                  .signUp(
                                    name: fullNameController.text.trim(),
                                    email: emailController.text,
                                    age: ageController.text,
                                    password: passwordController.text,
                                  );
                              return;
                            }
                          },
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.84,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black,
                              ),
                              child: const Center(
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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
                              children: const [
                                Text(
                                  "By clicking sign up you agree to our",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Terms and Conditions",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Alreday have an account? ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () => Navigator.maybePop(context),
                                  child: const Text(
                                    "Sign in!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
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
    );
  }

  bool validateForm({
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController ageController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) {
    if (!fullNameController.text.trim().isValidName()) {
      context.showSnackBar('Please enter a valid name', isError: true);
      return false;
    }
    if (!emailController.text.isValidEmail()) {
      context.showSnackBar('Please enter a valid email', isError: true);
      return false;
    }
    if (ageController.text.trim().isEmpty) {
      context.showSnackBar('Please enter your age', isError: true);
      return false;
    }
    if (!passwordController.text.isValidPassword()) {
      context.showSnackBar('Please enter a strong password with min. 8 chars.',
          isError: true);
      return false;
    }
    if (!confirmPasswordController.text.isSame(passwordController.text)) {
      context.showSnackBar('Passwords do not match', isError: true);
      return false;
    }
    return true;
  }
}
