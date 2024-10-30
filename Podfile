source 'https://github.com/flowx-ai-external/flowx-ios-specs.git'
source 'https://github.com/CocoaPods/Specs.git'

post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
          end
      end
  end

target 'AppTemplate' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AppTemplate
  pod 'FXAuthLibrary'
  pod 'FlowXRenderer', '4.0.2'

  target 'AppTemplateTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AppTemplateUITests' do
    # Pods for testing
  end

end
