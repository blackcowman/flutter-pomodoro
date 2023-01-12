import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int twentyFiveMinutes = 1500;
  int totalSecond = twentyFiveMinutes;
  late Timer timer;
  bool isRunning = false;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSecond == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSecond = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecond = totalSecond - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);

    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(format(totalSecond),
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 89,
                        fontWeight: FontWeight.w600)),
              )),
          Flexible(
              flex: 3,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    isRunning ? onPausePressed() : onStartPressed();
                  },
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outlined
                      : Icons.play_circle_outlined),
                  color: Theme.of(context).cardColor,
                  iconSize: 120,
                ),
              )),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontSize: 60,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
