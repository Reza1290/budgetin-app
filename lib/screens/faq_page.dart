import 'package:budgetin/widgets/faq/faq_content.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: SafeArea(
          child: ListView(
            children: const [
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'FAQ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 39.0, 24.0, 0),
                    child: Column(
                      children: [
                        FaqContent(
                          question: 'What is the budget?',
                          answer:
                              'The budget refers to the amount of money allocated for a specific purpose.',
                        ),
                        SizedBox(height: 15),
                        FaqContent(
                          question: 'How to manage budget?',
                          answer:
                              'Budget management involves planning, tracking, and controlling expenses to meet financial goals.',
                        ),
                        SizedBox(height: 15),
                        FaqContent(
                          question: 'How to manage budget?',
                          answer:
                              'Budget management involves planning, tracking, and controlling expenses to meet financial goals.',
                        ),
                        SizedBox(height: 15),
                        FaqContent(
                          question: 'How to manage budget?',
                          answer:
                              'Budget management involves planning, tracking, and controlling expenses to meet financial goals.',
                        ),
                        SizedBox(height: 15),
                        FaqContent(
                          question: 'How to manage budget?',
                          answer:
                              'Budget management involves planning, tracking, and controlling expenses to meet financial goals.',
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
