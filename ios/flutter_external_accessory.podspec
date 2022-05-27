#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_external_accessory.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_external_accessory'
  s.version          = '0.0.1'
  s.summary          = 'Plugin for communicate with external accessory devices.'
  s.description      = <<-DESC
Plugin for communicate with external accessory devices.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # Add ExternalAccessory.framework to dependencies
  s.preserve_paths = 'ExternalAccessory.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework ExternalAccessory' }
  s.vendored_frameworks = 'ExternalAccessory.framework'
end
