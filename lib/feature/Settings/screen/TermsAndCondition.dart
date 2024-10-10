import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome to our app! These terms and conditions outline the rules and regulations for the use of our app.',
            ),
            SizedBox(height: 16),
            Text(
              '2. License',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'We grant you a limited license to use our app as per the terms specified herein.',
            ),
            SizedBox(height: 16),
            Text(
              '3. User Responsibilities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Users are responsible for maintaining the confidentiality of their account information.',
            ),
            SizedBox(height: 16),
            // Add more sections as needed
            Text(
              '4. Limitation of Liability',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'We will not be liable for any damages arising from the use of our app.',
            ),
            SizedBox(height: 16),
            Text(
              '5. Changes to Terms',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'We reserve the right to modify these terms at any time.',
            ),
            SizedBox(height: 16),
            // Add a button or link to accept the terms
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle acceptance of terms
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
