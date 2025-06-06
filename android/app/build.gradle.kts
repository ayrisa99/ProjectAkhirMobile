plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.finalproject"
    compileSdk = 31  // Versi SDK Android yang digunakan
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"  // Pastikan Kotlin target ke Java 1.8
    }

    defaultConfig {
        applicationId = "com.example.finalproject"
        minSdk = 21  // Versi minSdk yang digunakan
        targetSdk = 31  // Versi targetSdk yang digunakan
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    classpath 'com.android.tools.build:gradle:7.0.4'  
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.6.21" 
}
