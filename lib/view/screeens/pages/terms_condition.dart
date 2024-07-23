import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/content_text.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/title_text.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Terms And Conditions',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Content(
                  text:
                      'Welcome to ArtistryHub. By accessing or using ArtistryHub, you agree to comply with and be bound by these terms. Please read them carefully.',
                ),
              ),
              SizedBox(height: 20),
              Tittle(text: 'Acceptance Of Terms'),
              SizedBox(height: 10),
              Content(
                text:
                    'By creating an account, accessing, or using ArtistryHub, you agree to these Terms and any policies referenced herein. If you do not agree, do not use our app.',
              ),
              SizedBox(height: 20),
              Tittle(text: 'Account Registration'),
              SizedBox(height: 10),
              Content(
                text:
                    'By creating an account, accessing, or using ArtistryHub, you agree to these Terms and any policies referenced herein. If you do not agree, do not use our app.',
              ),
              SizedBox(height: 20),
              Tittle(text: 'User Responsibilities'),
              SizedBox(height: 10),
              Content(
                text:
                    'You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.',
              ),
              SizedBox(height: 20),
              Tittle(text: 'Changes to Terms'),
              SizedBox(height: 10),
              Content(
                text:
                    'We may modify these Terms at any time. We will notify you of any significant changes by posting the new Terms on our app or by other means. Your continued use of the app after such changes constitutes your acceptance of the new Terms.\n\nIf you have any questions or concerns about these Terms, please contact us at ArtistryHub. By using ArtistryHub, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
