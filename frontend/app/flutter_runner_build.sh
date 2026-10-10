# 检查是否在 macOS 系统上
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Converting notification sound to iOS compatible WAV format..."
    
    # 创建 Runner/wav 目录（如果不存在）
    mkdir -p ios/Runner/wav
    
    # 使用 afconvert 转换音频文件，确保符合 iOS 通知声音要求
    # -f 'WAVE' 指定输出格式为 WAV
    # -d LEI16@44100 指定为 16 位线性 PCM，44.1kHz 采样率
    # -c 1 指定为单声道
    # --quality 127 使用最高质量设置
    afconvert -f 'WAVE' -d LEI16@44100 -c 1 --quality 127 \
        assets/audios/umeng_push_notification_default_sound.mp3 \
        ios/Runner/wav/umeng_push_notification_default_sound.wav
        
    # 验证生成的 WAV 文件
    echo "Verifying converted audio file..."
    afinfo ios/Runner/wav/umeng_push_notification_default_sound.wav
fi