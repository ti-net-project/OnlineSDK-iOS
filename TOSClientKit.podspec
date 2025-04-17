
Pod::Spec.new do |s|
  s.name             = 'TOSClientKit'
  s.version          = '2.4.5'
  s.summary          = 'TOSClientKit 自定义UI的在线客服SDK'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ti-net-project/OnlineSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gyb1314' => 'gyb_1314@126.com' }
  s.source           = { :git => 'https://github.com/ti-net-project/OnlineSDK-iOS', :branch => 'feature/CustomKit' }

  s.platform = :ios
  s.ios.deployment_target = '13.0'

  s.xcconfig = {
    'CLANG_ENABLE_OBJC_WEAK' => 'YES'
  }
  
  s.source_files = 'TOSClientKit/Classes/**/*'
  s.requires_arc = true
  
  # 指定非 ARC 文件
  s.subspec 'no-arc' do |sp|
    sp.source_files = [
      'TOSClientKit/Classes/ThirdLibs/YYKit/YYKit/Base/**/*.{h,m}',
      'TOSClientKit/Classes/ThirdLibs/YYKit/YYKit/**/YYDispatchQueuePool.{h,m}'  # 添加这个文件
    ]
    sp.requires_arc = false
    #sp.compiler_flags = '-fno-objc-arc'
  end

  s.resource_bundles = {
    'TOSKitClient' => [
    'TOSClientKit/Resources/**/*.{png,jpg,svg,bundle,json,strings,xib,nib}']
  }

  s.vendored_frameworks  = "TOSClientKit.framework"
  #s.pod_target_xcconfig = {'VALID_ARCHS'=>'x86_64 arm64'}
  #s.pod_target_xcconfig = {'VALID_ARCHS'=>'x86_64 arm64','EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  #s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.dependency 'TOSClientLib', '2.4.3'
  s.frameworks = ['UIKit', 'AudioToolbox', 'Foundation', 'AVFoundation', 'CoreAudio']

  # 添加 AMR 库文件
  s.vendored_libraries = [
    'TOSClientKit/Classes/ThirdLibs/VoiceConvert/lib/libopencore-amrnb.a',
    'TOSClientKit/Classes/ThirdLibs/VoiceConvert/lib/libopencore-amrwb.a'
  ]
  # 添加框架搜索路径
  s.pod_target_xcconfig = {
    'VALID_ARCHS' => 'x86_64 arm64',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'LIBRARY_SEARCH_PATHS' => '${PODS_ROOT}/TOSClientKit/Libraries ${PODS_TARGET_SRCROOT}/TOSClientKit/Libraries',
    'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/TOSClientKit/Libraries/include ${PODS_TARGET_SRCROOT}/TOSClientKit/Libraries/include',
    #'FRAMEWORK_SEARCH_PATHS' => [
      #'$(SDKROOT)/System/Library/Frameworks',
      #'$(PLATFORM_DIR)/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks',
      #'$(PODS_ROOT)/TOSClientKit/Libraries',
      #'$(PODS_TARGET_SRCROOT)/TOSClientKit/Libraries'
    #],

    #'HEADER_SEARCH_PATHS' => [
      #'$(PODS_ROOT)/TOSClientKit/Libraries/include',
      #'$(PODS_TARGET_SRCROOT)/TOSClientKit/Libraries/include'
    #],

    #'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/TOSClientKit/Libraries/include"',
    #'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/TOSClientKit/Libraries"',
    'OTHER_LDFLAGS' => '-lopencore-amrnb -lopencore-amrwb'
  }
end
