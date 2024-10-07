import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isanimating = false;
  String data = '';
  bool speechEnabled = false;
  final SpeechToText _speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      data = result.recognizedWords;
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // mic for the audio
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarGlow(
            endRadius: 80,
            animate: isanimating,
            duration: const Duration(milliseconds: 2000),
            glowColor: Colors.green,
            repeat: true,
            showTwoGlows: true,
            child: GestureDetector(
              onTapDown: (details) {
                setState(() {
                  isanimating = true;
                  data = '';
                  _startListening();
                });
              },
              onTapUp: (details) {
                setState(() {
                  isanimating = !isanimating;
                  _stopListening();
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 30,
                child: isanimating
                    ? const Icon(
                        Icons.mic,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.mic_none,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
          data.isNotEmpty
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Tap the microphone to say...',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : Container()
        ],
      ),

      appBar: AppBar(
        title: const Text("My AI"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
          padding: const EdgeInsets.all(10),
          child: data.isEmpty
              ? const Text(
                  'Tap the microphone to say...',
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )
              : Text(
                  data,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
