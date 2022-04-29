import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  HomeScreenController() {
    tts.setLanguage('en-US');
    tts.setSpeechRate(0.5);
  }

  //TODO 点数
  var rightScore = 0.obs;
  var leftScore = 0.obs;

  var rightStringScore = '0'.obs;
  var leftStringScore = '0'.obs;

  //TODO マッチポイント
  var rightPoint = 0.obs;
  var leftPoint = 0.obs;

  //TODO ゲームポイント
  var rightGame = 0.obs;
  var leftGame = 0.obs;

  final FlutterTts tts = FlutterTts();

  Future<void> speak() async {
    if (rightStringScore.value == 'A') {
      await tts.speak('Advantage - ${leftStringScore.value}');
    } else if (leftStringScore.value == 'A') {
      await tts.speak('${rightStringScore.value} - Advantage');
    } else {
      await tts.speak('${rightStringScore.value} - ${leftStringScore.value}');
    }
  }

  void checkDeuce(bool isScore) {
    if (rightScore.value >= 40 && leftScore.value >= 40) {
      if (rightScore.value >= leftScore.value + 2 ||
          leftScore.value >= rightScore.value + 2) {
        if (isScore) {
          addPoint(true);
          rightScore.value = 0;
          leftScore.value = 0;
          rightStringScore.value = rightScore.value.toString();
          leftStringScore.value = leftScore.value.toString();
        } else {
          addPoint(false);
          rightScore.value = 0;
          leftScore.value = 0;
          rightStringScore.value = rightScore.value.toString();
          leftStringScore.value = leftScore.value.toString();
        }
      } else {
        if (isScore) {
          if (rightScore.value >= leftScore.value) {
            rightScore.value++;
            rightStringScore.value = 'A';
            leftStringScore.value = '40';
          } else {
            rightScore.value++;
            rightStringScore.value = '40';
            leftStringScore.value = '40';
          }
          speak();
        } else {
          if (rightScore.value <= leftScore.value) {
            leftScore.value++;
            leftStringScore.value = 'A';
            rightStringScore.value = '40';
          } else {
            leftScore.value++;
            leftStringScore.value = '40';
            rightStringScore.value = '40';
          }
          speak();
        }
      }
    } else {
      addScore(isScore);
    }
  }

  Future<void> addScore(bool isScore) async {
    if (isScore) {
      switch (rightScore.value) {
        case 0:
          rightScore.value = 15;
          rightStringScore.value = rightScore.value.toString();
          break;
        case 15:
          rightScore.value = 30;
          rightStringScore.value = rightScore.value.toString();
          break;
        case 30:
          rightScore.value = 40;
          rightStringScore.value = rightScore.value.toString();
          break;
        default:
          addPoint(true);
      }
    } else {
      switch (leftScore.value) {
        case 0:
          leftScore.value = 15;
          leftStringScore.value = leftScore.value.toString();
          break;
        case 15:
          leftScore.value = 30;
          leftStringScore.value = leftScore.value.toString();
          break;
        case 30:
          leftScore.value = 40;
          leftStringScore.value = leftScore.value.toString();
          break;
        default:
          addPoint(false);
      }
    }
    speak();
  }

  Future<void> reduceScore(bool isScore) async {
    if (isScore) {
      switch (rightScore.value) {
        case 15:
          rightScore.value = 0;
          rightStringScore.value = rightScore.value.toString();
          break;
        case 30:
          rightScore.value = 15;
          rightStringScore.value = rightScore.value.toString();
          break;
        case 40:
          rightScore.value = 30;
          rightStringScore.value = rightScore.value.toString();
          break;
        default:
      }
    } else {
      switch (leftScore.value) {
        case 15:
          leftScore.value = 0;
          leftStringScore.value = leftScore.value.toString();
          break;
        case 30:
          leftScore.value = 15;
          leftStringScore.value = leftScore.value.toString();
          break;
        case 40:
          leftScore.value = 30;
          leftStringScore.value = leftScore.value.toString();
          break;
        default:
      }
    }
    speak();
  }

  void addPoint(bool isScore) {
    if (isScore) {
      if (rightPoint.value >= 6) {
        rightPoint.value = 0;
        rightGame.value++;
      } else {
        rightPoint.value++;
      }
    } else {
      if (leftPoint.value >= 6) {
        leftPoint.value = 0;
        leftGame.value++;
      } else {
        leftPoint.value++;
      }
    }
    rightScore.value = 0;
    leftScore.value = 0;
    rightStringScore.value = rightScore.value.toString();
    leftStringScore.value = leftScore.value.toString();
  }

  void addGame(bool isScore) {
    if (isScore) {
      rightGame.value++;
    } else {
      leftGame.value++;
    }
  }

  void courtChange() {
    var beforeLeftPoint = leftPoint.value;
    var beforeRightPoint = rightPoint.value;
    var beforeRightGame = rightGame.value;
    var beforeLeftGame = leftGame.value;
    rightPoint.value = beforeLeftPoint;
    leftPoint.value = beforeRightPoint;
    rightGame.value = beforeLeftGame;
    leftGame.value = beforeRightGame;
    rightStringScore.value = rightScore.value.toString();
    leftStringScore.value = leftScore.value.toString();
    tts.speak('court change');
  }

  void reset() {
    rightScore.value = 0;
    rightPoint.value = 0;
    rightGame.value = 0;
    leftScore.value = 0;
    leftPoint.value = 0;
    leftGame.value = 0;
    rightStringScore.value = rightScore.value.toString();
    leftStringScore.value = leftScore.value.toString();
    tts.stop();
  }
}
