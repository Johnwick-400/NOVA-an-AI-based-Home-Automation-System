import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;
  bool switch4 = false;
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();

  void sendCommand(String command) async {
    final response =
        await http.get(Uri.parse('http://192.168.50.198/$command'));

    if (response.statusCode == 200) {
      print('Command sent successfully');
    } else {
      print('Failed to send command');
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.speak(text);
  }

  void listenToSpeech() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Speech Recognition Status: $status');
        },
        onError: (error) {
          print('Speech Recognition Error: $error');
        },
      );

      if (available) {
        await _speech.listen(
          onResult: (result) {
            String command = result.recognizedWords.toLowerCase();

            if (command.contains('turn on light one')) {
              switch1 = true;
              sendCommand('turn_on1');
              _speak('Turning on light one.');
            } else if (command.contains('turn off light one')) {
              switch1 = false;
              sendCommand('turn_off1');
              _speak('Turning off light one.');
            } else if (command.contains('turn on light two')) {
              switch2 = true;
              sendCommand('turn_on2');
              _speak('Turning on light two.');
            } else if (command.contains('turn off light two')) {
              switch2 = false;
              sendCommand('turn_off2');
              _speak('Turning off light two.');
            } else if (command.contains('turn on light three')) {
              switch3 = true;
              sendCommand('turn_on3');
              _speak('Turning on light three.');
            } else if (command.contains('turn off light three')) {
              switch3 = false;
              sendCommand('turn_off3');
              _speak('Turning off light three.');
            } else if (command.contains('turn on light four')) {
              switch4 = true;
              sendCommand('turn_on4');
              _speak('Turning on light four.');
            } else if (command.contains('turn off light four')) {
              switch4 = false;
              sendCommand('turn_off4');
              _speak('Turning off light four.');
            }
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOVA AI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text('Switch 1'),
              trailing: Switch(
                value: switch1,
                onChanged: (value) {
                  setState(() {
                    switch1 = value;
                    sendCommand(value ? 'turn_on1' : 'turn_off1');
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Switch 2'),
              trailing: Switch(
                value: switch2,
                onChanged: (value) {
                  setState(() {
                    switch2 = value;
                    sendCommand(value ? 'turn_on2' : 'turn_off2');
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Switch 3'),
              trailing: Switch(
                value: switch3,
                onChanged: (value) {
                  setState(() {
                    switch3 = value;
                    sendCommand(value ? 'turn_on3' : 'turn_off3');
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Switch 4'),
              trailing: Switch(
                value: switch4,
                onChanged: (value) {
                  setState(() {
                    switch4 = value;
                    sendCommand(value ? 'turn_on4' : 'turn_off4');
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                listenToSpeech();
              },
              child: Text('Voice Control'),
            ),
          ],
        ),
      ),
    );
  }
}
