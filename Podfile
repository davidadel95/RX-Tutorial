# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RX-Tutorial' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RX-Tutorial
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya-ModelMapper/RxSwift'
  pod 'RxOptional'

end


post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
  end
 end
end
