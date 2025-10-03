class VoiceRecord {
  final String id;
  final String title;
  final Duration duration;
  final DateTime recordTime;
  final String? transcription; // 转文字结果，null表示还未转换
  final bool isTranscribing; // 是否正在转换中
  final String filePath; // 录音文件路径

  VoiceRecord({
    required this.id,
    required this.title,
    required this.duration,
    required this.recordTime,
    this.transcription,
    this.isTranscribing = false,
    required this.filePath,
  });

  /// 格式化时长显示
  String get formattedDuration {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// 格式化录音时间显示
  String get formattedRecordTime {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final recordDate = DateTime(recordTime.year, recordTime.month, recordTime.day);
    
    String dateStr;
    if (recordDate == today) {
      dateStr = '今天';
    } else if (recordDate == yesterday) {
      dateStr = '昨天';
    } else {
      dateStr = '${recordTime.month}月${recordTime.day}日';
    }
    
    final timeStr = '${recordTime.hour.toString().padLeft(2, '0')}:${recordTime.minute.toString().padLeft(2, '0')}';
    return '$dateStr $timeStr';
  }

  /// 获取转文字按钮状态文本
  String get transcriptionButtonText {
    if (isTranscribing) return '转换中...';
    if (transcription != null) return '查看文字';
    return '转文字';
  }

  VoiceRecord copyWith({
    String? id,
    String? title,
    Duration? duration,
    DateTime? recordTime,
    String? transcription,
    bool? isTranscribing,
    String? filePath,
  }) {
    return VoiceRecord(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      recordTime: recordTime ?? this.recordTime,
      transcription: transcription ?? this.transcription,
      isTranscribing: isTranscribing ?? this.isTranscribing,
      filePath: filePath ?? this.filePath,
    );
  }
} 