Pod::Spec.new do |s|
  s.name             = 'CrashlyticsRecorder'
  s.version          = '2.4.0'
  s.swift_version    = '4.2'
  s.summary          = 'A wrapper for the Crashlytics framework allowing it to be used as a transitive dependency via dependency injection.'

  s.homepage         = 'https://github.com/AnthonyMDev/CrashlyticsRecorder'
  s.license          = 'MIT'
  s.author           = { "Anthony Miller" => "anthony@app-order.com" }
  s.source           = { :git => "https://github.com/AnthonyMDev/CrashlyticsRecorder.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AnthonyMDev'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'

  s.requires_arc = true

  s.subspec 'Crashlytics' do |cs|
    cs.source_files = 'Pod/Classes/CrashlyticsRecorder.swift'
  end

  s.subspec 'Answers' do |as|
    as.source_files = 'Pod/Classes/AnswersRecorder.swift'
  end

  s.subspec 'FirebaseAnalytics' do |fas|
    fas.source_files = 'Pod/Classes/AnalyticsRecorder.swift'
  end

end
