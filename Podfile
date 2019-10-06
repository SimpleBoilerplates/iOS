# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'iOSBoilerplate' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSBoilerplate

  pod 'IQKeyboardManager'
  pod 'Kingfisher', '~> 5.0'
  pod 'Moya', '~> 12.0'
  pod 'SwiftyJSON'
  pod 'ReachabilitySwift'
  pod 'SwiftMessages'
  pod 'SwiftValidator' , :git => 'https://github.com/Sadmansamee/SwiftValidator.git', :branch => 'master'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'SwinjectStoryboard'

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
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
    pod 'Quick'
    pod 'Nimble'
    pod 'Swinject'
    pod 'SwinjectStoryboard'
    pod 'ObjectMapper'
    pod 'SwiftyJSON'
    #pod 'Mockingjay'

  end

  target 'iOSBoilerplateUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
