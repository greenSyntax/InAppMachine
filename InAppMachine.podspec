#
# Be sure to run `pod lib lint InAppMachine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'InAppMachine'
  s.version          = '1.1.3'
  s.summary          = 'InAppMachine with ligh installation'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/greenSyntax/InAppMachine'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Abhishek Kumar Ravi' => 'ab.abhishek.ravi@gmail.com' }
  s.source           = { :git => 'https://github.com/greenSyntax/InAppMachine.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/greenSyntax'

  s.ios.deployment_target = '8.0'

  s.source_files = 'InAppMachine/Classes/**/*'
  
  # s.resource_bundles = {
  #   'InAppMachine' => ['InAppMachine/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
