package com.coderxslee.ymyp;

import io.flutter.app.FlutterApplication;
import android.os.Build;
import android.os.Environment;
import java.io.File;

public class MainApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();

        //E/libEGL  (30808): error opening cache file /data/user_de/0/com.coderxslee.ymyp/code_cache/com.android.opengl.shaders_cache.
        // 创建OpenGL着色器缓存目录
        String cachePath = getApplicationContext().getFilesDir().getAbsolutePath() + "/code_cache";
        File cacheDir = new File(cachePath);
        if (!cacheDir.exists()) {
            cacheDir.mkdirs();
        }

        // 确保目录可写
        if (cacheDir.exists()) {
            cacheDir.setWritable(true);
            cacheDir.setReadable(true);
        }
    }

}