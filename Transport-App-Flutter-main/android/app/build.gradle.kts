plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    // Estas versiones están definidas en el nivel superior (settings.gradle.kts)
    namespace = "com.example.indriver_clone_flutter"
    compileSdk = (findProperty("flutter.compileSdkVersion") as String?)?.toInt() ?: 36 
    ndkVersion = findProperty("flutter.ndkVersion") as String? ?: "27.0.12077973" // Ejemplo

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        
        // [CORRECCIÓN 1] Habilitar desugaring
        isCoreLibraryDesugaringEnabled = true 
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }

    defaultConfig {
        applicationId = "com.example.indriver_clone_flutter"
        minSdk = (findProperty("flutter.minSdkVersion") as String?)?.toInt() ?: 24
        targetSdk = (findProperty("flutter.targetSdkVersion") as String?)?.toInt() ?: 34
        versionCode = (findProperty("flutter.versionCode") as String?)?.toInt() ?: 1
        versionName = findProperty("flutter.versionName") as String? ?: "1.0"
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // [CORRECCIÓN 2] Añadir la librería de desugaring para Java 8
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))
    implementation("com.google.firebase:firebase-analytics")
}
