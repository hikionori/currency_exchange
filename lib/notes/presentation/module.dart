import 'package:flutter/material.dart';

class NotesModule extends StatefulWidget {
  const NotesModule({
    super.key,
    required this.notesWidth,
    required this.notesHeight,
  });

  final double notesWidth;
  final double notesHeight;

  @override
  State<NotesModule> createState() => _NotesModuleState();
}

class _NotesModuleState extends State<NotesModule> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.notesWidth,
      height: widget.notesHeight,
      child: Transform.translate(
        offset: const Offset(0, 0),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: Center(
            child: const Text("Notes"),
          ),
        ),
      ),
    );
  }
}
