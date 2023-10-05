# easy-ios-constraint

Easy iOS constraint programmatically in Swift 🚀

## Requirements
- iOS: 11.x
- Swift Package Manager: 5.4

## Installation
### Swift Package Manager
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding easy-ios-constraint as a dependency is as easy as adding it to the dependencies value of your Package.swift.
```swift
dependencies: [
    .package(url: "https://github.com/indratir/easy-ios-constraint.git", from: "1.0.0")
]
```
### CocoaPods
CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
pod 'easy-ios-constraint'
```

## Usage
### Align & Fill
```swift
// Align all sides of view to superview
view.alignWithSuperview(sides: [.leading, .top, .trailing, .bottom])
// It also can be achieved using fillSuperview
view.fillSuperview()

// Align multiple sides of view to the same sides of superview with distance
view.alignWithSuperview(sides: [.leading, .trailing], distance: 20.0)
// It also can be achieved using fillSuperviewWidth
view.fillSuperviewWidth(distance: 20.0)

// Align single side of view to superview
view.alignWithSuperview(.top)

// Align single side of view to specific side of any view
subtitleLabel.align(.top, withSide: .bottom, of: titleLabel, distance: 8.0)

// Align & fill also available for safe area
view.alignWithSafeArea(sides: [.leading, .top, .trailing, .bottom])
view.alignWithSafeArea(.top)
view.fillSafeArea()
```

### Pin Dimension
```swift
// Set view's dimension with constant value
view.pinSize(128.0)
view.pinWidth(64.0)

// Set view's dimension equal to specific view
subtitleLabel.pinHeight(to: titleLabel)

// Set view's aspect ratio
// e.g: squared imageView (1:1)
imageView.pinWidth(100.0)
imageView.aspectRatio(for: .height, ratio: 1.0)
```

### Pin Center
```swift
// Set view into center of superview
view.pinCenter()

// Set view to be centerHorizontally from superview
view.pinCenterHorizontally()

// Set view to be centerVertically from any view
imageView.pinCenterVertically(to: containerView)
```

## Author
indratir, tirta777@gmail.com, [@indratir](https://twitter.com/indratir)

## License
easy-ios-constraint is available under the MIT license. See the LICENSE file for more info.
