import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'utils/flutterTTS.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpeechRecognitionExample(),
    );
  }
}

class SpeechRecognitionExample extends StatefulWidget {
  @override
  _SpeechRecognitionExampleState createState() =>
      _SpeechRecognitionExampleState();
}

class _SpeechRecognitionExampleState extends State<SpeechRecognitionExample> {
  late stt.SpeechToText _speech;
  String _text = "Press the button and start speaking...";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    initializeAndStartVoiceOver();
  }

  void initializeAndStartVoiceOver() async {
    await _initSpeechRecognizer();
    _startVoiceOver();
    startListening();
  }

  Future<void> _initSpeechRecognizer() async {
    if (!_speech.isAvailable) {
      await _speech.initialize(
        onStatus: (status) {
          if (status == 'notListening') {
            startListening(); // Start listening again when it's not listening
          }
        },
        finalTimeout: const Duration(minutes: 1),
        onError: (errorNotification) {
          print('Error: $errorNotification');
        },
      );
    }
  }

  void startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _text = result.recognizedWords;

          // Add logic to handle trigger words and navigation
          if (result.recognizedWords.toLowerCase().contains('voice command')) {
            // Trigger word recognized, navigate to the next screen
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NextScreen();
            }));
          }
        });
      },
    );
  }

  void _startVoiceOver() {
    voiceOver("Welcome to SGS chat.\n"
        // "Speak to us using voice commands, or you can type your questions using text.\n"
        // "Here are some examples."
        // "What is the status of Flight AC123?\n"
        // "How do I get to the baggage claim area?\n"
        // "I need wheelchair assistance.\n"
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Recognition Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text('This is the next screen.'),
      ),
    );
  }
}
