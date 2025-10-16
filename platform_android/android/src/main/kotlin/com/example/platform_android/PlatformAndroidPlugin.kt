package com.example.platform_android

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.telephony.TelephonyManager
import androidx.core.content.ContextCompat
import android.Manifest
import android.content.pm.PackageManager

/** PlatformAndroidPlugin */
class PlatformAndroidPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "platform_android")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "openMap" -> {
        val lat = call.argument<Double>("lat") ?: 0.0
        val lng = call.argument<Double>("lng") ?: 0.0
        val label = call.argument<String>("label") ?: "목적지"

        val uri = Uri.parse("geo:$lat,$lng?q=$lat,$lng($label)")
        val intent = Intent(Intent.ACTION_VIEW, uri)
        val chooser = Intent.createChooser(intent, "지도 앱으로 열기")
        chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        flutterPluginBinding.applicationContext.startActivity(chooser)

        result.success(null)
      }
      "getCellphone" -> {
        val context = flutterPluginBinding.applicationContext
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        val permission = ContextCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_NUMBERS)
        if (permission != PackageManager.PERMISSION_GRANTED) {
          result.error("PERMISSION_DENIED", "전화번호를 읽을 권한이 없습니다.", null)
          return
        }

        var phoneNumber = telephonyManager.line1Number ?: ""

        if (phoneNumber.startsWith("+82")) {
          phoneNumber = phoneNumber.replaceFirst("+82", "0")
        }

        result.success(phoneNumber)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}