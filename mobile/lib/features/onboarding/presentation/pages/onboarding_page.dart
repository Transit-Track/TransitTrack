import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/authentication/presentation/pages/login_page.dart';
import 'package:transittrack/features/onboarding/domain/onboarding_entity.dart';
import 'package:transittrack/features/onboarding/presentation/widget/onboarding_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //  Future<void> completeOnboarding(BuildContext context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('onboarding', true);
  //   context.goNamed(AppPath.login); // Navigate to login or home based on your logic
  // }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    List<OnboardingWidget> pages = [
      OnboardingWidget(
        onboardingEntity: OnboardingEntity(
          title: "Real-time Vehicle tracking",
          image: 'assets/images/location.json',
          description:
              "Stay connected to your ride always know where your bus is and when it'll be there.",
          bgColor: Colors.white,
        ),
      ),
      OnboardingWidget(
        onboardingEntity: OnboardingEntity(
          title: "Arrival time estimation",
          image: 'assets/images/arrival_time.json',
          description:
              "Our advanced algorithms provide you with highly accurate arrival time predictions.",
          bgColor: Color.fromARGB(255, 235, 245, 250),
        ),
      ),
      OnboardingWidget(
          onboardingEntity: OnboardingEntity(
        title: "Digital payment",
        image: 'assets/images/succes.json',
        description:
            "Leave the cash at home. Pay for your rides with a simple tap.",
        bgColor: Color.fromARGB(255, 226, 242, 255),
      )),
      OnboardingWidget(
          onboardingEntity: OnboardingEntity(
        title: "Dynamic Re-reouting",
        image: 'assets/images/dynamic_rerouting.json',
        description:
            "With our dynamic re-routing feature, eliminate unused buses and reduce wait times for your ride.",
        bgColor:  Color.fromARGB(255, 235, 245, 250),
      ))
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            LiquidSwipe(
              pages: pages,
              enableSideReveal: true,
              enableLoop: true,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              left: screenWidth * 0.3,
              child: getStarted(context),
            ),
            Positioned(
              bottom: screenHeight * 0.05,
              left: screenWidth * 0.43,
              child: SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                onDotClicked: (index) => pageController.animateToPage(index,
                    duration: const Duration(microseconds: 600),
                    curve: Curves.easeIn),
                effect: WormEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotWidth: 10,
                    dotHeight: 10),
              ),
            ),
          ],
        ));
  }

  Widget getStarted(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pres = await SharedPreferences.getInstance();
        pres.setBool('onboarding', true);

        if (!mounted) return;
        (context).pushReplacementNamed(AppPath.login);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: Container(
        width: 140,
        height: 55,
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Center(
          child: Text('Get Started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}
