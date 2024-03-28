import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = 1500; // 25분을 초로 환산하면 1500초
  bool isRunning = false; // 동작여부를 나타내는 변수
  late Timer timer; // late modifier : property를 당장 초기화 하지 않아도 됨을 의미
  int totalPomodoros = 0;

  // onTick 함수는 State를 변경함.
  // 매 초마다 실행되는 메서드
  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  // 동작할때 메서드
  void onStartPressed() {
    // Timer.periodic(duration(주기), (timer) { })
    // timer 함수를 주기별로 실행함을 의미. 주기는 마음대로 지정할 수 있음.
    // 함수를 넣을 때 괄호를 넣지 않는 것을 기억하기! (타이머가 알아서 괄호의 역할을 수행해줌)
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    // Timer는 1초에 한번씩 onTick 함수를 실행.
    setState(() {
      isRunning = true; // 동작 여부를 true로 변경 후 State도 변경해줌.
    });
  }

  // 동작이 멈췄을때 메서드
  void onPausePressed() {
    timer.cancel(); // 타이머가 멈추고
    setState(() {
      isRunning = false; // 동작 여부를 false로 변경 후 State도 변경해줌.
    });
  }

  // 25:00 형식으로 데이터를 포맷하는 과정
  // 실제 0:25:00.00000
  // 첫 번째 - .을 기준으로 split하여 0:25:00을 가져옴
  // 두 번째 = 가져온 문자열을 2 ~ 7만 사용할 수 있도록 substring 이용
  String format(int seconds) {
    var duration = Duration(seconds: seconds);

    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // Flexible : 하나의 박스가 얼만큼의 공간을 차지할 지 비율을 정할 수 있음.
          // Framework와 Flutter Engine이 정확한 비율을 맞춰줌.
          // width : 400px 같이 하드코딩 할 경우에는 기기 별로 보이는 크기가 다를 수 있음!
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                // 삼항 연산자로 경우에 맞는 메서드를 실행.
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(isRunning
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              //Row로 감싸면 컨테이너의 위치가 bottomCenter에서 bottomLeft로 이동.
              children: [
                Expanded(
                  //Expended : 위젯을 확장시켜주는 역할
                  child: Container(
                    //컨테이너만 설정하면 텍스트가 들어간 컨테이너가 BottomCenter에만 자리를 차지함.
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
