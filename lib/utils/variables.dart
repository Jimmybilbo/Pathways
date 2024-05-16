import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

myStyle (double size, [Color color = Colors.white, FontWeight fw = FontWeight.normal]) {
  return GoogleFonts.afacad(
    fontSize: size,
    color: color,
    fontWeight: fw
  );
}



CollectionReference usercollection = FirebaseFirestore.instance.collection('users');