import 'package:flutter/material.dart';
import 'package:omr_scanner/file_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ORM Scanner'),
            ElevatedButton(
              onPressed: () async {
                var res = await FileService.instance.getFile();
                if (res != null) {
                  var result = await FileService.instance.uploadFile(res);
                  if (result != null) {
                    print(result);
                    Navigator.pushNamed(context, '/result');
                  }
                }
              },
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
