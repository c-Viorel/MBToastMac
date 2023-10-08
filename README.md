# MBToastMac

[![Version](https://img.shields.io/cocoapods/v/MBToastMac.svg?style=flat)](https://cocoapods.org/pods/MBToastMac)
[![License](https://img.shields.io/cocoapods/l/MBToastMac.svg?style=flat)](https://cocoapods.org/pods/MBToastMac)
[![Platform](https://img.shields.io/cocoapods/p/MBToastMac.svg?style=flat)](https://cocoapods.org/pods/MBToastMac)

<p align="center">
  <img src="https://github.com/c-Viorel/MBToastMac/blob/main/Example/toast_icon.png?raw=true" alt="Toast Icon">
</p>


## MBToastMac: Toasts for macOS. Crafted in Swift.

  In the world of macOS development, clarity and brevity are often the keys to effective user interaction. MBToast was forged with this philosophy in mind.

  We understand that every interaction, no matter how brief, is a touchpoint between the user and the software. It’s a chance to inform, to guide, to reassure. That’s why we developed a toast system that's not just about fleeting messages but about enriching those small moments of communication.

  Why choose MBToast?

  Simplicity: Our library integrates seamlessly into your macOS projects, allowing you to implement toasts without the weight of unnecessary features.

  Efficiency: Built with Swift, it's optimized for performance, ensuring your app remains agile and responsive.

  Customizability: While we value minimalism, we also understand the importance of adaptability. Customize to fit your application's aesthetics, ensuring consistency in design.

  Reliability: Every toast delivered is a result of rigorous testing and refinement, ensuring reliability in varied use-cases.

  Dive into MBToast – where minimalism meets function. Elevate your user feedback and make every message count.
  
  ![Toast Eaxample](https://github.com/c-Viorel/MBToastMac/blob/main/Example/MBToast_description.gif?raw=true)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Basic Usage

### 1. Displaying a Custom Toast Message
To show a basic toast message with a custom style:

```swift
self.view.makeToast("Your Message Here")

```
## 2. Displaying Predefined Toast Styles
- Success Toast
```
self.view.makeToast("Your Message Here", style: MBToastStyleSuccess())
``` 
- Warning Toast
```swift
self.view.makeToast("Your Message Here", style: MBToastStyleWarning())
```
- Info Toast 
```swift
self.view.makeToast("Your Message Here", style: MBToastStyleInfo())
```

## 3. Displaying Progress Toast
Utilize the overlay progress indicator for instances where the duration is indeterminate. This feature ensures users are informed during periods of background activity or while awaiting a response.
- Start Progress
```swift
self.view.makeToastActivity()
``` 

- Stop Progress
```swift
self.view.hideToastActivity()
``` 

## Customization

You have the ability to fully customize the appearance and behavior of the toast notifications by conforming to the `Style` protocol. This protocol provides a wide range of properties to adjust, such as font size, margin adjustments, color specifications, and more. By conforming to this protocol, you can tailor the toast appearance to better fit your application's theme and design philosophy.

### `Style` Protocol Properties:

- **fontSize**: Font size of the message.
- **horizontalMargin**: Horizontal margin for the toast.
- **verticalMargin**: Vertical margin for the toast.
- **cornerRadius**: Corner radius of the toast.
- **font**: Font of the message.
- **backgroundColor**: Background color of the toast.
- **foregroundColor**: Text color of the message.
- **fadeInOutDuration**: Duration of the fade in/out animations.
- **fadeInOutDelay**: Delay before the fade out begins.
- **labelOriginWithMargin**: Origin point of the message label with margins.
- **activitySize**: Size of the progress indicator.
- **position**: Position of the toast on the screen.
- **icon**: Optional icon image. Default is nil.
- **iconTint**: Tint color for the icon. (if provided)

### Custom Style Example:

To create your custom style, you can implement the `Style` protocol like the following:

```swift
struct CustomToastStyle: Style {
    var fontSize: CGFloat = 14.0
    var fontSize: CGFloat = 14.0
    var horizontalMargin: CGFloat = 15.0
    var verticalMargin: CGFloat = 10.0
    var cornerRadius: CGFloat = 5.0
    var font: NSFont = NSFont.systemFont(ofSize: 14.0)
    var backgroundColor: NSColor = NSColor.black.withAlphaComponent(0.7)
    var foregroundColor: NSColor = NSColor.white
    var fadeInOutDuration: CGFloat = 0.3
    var fadeInOutDelay: CGFloat = 2.0
    var labelOriginWithMargin: CGPoint = CGPoint(x: 15.0, y: 10.0)
    var activitySize: CGSize = CGSize(width: 50, height: 50)
    var position: MBToastPosition = .bottom
    var icon: NSImage? = nil
    var iconTint: NSColor = NSColor.white
}
```


```swift
// Usage:
self.view.makeToast("Custom styled toast", style: CustomToastStyle())
```


## Installation

MBToast is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MBToastMac'
```

## Author

**Viorel Porumbescu**  
📧 [viorelporumbescu@outlook.com](mailto:viorelporumbescu@outlook.com)  
📄 [Resume](https://resume.viorelporumbescu.tech/)

## License

MBToast is available under the MIT license. See the LICENSE file for more info.
