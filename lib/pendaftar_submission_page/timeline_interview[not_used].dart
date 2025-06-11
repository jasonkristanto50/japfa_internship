import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/authentication/login.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';

enum InterviewState {
  wait,
  interview,
  reviewing,
  reviewed,
}

class TimelineInterview extends ConsumerStatefulWidget {
  const TimelineInterview({super.key});

  @override
  _TimelineInterviewState createState() => _TimelineInterviewState();
}

class _TimelineInterviewState extends ConsumerState<TimelineInterview> {
  InterviewState currentState = InterviewState.wait;
  PesertaMagangData? peserta;

  @override
  void initState() {
    super.initState();
    _fetchPesertaData(); // Fetch the participant data and set the current state
  }

  Future<void> _fetchPesertaData() async {
    final login = ref.read(loginProvider);

    if (login.isLoggedIn) {
      // Fetch data only if the user is logged in
      try {
        // Replace with appropriate email or ID for the participant
        peserta = await ApiService()
            .pesertaMagangService
            .fetchPesertaMagangByEmail(login.email!);
        if (peserta != null) {
          // You could set the state based on the peserta status here
          // For example, based on their status, you might want to change the currentState.
          currentState = _determineInterviewState(peserta!);
        }
      } catch (e) {
        // Handle errors appropriately
        print('Error fetching data: $e');
      }
    }
  }

  InterviewState _determineInterviewState(PesertaMagangData peserta) {
    if (peserta.statusMagang == statusMagangMenunggu) {
      return InterviewState.interview;
      // } else if (peserta.statusMagang == statusMagangSekarang) {
      //   return InterviewState.reviewing;
    } else if (peserta.statusMagang == statusMagangDiterima) {
      return InterviewState.reviewed;
    } else {
      return InterviewState.wait;
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = ref.read(loginProvider);

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Center(
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
            child: login.isLoggedIn
                ? (peserta == null
                    ? _noDataWidget()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _buildContent(currentState),
                      ))
                : _loginPromptWidget(),
          ),
        ),
      ),
    );
  }

  Widget _noDataWidget() {
    return const Center(
      child: Text(
        'Tidak ada pengajuan magang.',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _loginPromptWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Silakan login untuk melihat timeline wawancara.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to login screen
            fadeNavigation(context, targetNavigation: const LoginScreen());
          },
          child: const Text('Login'),
        ),
      ],
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
          Image.asset('assets/timeline/timeline_1.png',
              height: 300, width: 1000),
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
