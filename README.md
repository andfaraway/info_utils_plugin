# info_utils_plugin

This is a plugin used to obtain the basic information of the user's device and its current location.


## iOS Permissions

iOS requires the following permissions to be added in the `Info.plist` file:

- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysAndWhenInUseUsageDescription`

In the `ios/Podfile` file, ensure you have the necessary configurations. Here is an example of what you might need to add or check:

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
     target.build_configurations.each do |config|
              # You can remove unused permissions here
              # for more infomation: https://github.com/BaseflowIT/flutter-permission-handler/blob/master/permission_handler/ios/Classes/PermissionHandlerEnums.h
              # e.g. when you don't need camera permission, just add 'PERMISSION_CAMERA=0'
              config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
                '$(inherited)',
                ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
                'PERMISSION_LOCATION=1',
              ]

            end
  end
end
```