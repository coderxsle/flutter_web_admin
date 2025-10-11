/// 说话人信息模型
class SpeakerInfo {
  final String speakerId;     // 说话人ID
  final String name;          // 说话人名称
  final String color;         // 颜色
  final double confidence;    // 置信度
  final bool isNewSpeaker;    // 是否为新说话人

  SpeakerInfo({
    required this.speakerId,
    required this.name,
    required this.color,
    required this.confidence,
    required this.isNewSpeaker,
  });

  factory SpeakerInfo.fromJson(Map<String, dynamic> json) {
    return SpeakerInfo(
      speakerId: json['speaker_id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      isNewSpeaker: json['is_new_speaker'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speaker_id': speakerId,
      'name': name,
      'color': color,
      'confidence': confidence,
      'is_new_speaker': isNewSpeaker,
    };
  }
}

/// 元数据模型
class SpeechMetadata {
  final String timeFormat;                // 时间格式
  final String transcriptType;            // 转录类型

  SpeechMetadata({
    required this.timeFormat,
    required this.transcriptType, 
  });

  factory SpeechMetadata.fromJson(Map<String, dynamic> json) {
    return SpeechMetadata(
      timeFormat: json['time_format'] as String,
      transcriptType: json['transcript_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_format': timeFormat,
      'transcript_type': transcriptType,
    };
  }
}

/// 语音识别结果模型
class SpeechRecognitionResult {
  final String messageId;                // 消息ID    
  final int timestamp;                   // 时间戳
  final String mode;                     // 模式
  final String status;                   // 状态
  final String sessionId;                // 会话ID
  final String text;                     // 文本
  final int startTime;                   // 开始时间
  final int endTime;                     // 结束时间
  final int duration;                    // 持续时间
  final double confidence;               // 置信度
  final SpeakerInfo? speakerInfo;        // 说话人信息
  final SpeechMetadata? metadata;        // 元数据

  SpeechRecognitionResult({
    required this.messageId,
    required this.timestamp,
    required this.mode,
    required this.status,
    required this.sessionId,
    required this.text,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.confidence,
    this.speakerInfo,
    this.metadata,
  });

  factory SpeechRecognitionResult.fromJson(Map<String, dynamic> json) {
    return SpeechRecognitionResult(
      messageId: json['message_id'] as String,
      timestamp: json['timestamp'] as int,
      mode: json['mode'] as String,
      status: json['status'] as String,
      sessionId: json['session_id'] as String,
      text: json['text'] as String,
      startTime: json['start_time'] as int,
      endTime: json['end_time'] as int,
      duration: json['duration'] as int,
      confidence: (json['confidence'] as num).toDouble(),
      speakerInfo: json['speaker_info'] != null 
          ? SpeakerInfo.fromJson(json['speaker_info'] as Map<String, dynamic>)
          : null,
      metadata: json['metadata'] != null
          ? SpeechMetadata.fromJson(json['metadata'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'timestamp': timestamp,
      'mode': mode,
      'status': status,
      'session_id': sessionId,
      'text': text,
      'start_time': startTime,
      'end_time': endTime,
      'duration': duration,
      'confidence': confidence,
      if (speakerInfo != null) 'speaker_info': speakerInfo!.toJson(),
      if (metadata != null) 'metadata': metadata!.toJson(),
    };
  }

  /// 判断是否为最终结果
  bool get isFinal => status == 'final';

  /// 判断是否为实时结果
  bool get isRealtime => status != 'final';

  /// 获取格式化的时间字符串
  String get formattedDuration {
    final seconds = duration / 1000;
    return '${seconds.toStringAsFixed(1)}s';
  }
}
