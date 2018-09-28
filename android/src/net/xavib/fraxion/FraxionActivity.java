package net.xavib.fraxion;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Vibrator;
import android.os.Bundle;
import android.media.RingtoneManager;
import android.net.Uri;
import org.qtproject.qt5.android.bindings.QtActivity;
import com.google.android.gms.ads.MobileAds;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.InterstitialAd;

public class FraxionActivity extends QtActivity
{
    private static FraxionActivity fraxionActivity;

    private InterstitialAd _interstitialAd;

    public FraxionActivity()
    {
        fraxionActivity = this;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        MobileAds.initialize(this, "ADMOB_APP_ID");
        _interstitialAd = new InterstitialAd(this);
        _interstitialAd.setAdUnitId("ADMOB_UNIT_ID");
        _interstitialAd.loadAd(new AdRequest.Builder().build());

        _interstitialAd.setAdListener(new AdListener() {
            @Override
            public void onAdLoaded() {
                _interstitialAd.show();
            }

            @Override
            public void onAdFailedToLoad(int errorCode) {

            }

            @Override
            public void onAdOpened() {

            }

            @Override
            public void onAdLeftApplication() {

            }

            @Override
            public void onAdClosed() {

            }
        });
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
