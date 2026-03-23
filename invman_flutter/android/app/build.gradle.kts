import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
val hasReleaseSigningConfig = keystorePropertiesFile.exists()
if (hasReleaseSigningConfig) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "ch.valentinbaudin.rimawari"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigningConfig) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    flavorDimensions += "environment"
    productFlavors {
        create("develop") {
            dimension = "environment"
            applicationId = "ch.valentinbaudin.rimawari.dev"
            resValue("string", "app_name", "Rimawari Dev")
        }
        create("staging") {
            dimension = "environment"
            applicationId = "ch.valentinbaudin.rimawari.staging"
            resValue("string", "app_name", "Rimawari Staging")
        }
        create("production") {
            dimension = "environment"
            applicationId = "ch.valentinbaudin.rimawari"
            resValue("string", "app_name", "Rimawari")
            // Production release builds require proper signing
            if (!hasReleaseSigningConfig) {
                println("WARNING: No key.properties found. Production release builds will fail.")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hasReleaseSigningConfig) {
                signingConfigs.getByName("release")
            } else {
                // Allow debug signing for develop/staging, but production will fail at build time
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}
