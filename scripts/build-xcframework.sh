# Cleaning the archive folder
rm -rf archives && mkdir archives

# building the library for iOS devices
xcodebuild archive \
    -workspace Legiti.xcworkspace \
    -configuration Release \
    -scheme Legiti \
    -sdk iphoneos \
    -archivePath "./archives/ios_devices.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

# building the library for iOS simulator
xcodebuild archive \
    -workspace Legiti.xcworkspace \
    -configuration Release \
    -scheme Legiti \
    -sdk iphonesimulator \
    -archivePath "./archives/ios_simulators.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

# Cleaning the build folder
rm -rf build && mkdir build

# creating the xcframework
xcodebuild -create-xcframework \
    -framework ./archives/ios_devices.xcarchive/Products/Library/Frameworks/Legiti.framework \
    -framework ./archives/ios_simulators.xcarchive/Products/Library/Frameworks/Legiti.framework \
    -output build/Legiti.xcframework

# workaround until apple fix this 
# https://forums.swift.org/t/frameworkname-is-not-a-member-type-of-frameworkname-errors-inside-swiftinterface/28962
# https://developer.apple.com/forums/thread/123253 (workaround)
find ./build/ -name "*.swiftinterface" -exec sed -i -e 's/Legiti\.//g' {} \;

# copying the framework to legiti-swift-framework-dist repo
cp -r build/Legiti.xcframework ../legiti-swift-framework-dist

