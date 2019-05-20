#
# Be sure to run `pod lib lint SpecLeaks.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpecLeaks'
  s.version          = '0.1.6'
  s.swift_version    = '5.0'
  s.summary          = 'Unit Tests Memory Leaks in Swift. Write readable tests for mem leaks easily with these Quick and Nimble extensions.'

  s.description      = 'Quick and Nimble are tools that form a Unit Testing framework that allows you to write tests in a more humanly readable fashion. SpecLeaks is only a few additions to those tools. It lets you create unit tests to see if objects are leaking. You can test vanilla objects, view controllers, and see if an object or an action leaks'

  s.homepage         = 'https://github.com/leandromperez/specleaks'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leandro Perez' => 'https://twitter.com/bataleandro' }
  s.source           = { :git => 'https://github.com/leandromperez/specleaks.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bataleandro'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SpecLeaks/Classes/**/*'
  
  s.frameworks = 'UIKit', 'XCTest'
  s.dependency 'Quick'
  s.dependency 'Nimble'
end
