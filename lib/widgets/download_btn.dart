import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadButton extends StatefulWidget {
  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  double _progress = 0.0; // Tracks download progress
  bool _isDownloading = false; // Tracks download state

  Future<void> _downloadFile(String url, String fileName) async {
    try {
      if (await _requestPermission()) {
        setState(() {
          _isDownloading = true;
          _progress = 0.0;
        });

        Directory directory = await getApplicationDocumentsDirectory();
        String filePath = "${directory.path}/$fileName";

        Dio dio = Dio();
        await dio.download(url, filePath, onReceiveProgress: (count, total) {
          setState(() {
            _progress = count / total;
          });
        });

        setState(() {
          _isDownloading = false;
        });

        // Open the downloaded file
        OpenFilex.open(filePath);
      } else {
        print("Storage permission denied");
      }
    } catch (e) {
      print("Download failed: $e");
      setState(() {
        _isDownloading = false;
      });
    }
  }

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _downloadFile(
          "https://example.com/sample.pdf", // Replace with actual file URL
          "sample.pdf",
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Download Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(67, 184, 136, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_download_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _isDownloading
                        ? "Downloading... ${(_progress * 100).toStringAsFixed(0)}%"
                        : "Download PDF",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Overlay for Progress
          if (_isDownloading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
