rm -rf build && mkdir build

# build framework for simulators
xcodebuild ONLY_ACTIVE_ARCH=NO BITCODE_GENERATION_MODE=bitcode clean build -workspace InspetorSwiftFramework.xcworkspace -scheme InspetorSwiftFramework -configuration Release -sdk iphonesimulator -derivedDataPath derived_data

# create folder to store compiled framework for simulator
mkdir build/simulator

# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphonesimulator/InspetorSwiftFramework.framework build/simulator

# build framework for devices
xcodebuild OTHER_CFLAGS="-fembed-bitcode" ONLY_ACTIVE_ARCH=NO clean build -workspace InspetorSwiftFramework.xcworkspace -scheme InspetorSwiftFramework -configuration Release -sdk iphoneos -derivedDataPath derived_data

# create folder to store compiled framework for simulator
mkdir build/devices

# copy compiled framework for simulator into our build folder
cp -r derived_data/Build/Products/Release-iphoneos/InspetorSwiftFramework.framework build/devices


####################### Create universal framework #############################
# create folder to store compiled universal framework
mkdir build/universal

# copy device framework into universal folder
cp -r build/devices/InspetorSwiftFramework.framework build/universal/

# create framework binary compatible with simulators and devices and replace binary in unviersal framework
lipo -create build/simulator/InspetorSwiftFramework.framework/InspetorSwiftFramework build/devices/InspetorSwiftFramework.framework/InspetorSwiftFramework -output build/universal/InspetorSwiftFramework.framework/InspetorSwiftFramework

# copy simulator Swift public interface to universal framework
cp build/simulator/InspetorSwiftFramework.framework/Modules/InspetorSwiftFramework.swiftmodule/* build/universal/InspetorSwiftFramework.framework/Modules/InspetorSwiftFramework.swiftmodule

# copy binary to distribution repo (must be cloned alongside this repository)
rm -rf ../inspetor-swift-framework-dist/backup/*
if [ -f ../inspetor-swift-framework-dist/InspetorSwiftFramework.framework ]; then
    mv ../inspetor-swift-framework-dist/InspetorSwiftFramework.framework ../inspetor-swift-framework-dist/backup
fi
cp -r build/universal/InspetorSwiftFramework.framework ../inspetor-swift-framework-dist
