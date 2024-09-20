import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:transittrack/features/onboarding/domain/onboarding_entity.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingEntity onboardingEntity;
  const OnboardingWidget({
    super.key,
    required this.onboardingEntity,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        color: onboardingEntity.bgColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 27.h, 15.w, 0.h),
          // padding: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Lottie.asset(
                    onboardingEntity.image,
                    height: screenHeight * 0.3,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    onboardingEntity.title,
                    style: const TextStyle(
                        fontFamily: 'Laila',
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Text(
                      onboardingEntity.description,
                      style: const TextStyle(fontFamily: 'Laila', fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
