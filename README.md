
<p align="center">
  <br/><a href="https://cocoapods.org/pods/EasyGCD">
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.1-brightgreen.svg">
  <img alt="Author" src="https://img.shields.io/badge/author-Meniny-blue.svg">
  <img alt="Build Passing" src="https://img.shields.io/badge/build-passing-brightgreen.svg">
  <img alt="Swift" src="https://img.shields.io/badge/swift-3.0%2B-orange.svg">
  <br/>
  <img alt="Platforms" src="https://img.shields.io/badge/platform-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg">
  <img alt="MIT" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <br/>
  <img alt="Cocoapods" src="https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg">
  <img alt="Carthage" src="https://img.shields.io/badge/carthage-working%20on-red.svg">
  <img alt="SPM" src="https://img.shields.io/badge/swift%20package%20manager-working%20on-red.svg">
  </a>
</p>

## What's this?

`Localization` is a Localization Manager written in Swift.

## Requirements

* iOS 8.0+
* macOS 10.10+
* watchOS 2.0+
* tvOS 9.0+
* Xcode 8 with Swift 3

## Installation

#### CocoaPods

```ruby
use_frameworks!
pod 'Localization'
```

## Contribution

You are welcome to fork and submit pull requests.

## License

`Localization` is open-sourced software, licensed under the `MIT` license.

## Usage

```swift
import Localization

class SomeSettingsClass {
  func changeLanguage() {
      Localization.preferredLanguage = LocalizableLanguage.french.code // == "fr"
  }
}
```

```swift
import Localization

class SomeViewController: UIViewController {
  var someLabel: UILabel = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    // ...

    Localization.startObserve(with: self, selector: #selector(localizationDidChangeWithPreferredLanguage))
    }

  deinit {
    Localization.stopObserve(with: self)
  }

  func localizationDidChangeWithPreferredLanguage() {
    someLabel.text = "SomeLocalizationKey".localized()
  }
}
```
