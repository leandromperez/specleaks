#
# Be sure to run `pod lib lint SpecLeaks.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpecLeaks'
  s.version          = '0.1.1'
  s.swift_version    = '4.0'
  s.summary          = 'Unit Tests Memory Leaks in Swift. Write readable tests for mem leaks easily with these Quick and Nimble extensions.'

  s.description      = 'Quick and Nimble are tools that form a Unit Testing framework that allows you to write tests in a more humanly readable fashion. SpecLeaks is only a few additions to those tools. It lets you create unit tests to see if objects are leaking. You can test vanilla objects, view controllers, and see if an object or an action leaks'

  s.homepage         = 'https://github.com/leandromperez/specleaks'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leandro Perez' => 'leandromperez@gmail.com' }
  s.source           = { :git => 'https://github.com/leandromperez/specleaks.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SpecLeaks/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SpecLeaks' => ['SpecLeaks/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'XCTest'
  s.dependency 'Quick'
  s.dependency 'Nimble'
end
