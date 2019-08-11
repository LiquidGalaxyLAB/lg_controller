package com.liquidgalaxy.lg_controller

import android.os.Bundle
import android.content.Intent
import android.util.Log
import android.app.SearchManager

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    val intent = getIntent()
    val action = intent.getAction()

    if (Intent.ACTION_SEARCH.equals(action)) {
      val query = intent.getStringExtra(SearchManager.QUERY)
      Log.e("Search received",query)
    }
  }
}
