#
# Be sure to run `pod lib lint TOSClientKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TOSClientKit'
  s.version          = '2.4.6'
  s.summary          = 'TOSClientKit 集成UI的在线客服SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ti-net-project/OnlineSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gyb1314' => 'gyb_1314@126.com' }
  s.source           = { :git => 'https://github.com/ti-net-project/OnlineSDK-iOS', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.resource      = 'TOSClient.bundle'
  s.vendored_frameworks  = "TOSClientLib.framework",  "TOSClientKit.framework"
  s.pod_target_xcconfig = {'VALID_ARCHS'=>'x86_64 arm64','EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
