import 'package:budgetin/utilities/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const OnBoardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  List<TextSpan> generateTextSpans() {
    List<TextSpan> spans = [];
    List<String> words = title.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (i % 2 == 1) {
        spans.add(TextSpan(
          text: words[i] + ' ',
          style: TextStyle(color: BudgetinColors.biru50),
        ));
      } else {
        spans.add(TextSpan(
          text: words[i] + ' ',
          style: TextStyle(color: Colors.black),
        ));
      }
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    const double verticalSpacing = 24;

    // OnboardingPage
    return Container(
      // padding: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image
          SvgPicture.asset(
            image,
            fit: BoxFit.fitWidth,
          ),
          // const SizedBox(height: verticalSpacing),
          // Title
          Align(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nunito'),
                  children: generateTextSpans(),
                ),
              )),
          const SizedBox(height: 10),
          // Subtitle
          Center(
              child: Center(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF909090),
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
