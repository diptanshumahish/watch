import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: SizedBox.square(
                  dimension: 180,
                  child: Image.asset(
                    'assets/logo.png',
                    color: Colors.black,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
                  .animate()
                  .scaleXY(
                    begin: 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  )
                  .fadeIn(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(seconds: 1),
                  ),
              const SizedBox.square(
                dimension: 30,
                child: RepaintBoundary(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
