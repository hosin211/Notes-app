import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class viewnotes extends StatelessWidget {
  Function addnote;
  int inde;
  String note;
  viewnotes(this.addnote, this.inde, this.note);

  @override
  Widget build(BuildContext context) {
    final textcontrol = TextEditingController(
      text: note,
    );
    textcontrol.selection = TextSelection.fromPosition(
        TextPosition(offset: textcontrol.text.length));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GradientText('Edit Note',
            gradient: LinearGradient(colors: [
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ])),
        elevation: 0,
      ),
      body: Container(
        child: Card(
          elevation: 200,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: textcontrol,
              onChanged: (String wnote) {
                note = wnote;
                addnote(inde, wnote, DateTime.now());
              },
              style: TextStyle(
                fontSize: 18,
              ),
              autofocus: false,
              maxLines: MediaQuery.of(context).size.height.toInt(),
            ),
          ),
        ),
      ),
    );
  }
}
