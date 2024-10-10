import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About This App'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Habit Tracker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Habit Tracker is designed to help you build and maintain positive habits while breaking the negative ones. Our app offers a comprehensive set of features to make your journey easier and more effective.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Key Features:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '• **To-Do List**: Keep track of your daily tasks and prioritize what matters most to you.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• **Not-Do List**: Identify and eliminate negative habits that hinder your progress.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• **Calendar View**: Visualize your habit streaks and task completions over time.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• **Goal Tracking**: Set short-term and long-term goals to stay focused on your objectives.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '• **Timer**: Use a built-in timer to allocate focused time for tasks and goals.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Getting Started:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'To begin, simply create your account and start adding habits and tasks. Our user-friendly interface will guide you through the process.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'We are committed to helping you achieve your personal growth goals. Thank you for choosing Habit Tracker!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Add a button or link to navigate back
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
