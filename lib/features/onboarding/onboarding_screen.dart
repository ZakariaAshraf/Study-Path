import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/features/home/presentation/screens/home_screen.dart';

import '../../core/cache/cache_helper.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        skipTextButton: Text("Skip",style: TextStyle(
          color: Colors.grey,
          fontSize: 18.0.sp(context),
          fontWeight: FontWeight.w600,
        ),),
        centerBackground: true,
        controllerColor: Colors.black,
        finishButtonText: "Let's Start ->",
        onFinish: () {
          CacheHelper.set(key: CacheKeys.isOnBoardingSeen, value: true).then((value) {
            Navigator.pushReplacementNamed(context, '/signIn');
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        },
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.black,
        ),
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        background: [
          Image.asset(
            "assets/images/onboarding_1.png",
            width: 400.w(context),
            height: 400.h(context),
          ),
          Image.asset(
            "assets/images/onboarding_2.png",
            width: 400.w(context),
            height: 400.h(context),
          ),
          Image.asset(
            "assets/images/onboarding_3.png",
            width: 400.w(context),
            height: 400.h(context),
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 SizedBox(height: 450.h(context)),
                Text(
                  "Unlock Europe",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                 SizedBox(height: 10.h(context)),
                 Text(
                  ''' Explore thousands of Master's programs across the continent filtered by your specific needs.''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 450.h(context)),
                Text(
                  '''Filter by what matters''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                 SizedBox(height: 10.h(context)),
                 Text(
                  '''Narrow down thousands of European programs based on your budget, language, and interests.''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 450.h(context)),
                Text(
                  '''Your Future Awaits''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                 SizedBox(height: 10.h(context)),
                 Text(
                  '''Your Future AwaitsAccess thousands of European master's programs tailored to your goals. Let's find your perfect match today.ss''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
