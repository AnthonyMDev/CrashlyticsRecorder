Pod::Spec.new do |s|
  s.name             = "CrashlyticsRecorder"
  s.version          = "0.1.0"
  s.summary          = "A wrapper for the Crashlytics framework allowing it to be used as a transitive dependency via dependency injection."

  s.homepage         = "https://github.com/AnthonyMDev/CrashlyticsRecorder"
  s.license          = 'MIT'
  s.author           = { "Anthony Miller" => "anthony@app-order.com" }
  s.source           = { :git => "https://github.com/AnthonyMDev/CrashlyticsRecorder.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AnthonyMDev'

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'
  s.tvos.deployment_target = '9.0'

  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

end
