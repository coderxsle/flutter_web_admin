import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CountDownButton extends StatefulWidget {
  final VoidCallback onTap;
  int countdownSeconds;
  CountDownButton({super.key, required this.onTap, this.countdownSeconds=60});

  @override
  CountDownButtonState createState() => CountDownButtonState();
}

class CountDownButtonState extends State<CountDownButton> {
  bool _isLoading = false;
  bool _isCountingDown = false;

  Timer? _countdownTimer;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    _loading();
    _isCountingDown = true;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.countdownSeconds > 0) {
          widget.countdownSeconds--;
        } else {
          _isCountingDown = false;
          widget.countdownSeconds = 60;
          _countdownTimer?.cancel();
        }
      });
    });
  }

  void _loading() {
    // 模拟网络请求
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: _isLoading || _isCountingDown ? null : widget.onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isLoading || _isCountingDown ? Colors.grey : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: _isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 1, color: ThemeColor)) : Text(
          _isCountingDown ? '${widget.countdownSeconds} 秒' : '获取验证码',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
