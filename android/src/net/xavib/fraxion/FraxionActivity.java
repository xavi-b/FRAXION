package net.xavib.fraxion;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Vibrator;
import android.media.RingtoneManager;
import android.net.Uri;
import org.qtproject.qt5.android.bindings.QtActivity;

public class FraxionActivity extends QtActivity
{
    private static FraxionActivity fraxionActivity;

    public FraxionActivity()
    {
        fraxionActivity = this;
    }

    public static void notify(String content)
    {
        Notification.Builder builder = new Notification.Builder(fraxionActivity);
        builder.setSmallIcon(R.drawable.icon);
        builder.setContentTitle("FRAXION");
        builder.setContentText(content);

        ((NotificationManager) fraxionActivity.getSystemService(Context.NOTIFICATION_SERVICE)).notify(1, builder.build());
    }

    public static void vibrate(int msecs)
    {
        ((Vibrator) fraxionActivity.getSystemService(Context.VIBRATOR_SERVICE)).vibrate(msecs);
    }

    public static void ringtone()
    {
        RingtoneManager.getRingtone(fraxionActivity, RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)).play();
    }
}
