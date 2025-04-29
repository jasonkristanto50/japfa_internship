// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class DocumentPreviewPage extends StatefulWidget {
//   final String filePath;
//   const DocumentPreviewPage({super.key, required this.filePath});

//   @override
//   _DocumentPreviewPageState createState() => _DocumentPreviewPageState();
// }

// class _DocumentPreviewPageState extends State<DocumentPreviewPage> {
//   late WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the WebView plugin
//     WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Preview File"),
//       ),
//       body: WebView(
//         initialUrl: 'file://${widget.filePath}', // Use file:// URL for local files
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//       ),
//     );
//   }
// }
