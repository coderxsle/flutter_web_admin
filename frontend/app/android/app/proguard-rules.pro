# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
#-keepclassmembers class * extends org.greenrobot.greendao.AbstractDao {
#public static java.lang.String TABLENAME;
#}
#-keep class **$Properties { *; }
-keep class io.flutter.app.** { *; }

-keep class io.flutter.plugin.** { *; }

-keep class io.flutter.util.** { *; }

-keep class io.flutter.view.** { *; }

-keep class io.flutter.** { *; }

-keepattributes *Annotation*

-keepattributes SourceFile,LineNumberTable

# Room 靠反射按名字找生成的 *_Impl，被 R8 剪掉后启动即崩（WorkDatabase_Impl）
-keep class * extends androidx.room.RoomDatabase { *; }
-keep class androidx.work.** { *; }
-keep class vn.hunghd.flutterdownloader.** { *; }

# AGP 9 的 R8 在 app 级出现 -dontshrink/-dontoptimize 时会内部空指针，
# 只能让 R8 正常压缩；缺失类靠 -ignorewarnings 放行
-ignorewarnings
