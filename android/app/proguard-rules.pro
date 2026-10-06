# Flutter's Gradle plugin already ships the engine keep rules; these cover the
# plugins Fino adds on top of it.

# flutter_local_notifications: Gson reflects over the persisted scheduled
# notification models.
-keep class com.dexterous.flutterlocalnotifications.models.** { *; }
-keepattributes Signature
-keepattributes *Annotation*

# sqlite3 / drift native bindings are resolved by name from native code.
-keep class eu.simonbinder.sqlite3_flutter_libs.** { *; }

# Play Core is referenced by Flutter's deferred-components code but not used.
-dontwarn com.google.android.play.core.**
