package com.tngrstudio.babysleepsounds

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build

class BabySleepApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        createPlaybackNotificationChannel()
    }

    private fun createPlaybackNotificationChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return

        val manager = getSystemService(NotificationManager::class.java) ?: return
        val channelId = "com.tngrstudio.babysleepsounds.media.v3"
        manager.deleteNotificationChannel("com.tngrstudio.babysleepsounds.media.v2")
        manager.deleteNotificationChannel("com.tngrstudio.babysleepsounds.audio")
        if (manager.getNotificationChannel(channelId) != null) return

        val channel = NotificationChannel(
            channelId,
            "Bebek Uyku Sesleri",
            NotificationManager.IMPORTANCE_LOW,
        ).apply {
            description = "Çalan ses kontrolleri"
            setShowBadge(false)
            enableLights(false)
            enableVibration(false)
            setSound(null, null)
            lockscreenVisibility = android.app.Notification.VISIBILITY_PUBLIC
        }
        manager.createNotificationChannel(channel)
    }
}
