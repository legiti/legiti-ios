rm -rf build && mkdir build

# build framework for simulators
xcodebuild ONLY_ACTIVE_ARCH=NO BITCODE_GENERATION_MODE=bitcode clean build -workspace Inspetor.xcworkspace -scheme Inspetor -configuration Release -sdk iphonesimulator -derivedDataPath derived_data

# create folder to store compiled framework for simulator
mkdir build/simulator

# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphonesimulator/Inspetor.framework build/simulator

# build framework for devices
xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="-fembed-bitcode" ONLY_ACTIVE_ARCH=NO clean build -workspace Inspetor.xcworkspace -scheme Inspetor -configuration Release -sdk iphoneos -derivedDataPath derived_data

# create folder to store compiled framework for devices
mkdir build/devices

# copy compiled framework for devices into our build folder
cp -r derived_data/Build/Products/Release-iphoneos/Inspetor.framework build/devices


####################### Create universal framework #############################
# create folder to store compiled universal framework
mkdir build/universal

# copy device framework into universal folder
cp -r build/devices/Inspetor.framework build/universal/

# create framework binary compatible with devices and devices and replace binary in unviersal framework
lipo -create build/simulator/Inspetor.framework/Inspetor build/devices/Inspetor.framework/Inspetor -output build/universal/Inspetor.framework/Inspetor

# copy simulator Swift public interface to universal framework
cp build/simulator/Inspetor.framework/Modules/Inspetor.swiftmodule/* build/universal/Inspetor.framework/Modules/Inspetor.swiftmodule

# copy binary to distribution repo (must be cloned alongside this repository)
rm -rf ../inspetor-swift-framework-dist/backup/*
if [ -f ../inspetor-swift-framework-dist/Inspetor.framework ]; then
    mv ../inspetor-swift-framework-dist/Inspetor.framework ../inspetor-swift-framework-dist/backup
fi
cp -r build/universal/Inspetor.framework ../inspetor-swift-framework-dist
