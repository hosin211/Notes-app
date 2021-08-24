//@dart=2.9
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/widgets/noteview.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import './data/notes.dart';
import 'widgets/addnotesscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    return MaterialApp(
      title: 'notes',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomescrren(),
    );
  }
}

class MyHomescrren extends StatefulWidget {
  @override
  _MyHomescrrenState createState() => _MyHomescrrenState();
}

class _MyHomescrrenState extends State<MyHomescrren> {
  SwipeActionController controller;

  final List<notes> thenotes = [];
  final df = new DateFormat('hh:mm MM/dd');
  void addnot(int inde, String note, DateTime writiontime) {
    final newnote = new notes(note, writiontime);
    if (inde < thenotes.length) {
      setState(() {
        thenotes[inde].note = note;
        thenotes[inde].writontime = writiontime;
      });
    } else {
      setState(() {
        thenotes.add(newnote);
      });
    }
    if (note.trim().isEmpty) {
      thenotes.removeAt(inde);
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push<void>(SwipeablePageRoute(
              builder: (_) => AddNotes(addnot, thenotes.length),
            ));
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          actions: [
            Icon(
              Icons.more_horiz,
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              size: 30,
            ),
            const SizedBox(
              width: 12,
            ),
          ],
          title: GradientText("Notes",
              gradient: LinearGradient(colors: [
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ]),
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
              elevation: 20,
              child: ListView.builder(
                  itemCount: thenotes.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SwipeActionCell(
                        performsFirstActionWithFullSwipe: true,
                        key: ObjectKey(thenotes[index]),
                        firstActionWillCoverAllSpaceOnDeleting: true,
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                            widthSpace: 90,
                            title: "delete",
                            onTap: (CompletionHandler handler) async {
                              thenotes.removeAt(index);
                              setState(() {});
                            },
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                          ),
                        ],
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push<void>(SwipeablePageRoute(
                                  builder: (_) => viewnotes(
                                      addnot, index, thenotes[index].note),
                                ));
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: InteractiveViewer(
                                      constrained: false,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            thenotes[index].note.trim(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Text(
                                            df.format(
                                                thenotes[index].writontime),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
          color: Colors.white,
        ),
      ),
    );
  }
}
