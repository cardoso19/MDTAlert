# MDTAlert

[![Build Status](https://travis-ci.org/cardoso19/MDTAlert.svg?branch=master)](https://travis-ci.org/cardoso19/MDTAlert) [![pod](https://img.shields.io/cocoapods/v/MDTAlert.svg)](https://github.com/cardoso19/MDTAlert) [![Platforms](https://img.shields.io/badge/platforms-iOS-lightgrey.svg)](https://github.com/cardoso19/MDTAlert) [![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org) [![Xcode](https://img.shields.io/badge/Xcode-10.2.1-blue.svg)](https://developer.apple.com/xcode) [![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

MDTAlert is a swift framework to show alerts on iOS. All of the alerts are created using constraints, so it's redimensionable when the screen rotates.

## Requirements

- iOS 9.0+
- Xcode 10.2+
- Swift 5.0+

## Features

- [x] Simple visual of alerts using constraints.
- [x] Alerts on top and bottom of screen.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate MDTAlert into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'MDTAlert'
```

## Usage

This is an example of how to show an alert using the framework.

```swift
import MDTAlert

let alertView = MDTAlertView(message: "This is a test message of the alert on the top of the screen",
                                     position: .top,
                                     dismissTime: 3.0)
        alertView.style(backgroundColor: .red,
                        font: UIFont.systemFont(ofSize: 16),
                        textColor: .white)
        alertView.present()
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

