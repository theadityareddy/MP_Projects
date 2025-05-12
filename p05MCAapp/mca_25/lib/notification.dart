import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Platform-specific imports
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'dart:io' show Platform;

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildNotificationItem(
          context,
          "- Parents Teacher Meeting, November 2022",
          "https://mca.spit.ac.in/index.php/notifications/",
        ),
        _buildNotificationItem(
          context,
          "- Parents Teacher Meeting, April 2023",
          "https://mca.spit.ac.in/index.php/notifications/",
        ),
        _buildNotificationItem(
          context,
          "- Parents Teacher Meeting Notice, 2023",
          "https://mca.spit.ac.in/index.php/notifications/",
        ),
        _buildNotificationItem(
          context,
          "- Parents Teacher Meeting, November 2023",
          "https://mca.spit.ac.in/index.php/notifications/",
        ),
      ],
    );
  }

  Widget _buildNotificationItem(BuildContext context, String text, String url) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(text, style: const TextStyle(fontSize: 16)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple[700]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewPage(url: url),
            ),
          );
        },
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({required this.url, Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Create the controller with platform-specific parameters
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) => setState(() => isLoading = true),
          onPageFinished: (String url) => setState(() => isLoading = false),
          onWebResourceError: (WebResourceError error) {
            print('Web Resource Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    // Platform-specific configuration
    if (Platform.isAndroid) {
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    } else if (Platform.isIOS) {
      (controller.platform as WebKitWebViewController)
          .setAllowsBackForwardNavigationGestures(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details"),
        backgroundColor: Colors.purple[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.reload,
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}