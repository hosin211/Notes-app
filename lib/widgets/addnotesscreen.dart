import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class AddNotes extends StatelessWidget {
  Function addnote;
  int inde;
  AddNotes(this.addnote, this.inde);
  final textcontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: GradientText('Add Note',
            gradient: LinearGradient(colors: [
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ])),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Card(
          elevation: 200,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none),
              controller: textcontrol,
              onChanged: (String note) {
                addnote(inde, note, DateTime.now());
              },
              style: TextStyle(
                fontSize: 18,
              ),
              autofocus: true,
              maxLines: MediaQuery.of(context).size.height.toInt(),
            ),
          ),
        ),
      ),
    );
  }
}
