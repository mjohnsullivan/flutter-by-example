Add Flutter to an Android App
=============================

Simple example of adding Flutter to an Android app, either as a Fragment, or an Activity. Includes pre-warming the Flutter engine.

Notes
-----

* Latest master branch of Flutter must be used

* Flutter module was created using ```flutter create -t module <flutter_module_name>```

* Flutter module is included in Android project by adding the following to settings.gradle

```groovy
setBinding(new Binding([gradle: this]))
evaluate(new File(
    settingsDir.parentFile,
    '<flutter_dir>/.android/include_flutter.groovy'
))
```

* Flutter module is added as a dependency to the Android app in build.gradle:

```groovy
dependencies {
    implementation project(':flutter')
}
```

* The Flutter engine is pre-warmed in a custom Application instance:

```kotlin
class MyApplication : Application() {
    lateinit var engine: FlutterEngine

    override fun onCreate() {
        super.onCreate()
        FlutterMain.startInitialization(applicationContext)
        FlutterMain.ensureInitializationComplete(applicationContext, arrayOf<String>())
        engine = FlutterEngine(this)
        val entryPoint = DartExecutor.DartEntrypoint(this.assets,
            FlutterMain.findAppBundlePath(this), "main")
        engine.dartExecutor.executeDartEntrypoint(entryPoint)
    }
}
```

* The Flutter fragment gets its engine instance from the Application instance and doesn't destroy it when the fragment is destroyed:

```kotlin
class MyFlutterFragment : FlutterFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            MyFlutterFragment().apply {
                return FlutterFragment.Builder(MyFlutterFragment::class.java)
                    .renderMode(FlutterView.RenderMode.surface)
                    .transparencyMode(FlutterView.TransparencyMode.transparent)
                    .build<MyFlutterFragment>()
            }
    }

    override fun createFlutterEngine(@NonNull context: Context): FlutterEngine =
         (context.applicationContext as MyApplication).engine


    override fun retainFlutterEngineAfterFragmentDestruction() = true
}
```

* The Flutter Activity also pulls the engine instance from the custom Application:

```kotlin
class MyFlutterActivity : FlutterActivity(), FlutterFragment.FlutterEngineProvider {
    override fun getFlutterEngine(context: Context): FlutterEngine? =
        (context.applicationContext as MyApplication).engine
}
```