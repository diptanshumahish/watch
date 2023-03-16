import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerGridSkeleton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  const ShimmerGridSkeleton({super.key,  this.padding});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: padding ??const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      physics: const ClampingScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
        )
            .animate(
              onComplete: (controller) => controller.repeat(),
            )
            .shimmer(
              duration: const Duration(milliseconds: 1000),
              color: Colors.black26,
            );
      },
    );
  }
}
