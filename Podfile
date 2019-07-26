# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Inspetor' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Inspetor
  pod 'SnowplowTracker', '~> 1.1.2'
  pod 'INTULocationManageri', '~> 4.3'  

  target 'InspetorUnitTests' do 
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'YES'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = ['$(inherited)', 'INTU_ENABLE_LOGGING=0']
      cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
      cflags << '-fembed-bitcode'
      config.build_settings['OTHER_CFLAGS'] = cflags
    end
  end
end

