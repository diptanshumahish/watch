import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../../../../app/utils/snackbar/snackbar.dart';
import '../../../../shared/loading_dialog.dart';
import '../../app/controller/forgot_password_controller.dart';
import '../../app/state/forgot_password_state.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  final bool isMobileReset;
  const ForgotPasswordScreen({super.key, this.isMobileReset = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(forgotScreenControllerProvider,
        (ForgotPasswordState? previous, ForgotPasswordState next) {
      if (next is ForgotLoading) {
        context.showLoaderDialog();
      }
      if (next is ForgotFailure) {
        context.hideLoaderDialog();
        context.showSnackBar(next.error.message, isError: true);
      }
      if (next is ForgotEmailSent) {
        context.hideLoaderDialog();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
        context.showSnackBar(next.message);
      }
      if (next is NewEmailVerified) {
        context.hideLoaderDialog();
        context.showSnackBar(next.message);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      }
    });
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController = useTextEditingController();
    TextEditingController pinputController = useTextEditingController();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 30,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.black,
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
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
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 10),
                          child: Center(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                fontSize: size.height / 30,
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
                          inputFormatters: <FilteringTextInputFormatter>[
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          style: const TextStyle(color: Colors.grey),
                          placeholderStyle: const TextStyle(color: Colors.grey),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(52, 158, 158, 158)),
                          placeholder: 'Enter your email',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: emailController,
                                  builder:
                                      (_, TextEditingValue val, Widget? child) {
                                    return ElevatedButton(
                                      onPressed: (val.text.isEmpty)
                                          ? null
                                          : () async {
                                              await ref
                                                  .read(
                                                      forgotScreenControllerProvider
                                                          .notifier)
                                                  .resetPassword(emailController
                                                      .text
                                                      .trim());
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
                                        'SEND RESET LINK',
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
                        const SizedBox(height: 20),
                        if (isMobileReset) ...<Widget>[
                          Center(
                            child: Text(
                              'Enter the code',
                              style: TextStyle(
                                fontSize: size.height / 50,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Pinput(
                            length: 6,
                            autofillHints: const <String>[
                              AutofillHints.oneTimeCode
                            ],
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                            listenForMultipleSmsOnAndroid: true,
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 4,
                                    spreadRadius: 1.5,
                                    offset: const Offset(2, 2),
                                  )
                                ],
                              ),
                            ),
                            showCursor: true,
                            cursor: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 19,
                                height: 1,
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onClipboardFound: (String value) {
                              pinputController.text = value;
                            },
                            closeKeyboardWhenCompleted: true,
                            keyboardType: TextInputType.number,
                            onCompleted: (String value) async {
                              await ref
                                  .read(forgotScreenControllerProvider.notifier)
                                  .verifyResetPassword(value);
                            },
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child:
                                      ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: pinputController,
                                    builder: (_, TextEditingValue val,
                                        Widget? child) {
                                      return ElevatedButton(
                                        onPressed: (val.text.isEmpty)
                                            ? null
                                            : () async {
                                                await ref
                                                    .read(
                                                        forgotScreenControllerProvider
                                                            .notifier)
                                                    .verifyResetPassword(
                                                        pinputController.text);
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
                                          'VERIFY',
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
                        ]
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
}
