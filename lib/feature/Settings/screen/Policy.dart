import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'This Privacy Policy outlines how we collect, use, and protect your information when you use our app.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'We may collect personal information such as your name, email address, and any other information you provide.',
            ),
            SizedBox(height: 16),
            Text(
              '3. How We Use Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Your information helps us improve our app and provide you with a better experience.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Data Protection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'We take reasonable measures to protect your information from unauthorized access and misuse.',
            ),
            SizedBox(height: 16),
            Text(
              '5. Your Rights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'You have the right to access, modify, or delete your personal information at any time.',
            ),
            SizedBox(height: 16),
            Text(
              '6. Changes to This Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'We may update this policy from time to time. We will notify you of any significant changes.',
            ),
            SizedBox(height: 16),
            // Add a button or link to accept the policy
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle acceptance of the privacy policy
                  Navigator.pop(context); // Go back or perform another action
                },
                child: Text('Accept'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
