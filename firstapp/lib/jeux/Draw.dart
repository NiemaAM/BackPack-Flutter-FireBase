// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: constant_identifier_names, file_names

import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:firstapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../widgets/pop_up_draw.dart';

class Draw extends StatefulWidget {
  const Draw({Key key}) : super(key: key);

  @override
  _DrawState createState() => _DrawState();
}

AudioCache player = AudioCache(fixedPlayer: AudioPlayer());

class _DrawState extends State<Draw> {
  bool _state1 = false;
  bool _state2 = false;
  bool _state3 = false;
  bool _state4 = false;
  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  double opacity = 1.0;
  bool showBottomList = false;
  StrokeCap strokeCap =
      (Platform.isAndroid) ? StrokeCap.round : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<DrawingPoints> points = [];
  List<Color> eraser = [Colors.white];
  List<Color> colors = [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.lightBlue,
    Colors.amber,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomDialogBox(
                                text: "Retour",
                                text2: "Annuler",
                                descriptions: " ",
                                title: "Es-tu sure de vouloir quitter ?",
                              );
                            });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.brightness_1,
                        color: (_state1) ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _state1 = !_state1;
                          showBottomList = !showBottomList;
                          selectedMode = SelectedMode.StrokeWidth;
                        });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.opacity,
                        color: (_state2) ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _state2 = !_state2;
                          showBottomList = !showBottomList;
                          selectedMode = SelectedMode.Opacity;
                        });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.color_lens,
                        color: (_state3) ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _state3 = !_state3;
                          showBottomList = !showBottomList;
                          selectedMode = SelectedMode.Color;
                        });
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.brightness_1_outlined,
                        color: (_state4) ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_state4 == false) {
                            selectedColor = Colors.white;
                            _state4 = true;
                          } else {
                            selectedColor = Colors.black;
                            _state4 = false;
                          }
                        });
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.block_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _state1 = false;
                          _state2 = false;
                          _state3 = false;
                          _state4 = false;
                          selectedColor = Colors.black;
                          showBottomList = false;
                          points.clear();
                        });
                      }),
                ],
              ),
              Visibility(
                child: (selectedMode == SelectedMode.Color)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: getColorList(),
                      )
                    : SliderTheme(
                        data: const SliderThemeData(
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            value: (selectedMode == SelectedMode.StrokeWidth)
                                ? strokeWidth
                                : opacity,
                            max: (selectedMode == SelectedMode.StrokeWidth)
                                ? 50.0
                                : 1.0,
                            min: 0.0,
                            onChanged: (val) {
                              setState(() {
                                if (selectedMode == SelectedMode.StrokeWidth) {
                                  strokeWidth = val;
                                } else {
                                  opacity = val;
                                }
                              });
                            }),
                      ),
                visible: showBottomList,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) async {
          setState(() {
            points.add(DrawingPoints(
                points: details.localPosition,
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanStart: (details) async {
          setState(() {
            points.add(DrawingPoints(
                points: details.localPosition,
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanEnd: (details) async {
          setState(() {
            points.add(null);
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: DrawingPainter(
            pointsList: points,
          ),
        ),
      ),
    );
  }

  getColorList() {
    List<Widget> listWidget = [];
    for (Color color in colors) {
      listWidget.add(colorCircle(color));
    }
    Widget colorPicker = GestureDetector(
      onTap: () {
        showDialog(
          builder: (context) => AlertDialog(
            title: AppText(
              text: 'Choisi une couleur !',
              size: 30,
            ),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  pickerColor = color;
                },
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: AppText(
                  text: 'Choisir  ',
                  size: 25,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() => selectedColor = pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          context: context,
        );
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20.0),
          height: 36,
          width: 36,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.white, Colors.black, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
      ),
    );

    listWidget.add(colorPicker);
    return listWidget;
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: ClipOval(
        child: Container(
          height: 35,
          width: 35,
          color: color,
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  List<DrawingPoints> pointsList = [];
  List<Offset> offsetPoints = [];

  DrawingPainter({this.pointsList});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;

  DrawingPoints({this.paint, this.points});
}

enum SelectedMode { StrokeWidth, Opacity, Color }
