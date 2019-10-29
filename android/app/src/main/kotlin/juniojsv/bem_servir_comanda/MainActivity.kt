package juniojsv.bem_servir_comanda

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, "main_channel").setMethodCallHandler { call, result ->
      when(call.method) {
        "share" -> {
          Intent.createChooser(Intent(Intent.ACTION_SEND).apply {
            type = "text/plain"
            putExtra(Intent.EXTRA_TEXT, call.argument<String>("doc"))
          }, "Compartilhar com?").also {
            startActivity(it)
          }
        }
        else -> {
          result.notImplemented()
        }
      }
    }
  }
}
