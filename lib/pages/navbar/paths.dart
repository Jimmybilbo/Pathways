import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';

class PathsPage extends StatefulWidget {
  const PathsPage({super.key});

  @override
  State<PathsPage> createState() => _PathsPageState();
}

class _PathsPageState extends State<PathsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Paths Page', style: myStyle(30)),
    );
  }
}