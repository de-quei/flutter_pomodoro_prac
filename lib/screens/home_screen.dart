import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500; // 25분을 초로 환산하면 1500초
  late Timer timer; // late modifier : property를 당장 초기화 하지 않아도 됨을 의미

  // onTick 함수는 State를 변경함.
  void onTick(Timer timer) {
    setState(() {
      totalSeconds = totalSeconds - 1;
    });
  }

  void onStartPressed() {
    // Timer.periodic(duration(주기), (timer) { })
    // timer 함수를 주기별로 실행함을 의미. 주기는 마음대로 지정할 수 있음.
    // 함수를 넣을 때 괄호를 넣지 않는 것을 기억하기! (타이머가 알아서 괄호의 역할을 수행해줌)
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    // Timer는 1초에 한번씩 onTick 함수를 실행.
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
                '$totalSeconds',
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
                onPressed: onStartPressed,
                icon: const Icon(Icons.play_circle_outline),
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
                          '0',
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
