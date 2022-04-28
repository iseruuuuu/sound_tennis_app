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

  //TODO マッチポイント
  var rightPoint = 0.obs;
  var leftPoint = 0.obs;

  //TODO ゲームポイント
  var rightGame = 0.obs;
  var leftGame = 0.obs;

  final FlutterTts tts = FlutterTts();

  Future<void> speak() async {
    await tts.speak('${rightScore.value} - ${leftScore.value}');
  }

  Future<void> addScore(bool isScore) async {
    if (isScore) {
      switch (rightScore.value) {
        case 0:
          rightScore.value = 15;
          break;
        case 15:
          rightScore.value = 30;
          break;
        case 30:
          rightScore.value = 40;
          break;
        default:
        //TODO デュースの処理を作成する。
      }
    } else {
      switch (leftScore.value) {
        case 0:
          leftScore.value = 15;
          break;
        case 15:
          leftScore.value = 30;
          break;
        case 30:
          leftScore.value = 40;
          break;
        default:
        //TODO デュースの処理を作成する。
      }
    }
    speak();
  }

  Future<void> reduceScore(bool isScore) async {
    if (isScore) {
      switch (rightScore.value) {
        case 15:
          rightScore.value = 0;
          break;
        case 30:
          rightScore.value = 15;
          break;
        case 40:
          rightScore.value = 30;
          break;
        default:
      }
    } else {
      switch (leftScore.value) {
        case 15:
          leftScore.value = 0;
          break;
        case 30:
          leftScore.value = 15;
          break;
        case 40:
          leftScore.value = 30;
          break;
        default:
      }
    }
    speak();
  }

  void addPoint(bool isScore) {
    if (isScore) {
      rightPoint.value++;
    } else {
      leftPoint.value++;
    }
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
    var beforeRightGame = leftGame.value;
    var beforeLeftGame = rightGame.value;
    rightPoint.value = beforeLeftPoint;
    leftPoint.value = beforeRightPoint;
    rightGame.value = beforeLeftGame;
    leftGame.value = beforeRightGame;

    tts.speak('court change');
  }

  void reset() {
    rightScore.value = 0;
    rightPoint.value = 0;
    rightGame.value = 0;
    leftScore.value = 0;
    leftPoint.value = 0;
    leftGame.value = 0;
    tts.stop();
  }
}
