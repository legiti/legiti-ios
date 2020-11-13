rm -rf build && mkdir build

# build framework for simulators
xcodebuild EXCLUDED_ARCHS=arm64 ONLY_ACTIVE_ARCH=NO BITCODE_GENERATION_MODE=bitcode clean build -workspace Legiti.xcworkspace -scheme Legiti -configuration Release -sdk iphonesimulator -derivedDataPath derived_data

# create folder to store compiled framework for simulator
mkdir build/simulator

# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphonesimulator/Legiti.framework build/simulator

# build framework for devices
xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" ONLY_ACTIVE_ARCH=NO clean build -workspace Legiti.xcworkspace -scheme Legiti -configuration Release -sdk iphoneos -derivedDataPath derived_data

# create folder to store compiled framework for devices
mkdir build/devices

# copy compiled framework for devices into our build folder
cp -r derived_data/Build/Products/Release-iphoneos/Legiti.framework build/devices


####################### Create universal framework #############################
# create folder to store compiled universal framework
mkdir build/universal

# copy device framework into universal folder
cp -r build/devices/Legiti.framework build/universal/

# create framework binary compatible with devices and devices and replace binary in unviersal framework
lipo -create build/simulator/Legiti.framework/Legiti build/devices/Legiti.framework/Legiti -output build/universal/Legiti.framework/Legiti

# copy simulator Swift public interface to universal framework
cp -r build/simulator/Legiti.framework/Modules/Legiti.swiftmodule/* build/universal/Legiti.framework/Modules/Legiti.swiftmodule

# copy binary to distribution repo (must be cloned alongside this repository)
rm -rf ../legiti-swift-framework-dist/backup/*
if [ -f ../legiti-swift-framework-dist/Legiti.framework ]; then
    mv ../legiti-swift-framework-dist/Legiti.framework ../legiti-swift-framework-dist/backup
fi
cp -r build/universal/Legiti.framework ../legiti-swift-framework-dist
