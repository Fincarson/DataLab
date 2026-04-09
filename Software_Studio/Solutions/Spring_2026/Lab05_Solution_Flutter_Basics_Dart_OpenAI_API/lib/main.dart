import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:lab05_example/services/image_generation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageGeneratorHome(),
    );
  }
}

class ImageGeneratorHome extends StatefulWidget {
  @override
  _ImageGeneratorHomeState createState() => _ImageGeneratorHomeState();
}

class _ImageGeneratorHomeState extends State<ImageGeneratorHome> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Uint8List? _base64Decode;
  String? _errorMessage;

  void _generateImage(String prompt) async {
    setState(() {
      _isLoading = true;
      _base64Decode = null;
      _errorMessage = null;
    });

    // TODO: Complete the code
    final result = await ImageGenerationService().generateImage(prompt);

    setState((){
      _isLoading = false;

      if(result["success"] == true){
        _base64Decode = result["base64Decoder"];
      } else {
        _errorMessage = result["message"] ?? "Failed to generate image.";
      }
    });
  }

  Widget showResponse() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(_errorMessage!)),
      );
    }

    if (_base64Decode == null) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: Text('No image generated yet.')),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: PhotoView(
        imageProvider: MemoryImage(_base64Decode!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Generator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Enter your prompt'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _generateImage(_controller.text);
              }
            },
            child: Text('Generate Image'),
          ),
          Expanded(
            child: showResponse(),
          ),
        ],
      ),
    );
  }
}
