import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:four_swipe_direction/four_swipe_direction.dart';
import 'package:get/get.dart';
import 'children/floating_action_button_item.dart';
import 'children/point_item.dart';
import 'children/score_item.dart';
import 'home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    final rightKey = GlobalKey<FlipCardState>();
    final leftKey = GlobalKey<FlipCardState>();
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlipCard(
            key: rightKey,
            flipOnTouch: false,
            direction: FlipDirection.VERTICAL,
            front: Obx(
              () => FourSwipeDirection(
                swipeUp: () {
                  controller.addScore(true);
                  rightKey.currentState?.toggleCard();
                },
                swipeDown: () {
                  controller.reduceScore(true);
                  rightKey.currentState?.toggleCard();
                },
                child: ScoreItem(
                  score: '${controller.rightScore}',
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            back: Obx(
              () => FourSwipeDirection(
                swipeUp: () {
                  controller.addScore(true);
                  rightKey.currentState?.toggleCard();
                },
                swipeDown: () {
                  controller.reduceScore(true);
                  rightKey.currentState?.toggleCard();
                },
                child: ScoreItem(
                  score: '${controller.rightScore}',
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => PointItem(
                      point: '${controller.leftPoint}',
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Obx(
                    () => PointItem(
                      point: '${controller.rightPoint}',
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.grey,
                  ),
                  onPressed: controller.courtChange,
                  child: const Text(
                    'コートチェンジ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          FlipCard(
            key: leftKey,
            flipOnTouch: false,
            direction: FlipDirection.VERTICAL,
            front: Obx(
              () => FourSwipeDirection(
                swipeUp: () {
                  controller.addScore(false);
                  leftKey.currentState?.toggleCard();
                },
                swipeDown: () {
                  controller.reduceScore(false);
                  leftKey.currentState?.toggleCard();
                },
                child: ScoreItem(
                  score: "${controller.leftScore}",
                  color: Colors.redAccent,
                ),
              ),
            ),
            back: Obx(
              () => FourSwipeDirection(
                swipeUp: () {
                  controller.addScore(false);
                  leftKey.currentState?.toggleCard();
                },
                swipeDown: () {
                  controller.reduceScore(false);
                  leftKey.currentState?.toggleCard();
                },
                child: ScoreItem(
                  score: "${controller.leftScore}",
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonItem(
        onPressed: () => openDialog(
          context: context,
          controller: controller,
        ),
      ),
    );
  }

  void openDialog({
    required BuildContext context,
    required HomeScreenController controller,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            '得点のリセット',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          content: const Text(
            '\n'
            '得点のリセットを行います\n'
            '本当によろしいでしょうか？'
            '\n',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                //TODO 得点をリセットする。
                controller.reset();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                "キャンセル",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
