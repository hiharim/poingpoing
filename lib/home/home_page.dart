import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB9E6FF),
              Color(0xFFF7FBFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 24),
                  // 타이틀 영역
                  Column(
                    children: [
                      Text(
                        '포잉포잉',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2B2B2B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '구름 사다리를 당겨서\n판다를 하늘 위로 쏘아올려봐!',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ],
                  ),

                  // 가운데 판다 / 사다리 일러스트 자리 (지금은 대충 placeholder)
                  Column(
                    children: [
                      Container(
                        width: 220,
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // 구름
                            Positioned(
                              top: 32,
                              child: Container(
                                width: 140,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                            // 사다리
                            Positioned(
                              top: 80,
                              child: Container(
                                width: 8,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB0C4DE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            // 판다 동그라미
                            Positioned(
                              bottom: 40,
                              child: Column(
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.pets,
                                      size: 40,
                                      color: Color(0xFF2B2B2B),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '퐁...',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // 시작 버튼
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/game');
                          },
                          child: const Text(
                            '시작하기',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '아래로 쭉 드래그해서 점프 파워를 모을 수 있어요',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
