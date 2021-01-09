# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'iOSBoilerplate' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSBoilerplate

  pod 'IQKeyboardManagerSwift'
  pod 'Kingfisher', '~> 6.0.1'
  pod 'Moya', '~> 14.0.0'
  pod 'SwiftyJSON'
  pod 'ReachabilitySwift'
  pod 'SwiftMessages'
  pod 'SwiftValidator' , :git => 'https://github.com/Sadmansamee/SwiftValidator.git', :branch => 'master'
  pod 'RxSwift', '~> 6.0.0'
  pod 'RxCocoa', '~> 6.0.0'
  pod 'Swinject' , '~> 2.7.1'
  pod 'SwinjectAutoregistration'
  pod 'SwinjectStoryboard', '~> 2.2.0'
  pod 'SwiftKeychainWrapper'

  #to check memory leak
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == ‘RxSwift’
        target.build_configurations.each do |config|
          if config.name == ‘Debug’
            config.build_settings[‘OTHER_SWIFT_FLAGS’] ||= [‘-D’, ‘TRACE_RESOURCES’]
          end
        end
      end
    end
  end
  
  target 'iOSBoilerplateTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 6.0'
    pod 'RxTest', '~> 6.0'
    pod 'Quick'
    pod 'Nimble'
    pod 'Swinject'
    pod 'SwinjectStoryboard'
    pod 'SwiftyJSON'

  end

  target 'iOSBoilerplateUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
