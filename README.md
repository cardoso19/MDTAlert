# MDTAlert

[![Build Status](https://travis-ci.org/cardoso19/MDTAlert.svg?branch=master)](https://travis-ci.org/cardoso19/MDTAlert) [![pod](https://img.shields.io/cocoapods/v/MDTAlert.svg)](https://github.com/cardoso19/MDTAlert) [![Platforms](https://img.shields.io/badge/platforms-iOS-lightgrey.svg)](https://github.com/cardoso19/MDTAlert) [![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org) [![Xcode](https://img.shields.io/badge/Xcode-10.2.1-blue.svg)](https://developer.apple.com/xcode) [![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

MDTAlert is a swift framework to show alerts on iOS. All of the alerts are created using constraints so it's redmensionable.

## Requirements

- iOS 9.0+
- Swift 5.0+

## Features

- [x] Simple visual of alerts using constraints.
- [x] Alerts on top and bottom of screen or given UIView.
- [x] Alerts with attributed text.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate MDTAlert into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'MDTAlert'
```

## Usage

It's possible to create an alert and hold its reference or just present it.

Methods to create:
```swift
MDTAlert.createAlert(text: String, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow)

MDTAlert.createAlert(attributedText: NSAttributedString, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow) -> MDTAlerting
```

Methods to just present:
```swift
MDTAlert.showAlert(text: String, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow, animated: Bool = true)

MDTAlert.showAlert(attributedText: NSAttributedString, position: AlertPosition = .top, dismissTime: TimeInterval = 3, parentView: UIView? = UIApplication.shared.keyWindow, animated: Bool = true) -> MDTAlerting
```

To create and show an alert with attributed text and with a background color:
```swift
import MDTAlert

let attributes: [NSAttributedString.Key : Any]? = [
		.font: UIFont.systemFont(ofSize: 16),
		.foregroundColor: UIColor.white
]
let attributedText = NSAttributedString(string: "message", attributes: attributes)
let alert = MDTAlert.createAlert(attributedText: attributedText, position: alertPosition)
alert.backgroundColor = .red
alert.present(animated: true)
```

To create and show an alert with text, with background color and custom styles:
```swift
import MDTAlert

let alert = MDTAlert.createAlert(text: "message", position: alertPosition)
alert.setStyle(textColor: .white, font: UIFont.systemFont(ofSize: 22), textAligment: .center)
alert.backgroundColor = .black
alert.present(animated: true)
```

Show an alert with attributed text
```swift
import MDTAlert

let attributes: [NSAttributedString.Key : Any]? = [
		.font: UIFont.systemFont(ofSize: 16),
		.foregroundColor: UIColor.green
]
let attributedText = NSAttributedString(string: "message", attributes: attributes)
MDTAlert.showAlert(attributedText: attributedText, position: alertPosition)
```

Show an alert with text
```swift
import MDTAlert

MDTAlert.showAlert(text: "message", position: alertPosition)
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

