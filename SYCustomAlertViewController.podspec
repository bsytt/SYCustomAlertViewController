#
# Be sure to run `pod lib lint SYAlertController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SYCustomAlertViewController'
  s.version          = '0.2.1'
  s.summary          = '自定义AlertView，支持系统样式显示；文字，图片自定义显示；以及显示自定义视图.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/bsytt/SYCustomAlertViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bsytt' => '15893398117@163.com' }
  s.source           = { :git => 'https://github.com/bsytt/SYCustomAlertViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'SYCustomAlertViewController/Classes/**/*.{swift}','SYCustomAlertViewController/Classes/SYCustomAlertViewController/*.{swift}'
  
  # s.resource_bundles = {
  #   'SYAlertController' => ['SYAlertController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit'
end
