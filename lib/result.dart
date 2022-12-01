import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'omr.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAsset();
  }

  OMRModel? omrModel;
  Future<void> loadAsset() async {
    try {
      var res = await rootBundle.loadString('assets/res.json');
      var obj = jsonDecode(res);
      omrModel = OMRModel.fromJson(obj);
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: FutureBuilder(
          future: loadAsset(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return Center(
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                    maxHeight: MediaQuery.of(context).size.height * 0.6),
                child: Card(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      Image.memory(base64Decode(omrModel!.imageB64)),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(omrModel!.getEmoji,
                                style: const TextStyle(fontSize: 48)),
                            Text(
                              'Resultado:\n${omrModel!.percentCorrect}%',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
