import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({
    super.key,
    required this.title,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .50,
              width: MediaQuery.of(context).size.width * .50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              // display selected image or icon
              child: _imageFile == null
                  ? const Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                      ),
                    )
                  : Image.file(
                      File(
                        _imageFile!.path,
                      ),
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                _showImageSourceOptions();
              },
              child: const Text('Select a picture'),
            ),
          ],
        ),
      ),
    );
  }

  // method to show image source options
  Future<void> _showImageSourceOptions() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                ),
                title: const Text(
                  'Take a picture',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(
                    ImageSource.camera,
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                ),
                title: const Text(
                  'Choose from gallery',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(
                    ImageSource.gallery,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // method to pick image
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 30,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      setState(() {
        _imageFile = imageFile;
      });
    }
  }
}
