import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatelessWidget {
  final String pdfUrl;

  const PdfViewer({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: PDFView(
        filePath: pdfUrl,
        enableSwipe: true,
        autoSpacing: false,
        pageSnap: true,
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading PDF: $error')),
          );
        },
        onPageError: (page, error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error on page $page: $error')),
          );
        },
      ),
    );
  }
}
