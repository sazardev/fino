import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Single source of truth for the Android identity of Fino.
// Flavors derive from it: dev -> `<id>.dev`, qa -> `<id>.qa`, prod -> `<id>`.
val baseApplicationId = "com.example.fino"
val androidMinSdk = 24
val androidTargetSdk = 36
val androidCompileSdk = 36

val keystoreProperties = Properties()
val keystoreFile = rootProject.file("key.properties")
val hasReleaseKey = keystoreFile.exists()
if (hasReleaseKey) {
    keystoreFile.inputStream().use { keystoreProperties.load(it) }
}

android {
    namespace = baseApplicationId
    compileSdk = androidCompileSdk
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = baseApplicationId
        minSdk = androidMinSdk
        targetSdk = androidTargetSdk
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "env"
    productFlavors {
        create("dev") {
            dimension = "env"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "Fino Dev")
            manifestPlaceholders["deepLinkHost"] = "dev.fino.example"
        }
        create("qa") {
            dimension = "env"
            applicationIdSuffix = ".qa"
            versionNameSuffix = "-qa"
            resValue("string", "app_name", "Fino QA")
            manifestPlaceholders["deepLinkHost"] = "qa.fino.example"
        }
        create("prod") {
            dimension = "env"
            resValue("string", "app_name", "Fino")
            manifestPlaceholders["deepLinkHost"] = "fino.example"
        }
    }

    if (hasReleaseKey) {
        signingConfigs {
            create("release") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            // Without android/key.properties, release builds are debug-signed
            // so `flutter run --release` keeps working locally.
            signingConfig =
                if (hasReleaseKey) {
                    signingConfigs.getByName("release")
                } else {
                    signingConfigs.getByName("debug")
                }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

flutter {
    source = "../.."
}
