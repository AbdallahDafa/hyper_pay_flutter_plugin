#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint hyper_pay.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'hyper_pay_payment'
  s.version          = '1.0.3'
  s.summary          = 'hyperpay iphone integeration'
  s.description      =  'Hyper Pay Flutter Integeration: VISA / MASTER / MADA /Apple Pay'
  s.homepage         = 'https://www.hyperpay.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author           = { 'Abdallah Mahmoud' => 'abdallah.mahmoud.dev@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*', 'Classes/channel_flutter/ChannelFlutterHyperpay.swift', 'Classes/presentation/HyperPayAutoDetectBrandPromaticallyViewController.swift'
  s.dependency 'Flutter'


  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # Abdallah Set version
  s.ios.deployment_target = "13.0"
  s.platform = :ios, '15.0'

  # insert pods
  s.dependency 'hyper_pay_installer'
end
