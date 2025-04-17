import 'package:flutter/material.dart';
import 'package:japfa_internship/components/navbar.dart';
import 'package:japfa_internship/function_variable/variable.dart';

enum InterviewState {
  wait,
  interview,
  reviewing,
  reviewed,
}

class TimelineInterview extends StatefulWidget {
  const TimelineInterview({super.key});

  @override
  _TimelineInterviewState createState() => _TimelineInterviewState();
}

class _TimelineInterviewState extends State<TimelineInterview> {
  bool _visible = false;
  InterviewState currentState = InterviewState.wait; // INITIAL STATE

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Fallback background color
          image: DecorationImage(
            image: AssetImage(
                'assets/japfa_logo_background.png'), // Background image
            fit: BoxFit.cover, // Image cover
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500), // Fade-in duration
            child: Container(
              width: 1000,
              height: 600,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align items to the start
                children: _buildContent(currentState),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(InterviewState state) {
    switch (state) {
      case InterviewState.wait:
        return [
          const Text(
            'TIMELINE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Waiting for HRD Response',
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.orange),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/timeline_1.png', height: 300, width: 1000),
          const SizedBox(height: 20),
          const Text(
            'Your application is currently under review. Please be patient while we get back to you.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ];
      case InterviewState.interview:
        return [
          const Text(
            'TIMELINE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Interview Scheduled',
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.orange),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/timeline_2.png',
              height: 300, width: 1000), // Change the image
          const SizedBox(height: 20),
          const Text(
            'You have successfully scheduled your interview. Please be prepared.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ];
      case InterviewState.reviewing:
        return [
          const Text(
            'TIMELINE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Currently Under Review',
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.orange),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/timeline_3.png',
              height: 300, width: 1000), // Change the image
          const SizedBox(height: 20),
          const Text(
            'Your application is being reviewed by our team. Thank you for your patience.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ];
      case InterviewState.reviewed:
        return [
          const Text(
            'TIMELINE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Application Reviewed',
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.orange),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/timeline_4.png',
              height: 300, width: 1000), // Change the image
          const SizedBox(height: 20),
          const Text(
            'Your application has been reviewed. You will receive feedback soon.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ];
    }
  }
}
