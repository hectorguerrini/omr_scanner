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
            const Text(
              'ORM Scanner',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
                'Por favor selecione seu arquivo do gabarito para saber o resultado.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var res = await FileService.instance.getFile();
                if (res != null) {
                  var result = await FileService.instance.uploadFile(res);
                  if (result != null) {
                    Navigator.pushNamed(context, '/result');
                  }
                }
              },
              child: const Text('Carregar Imagen'),
            ),
          ],
        ),
      ),
    );
  }
}
