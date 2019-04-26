# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'InspetorSwiftFramework' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for InspetorSwiftFramework
  pod 'SnowplowTracker', '~> 1.0'

  target 'InspetorSwiftFrameworkTests' do
      inherit! :complete
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
      cflags << '-fembed-bitcode'
      config.build_settings['OTHER_CFLAGS'] = cflags
    end
  end
end

