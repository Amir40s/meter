// import 'package:flutter/material.dart';
//
// import '../model/voice/voiceRecorder.dart';
//
// class VoiceRecordingButton extends StatefulWidget {
//   final Function(String) onSendVoiceMessage;
//
//   VoiceRecordingButton({required this.onSendVoiceMessage});
//
//   @override
//   _VoiceRecordingButtonState createState() => _VoiceRecordingButtonState();
// }
//
// class _VoiceRecordingButtonState extends State<VoiceRecordingButton> {
//   final VoiceRecorder _recorder = VoiceRecorder();
//   bool _isRecording = false;
//
//   void _startRecording() async {
//     await _recorder.startRecording();
//     setState(() {
//       _isRecording = true;
//     });
//   }
//
//   void _stopRecording() async {
//     await _recorder.stopRecording();
//     setState(() {
//       _isRecording = false;
//     });
//     widget.onSendVoiceMessage(_recorder.path);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: _startRecording,
//       onLongPressUp: _stopRecording,
//       child: Icon(
//         Icons.mic,
//         color: _isRecording ? Colors.red : Colors.black,
//       ),
//     );
//   }
// }
