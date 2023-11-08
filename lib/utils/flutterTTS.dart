// ignore_for_file: file_names

import 'package:flutter_tts/flutter_tts.dart';

Future<void> voiceOver(String voiceOverSentence) async {
  final FlutterTts flutterTts = FlutterTts();

  await flutterTts.setLanguage("en-US");
  await flutterTts.setPitch(1);
  await flutterTts.speak(voiceOverSentence);
}

void stopVoiceOver() {
  final FlutterTts flutterTts = FlutterTts();
  flutterTts.stop();
}
