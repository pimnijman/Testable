#
# Be sure to run `pod lib lint Testable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Testable'
  s.version          = '0.1.0'
  s.summary          = 'A Swift mocking framework to easily spy on your test doubles or turn them into stubs.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#  s.description      = <<-DESC
#   A Swift mocking framework to easily spy on your test doubles or turn them into stubs.
#                      DESC

  s.homepage         = 'https://github.com/pimnijman/Testable'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pim Nijman' => 'nijman@gmail.com' }
  s.source           = { :git => 'https://github.com/pimnijman/Testable.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pnijman'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Testable/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Testable' => ['Testable/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
