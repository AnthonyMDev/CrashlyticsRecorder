Pod::Spec.new do |s|
  s.name             = 'CrashlyticsRecorder'
  s.version          = '3.0.0'
  s.swift_version    = '5.2'
  s.summary          = 'A wrapper for Firebase Crashlytics and Analytics frameworks allowing them to be used as a transitive dependencies via dependency injection.'
  s.homepage         = 'https://github.com/AnthonyMDev/CrashlyticsRecorder'
  s.license          = 'MIT'
  s.author           = { "Anthony Miller" => "anthony@app-order.com" }
  s.source           = { :git => "https://github.com/AnthonyMDev/CrashlyticsRecorder.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AnthonyMDev'

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.14'
  s.tvos.deployment_target = '13.0'

  s.subspec 'Crashlytics' do |cs|
    cs.source_files = 'Pod/Classes/CrashlyticsRecorder.swift'
  end

  s.subspec 'FirebaseAnalytics' do |fas|
    fas.source_files = 'Pod/Classes/AnalyticsRecorder.swift'
  end

end
