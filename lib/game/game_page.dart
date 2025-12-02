import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:poingpoing_app/poingpoing_game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final PoingPoingGame _game;

  @override
  void initState() {
    super.initState();
    _game = PoingPoingGame(onGameOver: _onGameOver);
  }

  void _onGameOver(int score) {
    // 결과 다이얼로그
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '게임 종료!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '이번 기록: $score 층',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫고
                        Navigator.of(context).pop(); // 게임 화면 닫고 홈으로
                      },
                      child: const Text('홈으로'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그만 닫고
                        _game.reset();              // 게임 다시 시작
                      },
                      child: const Text('다시하기'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (details) {
              final dy = details.localPosition.dy;
              // 화면 아래 35%에서만 제스처 시작
              if (dy > height * 0.5) {
                _game.onChargeStart(dy);
              }
            },
            onPanUpdate: (details) {
              _game.onChargeUpdate(details.localPosition.dy);
            },
            onPanEnd: (details) {
              _game.onChargeEnd();
            },
            child: Stack(
              children: [
                // Flame Game
                GameWidget(game: _game),

                // 상단 HUD
                Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 16,
                  right: 16,
                  child: _TopHud(game: _game),
                ),

                // 하단 제스처 안내 + 게이지
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _BottomControl(game: _game),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TopHud extends StatelessWidget {
  final PoingPoingGame game;

  const _TopHud({required this.game});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 점수
          ValueListenableBuilder<int>(
            valueListenable: game.scoreNotifier,
            builder: (_, score, __) {
              return Text(
                '$score 층',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // 일단은 그냥 뒤로가기
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
            tooltip: '나가기',
          ),
        ],
      ),
    );
  }
}

class _BottomControl extends StatelessWidget {
  final PoingPoingGame game;

  const _BottomControl({required this.game});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '아래 영역을 아래로 드래그해서 점프 파워를 모아요',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          // 파워 게이지
          ValueListenableBuilder<double>(
            valueListenable: game.chargeRatioNotifier,
            builder: (_, ratio, __) {
              final percent = (ratio * 100).round();
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: ratio.clamp(0, 1),
                      minHeight: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '파워: $percent%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
