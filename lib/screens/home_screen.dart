import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const fifteenMin = 900;
  static const twentyMin = 1200;
  static const twentyFiveMin = 1500;
  static const thirtyMin = 1800;
  static const thiryFiveMin = 2100;
  static const fiveMinBreak = 300;

  late Timer timer;
  int totalSeconds = twentyFiveMin;
  bool isRunning = false;
  bool isFiveMinBreak = false;
  int totalGoals = 0; // 0 ~ 12
  int totalRound = 0; // 0 ~ 4

  void setTotalSeconds(int minutes) {
    if (minutes == fifteenMin) {
      totalSeconds = fifteenMin;
    } else if (minutes == twentyMin) {
      totalSeconds = twentyMin;
    } else if (minutes == twentyFiveMin) {
      totalSeconds = twentyFiveMin;
    } else if (minutes == thirtyMin) {
      totalSeconds = thirtyMin;
    } else if (minutes == thiryFiveMin) {
      totalSeconds = thiryFiveMin;
    }
    setState(() {});
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalGoals++;
        isRunning = false;
        totalSeconds = twentyFiveMin;
        if (totalGoals % 4 == 0 && totalGoals > 0) {
          totalRound = totalGoals ~/ 4;
          isFiveMinBreak = true;
          totalSeconds = fiveMinBreak;
          breakTime();
        }
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onBreakTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isFiveMinBreak = false;
        totalSeconds = twentyFiveMin;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void breakTime() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onBreakTick,
    );
    setState(() {
      isFiveMinBreak = true;
    });
  }

  void onBreakTimeEndPressed() {
    setState(() {
      isFiveMinBreak = false;
      totalSeconds = twentyFiveMin;
    });
    timer.cancel();
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    totalSeconds = twentyFiveMin;
    setState(() {
      isRunning = false;
    });
  }

  String timeMinFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4); //23:22
  }

  String timeSecondFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isFiveMinBreak
            ? Theme.of(context).focusColor
            : Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'POMOTIMER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 3,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 140,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Center(
                          child: Text(
                            timeMinFormat(totalSeconds),
                            style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w700,
                                color: isFiveMinBreak
                                    ? Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .color
                                    : Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .color),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        ':',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 110,
                        height: 140,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Center(
                          child: Text(
                            timeSecondFormat(totalSeconds),
                            style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w700,
                                color: isFiveMinBreak
                                    ? Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .color
                                    : Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .color),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isFiveMinBreak)
                    const Text(
                      'BREAK TIME',
                      style: TextStyle(
                        fontSize: 60,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    )
                  else
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: <Widget>[
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              side: BorderSide(
                                  width: 3.0,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            onPressed: () => setTotalSeconds(fifteenMin),
                            child: const Text(
                              '15',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              side: BorderSide(
                                  width: 3.0,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            onPressed: () => setTotalSeconds(twentyMin),
                            child: const Text(
                              '20',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              side: BorderSide(
                                  width: 3.0,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            onPressed: () => setTotalSeconds(twentyFiveMin),
                            child: const Text(
                              '25',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              side: BorderSide(
                                  width: 3.0,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            onPressed: () => setTotalSeconds(thirtyMin),
                            child: const Text(
                              '30',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              side: BorderSide(
                                  width: 3.0,
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            onPressed: () => setTotalSeconds(thiryFiveMin),
                            child: const Text(
                              '35',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isFiveMinBreak)
                    Center(
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 100,
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        icon: isRunning
                            ? const Icon(Icons.pause_circle_outline)
                            : const Icon(Icons.play_circle_outline_outlined),
                      ),
                    )
                  else
                    Center(
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 100,
                        onPressed: onBreakTimeEndPressed,
                        icon: const Icon(Icons.fast_forward),
                      ),
                    ),
                  if (isRunning)
                    // reset Button
                    Center(
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 100,
                        onPressed: onResetPressed,
                        icon: const Icon(Icons.restore),
                      ),
                    ),
                ],
              ),
            ),
            Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalRound/4',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'ROUND',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 100),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalGoals/12',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'GOAL',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
