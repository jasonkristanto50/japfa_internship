import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';

enum EmailMessageType {
  daftarMagang,
  daftarKunjungan,
  statusMagang,
  statusKunjungan,
  tambahLinkMeet,
  tambahPembimbing,
}

class EmailSender extends StatefulWidget {
  final String email;
  final String name;
  final String pin;
  final EmailMessageType messageType;

  // Pass required parameters to EmailSender
  const EmailSender({
    super.key,
    required this.email,
    required this.name,
    required this.pin,
    required this.messageType,
  });

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  bool _isLoading = false; // Manage loading state

  @override
  void initState() {
    super.initState();
    // Call sendEmail when the widget is initialized
    sendEmail(
      widget.email,
      widget.name,
      widget.pin,
      widget.messageType,
    );
  }

  Future<void> sendEmail(String email, String name, String pin,
      EmailMessageType messageType) async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    try {
      final responseFuture = Dio().post(
        '$baseUrlApi/email/send-email',
        data: {
          'email': email,
          'name': name,
          'pin': pin,
          'messageType': messageType.toString().split('.').last,
        },
      );

      // Set the maximum time to wait for the response
      final response =
          await responseFuture.timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        print('Email sent successfully: ${response.data}');
        // Optionally show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sent successfully!')),
        );
      } else {
        throw Exception('Failed to send email');
      }
    } catch (error) {
      // Handle timeout specifically
      if (error is DioException &&
          error.type == DioExceptionType.connectionTimeout) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Email gagal dikirimkan')), // Show failure message
        );
      } else {
        print('Error sending email: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending email: $error')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Email'),
      ),
      body: Center(
        child: _isLoading // Conditional loading indicator
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // Show loading indicator
                  SizedBox(height: 20), // Add some spacing
                  Text('Sedang mengirim email'), // Show loading message
                ],
              )
            : Container(), // When not loading, show nothing or another widget
      ),
    );
  }
}
