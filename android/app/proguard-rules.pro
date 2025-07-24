# Keep ML Kit text recognition classes to prevent R8 from stripping them
-keep class com.google.mlkit.vision.text.** { *; }
-keep class com.google.mlkit.vision.common.** { *; }
-keep class com.google.mlkit.vision.interfaces.** { *; }
-dontwarn com.google.mlkit.vision.text.**
