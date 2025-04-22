import 'package:flutter/material.dart';

class ServerpodBackground extends StatelessWidget {
  final Widget child;
  
  const ServerpodBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // 防止渐变期间的闪烁
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 基础渐变背景
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFF0052B1), Color(0xFF010A1C)],
              ),
            ),
          ),
          
          // 第一个粉色径向渐变
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.8, -0.6),
                  radius: 1.2,
                  colors: [
                    const Color(0xFFFF7373).withOpacity(0.3),
                    Colors.transparent,
                  ],
                  stops: const [0.1, 1.0],
                ),
              ),
            ),
          ),
          
          // 第二个粉色径向渐变
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.6, 0.8),
                  radius: 1.2,
                  colors: [
                    const Color(0xFFFF7373).withOpacity(0.3),
                    Colors.transparent,
                  ],
                  stops: const [0.1, 1.0],
                ),
              ),
            ),
          ),
          
          // 子组件
          child,
        ],
      ),
    );
  }
}