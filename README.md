# Inspetor Antifraud iOS Library

## Setup
**To setup this library you will need a mac, without one you can't publish or run this library.**

Once you get a mac you can just clone this repo and this is all you need.

## How to make changes to the library
Open the `Inspetor.xcworkspace` and make the changes you want.

## How to test
There are 2 different tests in this repo:

### 1. Unit Test
1. Go to the **InspetorUnitTest** folder inside Xcode
2. Run the unit test located in the `InspetorUnitTests.swift` file (Just press the "play" icon in line 12)

### 2. Integration Test / Test App
To run the integration test you should run the test app that is located inside the library
1. In Xcode change the target from the library to the InspetorTestApp (The button to change the target is the first button after the play and stop buttons. Just click the Inspetor and a dropdown should appear showing the available targets)
2. Run the app
3. Inside the app you can trigger the desired tracking actions
4. Check if data corresponding to the events you've triggered appear in `atomic.actions` in the staging DB (You can use the `tracker_name` `inspetor.test` to help you find the results)

## How to publish
To publish a new version of the Inspetor iOS Library you need to follow this steps:
1. Clone the inspetor-swift-framework-dist (`git clone git@github.com:inspetor/inspetor-swift-framework-dist.git`) repo to the parent directory of where this library was cloned
1. Go back to the this repository
1. Run the `./build-universal-framework.sh`script
1. Go to the `inspetor-swift-framework-dist` repo (`cd ../inspetor-swift-framework-dist`)
1. Run the following commands:
    1. `git add .`
    1. `git commit -m "<an informative message here>"`
    1. `git push origin master`
    1. `git tag -a <new version> -m "<what changed?>"`
    1. `git push origin --tags`
1. Go back to this repository (`cd ../inspetor-ios`)
1. Update the version inside the `Inspetor.podspec` file
1. Publish the library `pod trunk push Inspetor.podspec`
