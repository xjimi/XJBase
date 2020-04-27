#
# Be sure to run `pod lib lint XJBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XJBase'
  s.version          = '0.1.4'
  s.summary          = 'A short description of XJBase.'
  s.homepage         = 'https://github.com/xjimi/XJBase'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xjimi' => 'fn5128@gmail.com' }
  s.source           = { :git => 'https://github.com/xjimi/XJBase.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'XJBase/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'XJScrollViewStateManager', '<= 0.1.13'
  s.dependency 'XJCollectionViewManager', '<= 0.1.51'
  s.dependency 'XJTableViewManager', '<= 0.1.82'

  # s.resource_bundles = {
  #   'XJBase' => ['XJBase/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
