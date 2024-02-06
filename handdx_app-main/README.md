# handdx

Flutter code for the HandDx app. Note this primarily targets iOS and is not designed for any other platform.

## Setup

**Requirements and prequisites**:

- MacOS (needed to build iOS applications)
- XCode
- XCode CLI (`xcode-select –install`)
- [Homebrew](https://brew.sh/)
- VSCode
- [Firebase CLI](https://firebase.google.com/docs/cli)
- Access to the Firebase `HandDxApp` project
  - See Account Access README in handoff documents for details
- Access to the `handx.dev@gmail.com` Apple account
  - Only needed if deploying to TestFlight/Apple connect
  - See Account Access README in handoff documents for details
- Any other requirements in the Flutter documentation

### First Build

1. Follow the [official Flutter documentation](https://docs.flutter.dev/get-started/install) to get Flutter setup on your MacOS computer.
2. Run `flutter doctor` and make sure it passes. An issue in Android Studio is okay.
3. Open the root project directory in VSCode.
4. In the terminal, navigate to the project directory (or use VSCode->Terminal->New Terminal), and run `firebase login`.
5. Run `flutter pub get` to install the project dependencies.
6. Run `flutterfire configure` and select the `handyapp-f6206 (HandDxApp)` project.
7. Navigate to the `lib/main.dart` file.
8. Start the iOS simulator/emulator
   - Press `Shift + CMD + P` or `View -> Command Pallete` in VSCode, and type `Flutter: Start Emulator`. Then choose `iOS Simulator`.
   - Alternatively, the the bottom right of VSCode, you should see a button that may say `macOS (darwin)` or similar. ![Select target button](https://i.imgur.com/T2YsL4e.png) Clicking this should also bring up the same menu where you can start and select the iOS emulator as your run target:![Select device to use](https://i.imgur.com/qXR4vPP.png)
9. Then in the file navigation bar, you should see a start debugging button (only appears in `main.dart`). ![Start debugging button](https://i.imgur.com/1lqHIAU.png)
   Note that the first build, and some later builds may build the entire app from scratch, and this may take over 10 minutes for iOS. Most later builds should use cached results to make the build faster.
10. You should see the app appear on the iOS simulator.
11. A useful command for debugging layouts is `Flutter: Open DevTools Widget Inspector Page`.

### Generate Documentation Pages

1. Run `dart doc` in the project directory.

### Publishing to TestFlight

1. Login to App Store connect using the HandDx team's account. Refer to the given Accounts README document in the handoff files that should be given by Dr. Jain.
2. Open `ios/Runner.xcworkspace` in XCode.
3. Click on "Runner" in the left navigation bar
    ![Runner in navigation bar](https://i.imgur.com/G3kb4gL.png)
4. In the main/center window, select "Signing & Capabilities" and make sure that "All" capabilities is selected.
    ![Signing & Capabilities](https://i.imgur.com/udPOHwz.png)
5. Expand the "Signing" section.
    ![Signing section](https://i.imgur.com/jZGBsCF.png)
6. Add the "Rhy Vaughn" (the HandDx email) team by clicking "Add and account".
    ![Add team](https://i.imgur.com/g6YL7Ht.png)
7. Login using the HandDx email. You should see the account listed under "Accounts" when successful.
    ![Accounts](https://i.imgur.com/yTqfRkC.png)
8. Select the "Rhys Vaughn" account as the signing team, and make sure that the Bundle identifier is `edu.osu.handdx`.
9. **Don't forget to update the app version in `pubspec.yaml`**. We follow [semantic versioning](https://semver.org/). The number after the `+` represents the build number, which usually is fine to keep as `1`.
10. In the project directory run `flutter build ipa --obfuscate --split-debug-info=debug_info`. This creates a bundle you can push to App Store Connect.
11. Open `build/ios/archive/Runner.xcarchive` in XCode.
    ![Archives](https://i.imgur.com/JYJbNs7.png)
12. Click `Validate App` and once that passes, click `Distribute App` to push it to App Store Connect.
13. In App Store Connect, login and navigate to HandDx->TestFlight. In there, you should see that the new app version is processing which can take 10-20 minutes. Once done, you may also need to fill out a short export control form where you answer that the app uses standard encryption techniques and will not be distributed in France.
    1. ![Export compliance](https://i.imgur.com/DyBJcOz.png)
    2. ![Export compliance](https://i.imgur.com/kHIObak.png)
14. If you wish to publish the app for external testing on TestFlight, you must also submit the build for review and provide login information for a test account that Apple’s testers can use. This should take no more than one business day. 

## Development

The majority of the architecture is based around this [Flutter tutorial](https://youtu.be/vrPk6LB9bjo). Note that is uses an older version of the riverpods library so some functions are different in this repository than what's in the video.

Most of the development changes will occur in the `lib` directory, and you should only touch the `ios` directory for iOS specfic configurations, like adding permissions/capabilities, or changing the app icon/launch screen.
