import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

typedef GameOverCallback = void Function(int score);

class PoingPoingGame extends FlameGame {
  PoingPoingGame({required this.onGameOver});

  final GameOverCallback onGameOver;

  // 점수 & 차지 비율을 Flutter 쪽에서 listen 하기 위함
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<double> chargeRatioNotifier = ValueNotifier<double>(0.0);

  double _dragStartY = 0;
  bool _isCharging = false;

  // TODO: 판다, 구름, 카메라 등은 나중에 추가
  // late final PandaComponent panda;

  // 배경색을 파스텔 하늘색으로
  @override
  Color backgroundColor() => const Color(0xFFB9E6FF);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 디버그용 텍스트 컴포넌트 하나 추가
    add(
      TextComponent(
        text: 'PoingPoing',
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
      ),
    );

    // 배경 색
    camera.viewport = FixedResolutionViewport(resolution: Vector2(390, 844));
    // 나중에 여기서 판다/구름 add() 할 거임
  }

  // --------------------
  // 제스처에서 호출할 API
  // --------------------

  void onChargeStart(double globalDy) {
    // 이미 점프 중이면 무시
    if (_isCharging) return;
    _isCharging = true;
    _dragStartY = globalDy;
    chargeRatioNotifier.value = 0.0;
    // TODO: 판다 charging 상태 진입
  }

  void onChargeUpdate(double globalDy) {
    if (!_isCharging) return;
    final drag = (globalDy - _dragStartY);
    const maxDrag = 220.0;
    final ratio = (drag / maxDrag).clamp(0.0, 1.0);
    chargeRatioNotifier.value = ratio;
    // TODO: 판다/사다리 모양 업데이트
  }

  void onChargeEnd() {
    if (!_isCharging) return;
    _isCharging = false;
    final ratio = chargeRatioNotifier.value;
    // TODO: ratio 기반으로 점프 시작 (판다 velocity 설정)
    // 일단은 그냥 score++ 테스트
    scoreNotifier.value += 1;
    chargeRatioNotifier.value = 0.0;
  }

  // 게임 오버 호출
  void gameOver() {
    onGameOver(scoreNotifier.value);
  }

  // 다시하기용 리셋
  void reset() {
    scoreNotifier.value = 0;
    chargeRatioNotifier.value = 0.0;
    _isCharging = false;
    // TODO: 판다 위치/속도, 카메라, 구름 전부 리셋
  }

  @override
  void update(double dt) {
    super.update(dt);
    // TODO: 판다 점프/낙하, 충돌 판정, 게임오버 체크 등 여기서
  }
}
