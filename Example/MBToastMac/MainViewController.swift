//
// NSViewController.swift
//  MBToast
//
//  Created by Viorel P on 10/08/2023.
//  Copyright (c) 2023 Viorel P. All rights reserved.
//

import Cocoa
import MBToastMac

@IBDesignable
class CustomView: NSView {

    @IBInspectable var bacgroundColor: NSColor = .white { didSet{self.needsDisplay = true }}

    override func draw(_ dirtyRect: NSRect) {
        bacgroundColor.setFill()
        dirtyRect.fill()
    }

}

class MainViewController: NSViewController {

    @IBOutlet weak var toastMessageLabel: NSTextField!
    @IBOutlet weak var fontSizeField: NSTextField!
    @IBOutlet weak var horizontalMarginField: NSTextField!
    @IBOutlet weak var verticalMarginField: NSTextField!
    @IBOutlet weak var cornerRadiusField: NSTextField!
    @IBOutlet weak var fadeOutDelayField: NSTextField!
    @IBOutlet weak var backgroundColorField: NSColorWell!
    @IBOutlet weak var textColorField: NSColorWell!
    @IBOutlet weak var positionField: NSComboBox!

    @IBOutlet weak var iconField: NSImageView!
    @IBOutlet weak var iconColorField: NSColorWell!
    @IBOutlet weak var startToastActivityBtn: NSButton!


    @IBAction func showToast(_ sender: Any) {
        self.view.makeToast(toastMessageLabel.stringValue, style: self)
    }

    @IBAction func showSuccess(_ sender: Any) {
        self.view.makeToast(toastMessageLabel.stringValue, style: MBToastStyleSuccess())
    }

    @IBAction func showWarning(_ sender: Any) {
        self.view.makeToast(toastMessageLabel.stringValue, style: MBToastStyleWarning())

    }

    @IBAction func showInfo(_ sender: Any) {
        self.view.makeToast(toastMessageLabel.stringValue, style: MBToastStyleInfo())
    }

    // Progress
    @IBAction func startProgress(_ sender: Any) {
        startToastActivityBtn.isEnabled = false
        self.view.makeToastActivity()
    }

    @IBAction func stopProgress(_ sender: Any) {
        self.view.hideToastActivity()
        startToastActivityBtn.isEnabled = true
    }


    // Update values
    @IBAction func updateFontSize(_ sender: NSStepper) {
        fontSizeField.intValue = sender.intValue
    }

    @IBAction func updateHorizontalMargin(_ sender: NSStepper) {
        horizontalMarginField.intValue = sender.intValue
    }

    @IBAction func updateVerticalMargin(_ sender: NSStepper) {
        verticalMarginField.intValue = sender.intValue
    }

    @IBAction func updateCornerRadius(_ sender: NSStepper) {
        cornerRadiusField.intValue = sender.intValue
    }

    @IBAction func updateFadeOutDelay(_ sender: NSStepper) {
        fadeOutDelayField.floatValue = sender.floatValue
    }

    @IBAction func clearImage(_ sender: NSButton) {
        iconField.image = nil
    }



}

extension MainViewController:Style {
    public var fontSize: CGFloat { return CGFloat(fontSizeField.intValue) }
    public var horizontalMargin: CGFloat { return CGFloat(horizontalMarginField.intValue) }
    public var verticalMargin: CGFloat { return CGFloat(verticalMarginField.intValue) }
    public var cornerRadius: CGFloat { return CGFloat(cornerRadiusField.intValue) }
    public var backgroundColor: NSColor { return backgroundColorField.color }
    public var foregroundColor: NSColor { return textColorField.color }
    public var fadeInOutDelay: CGFloat { return CGFloat(fadeOutDelayField.floatValue) }
    public var position: MBToastPosition {
        switch positionField.stringValue {
        case "Center":
            return .center
        case "Top center":
            return .topCenter()
        case "Bottom center":
            return .bottomCenter()
        case "Top left":
            return .topLeft()
        case "Top right":
            return .topRight()
        case "Bottom left":
            return .bottomLeft()
        case "Bottom right":
            return .bottomRight()

        default:
            return .center
        }

    }

    var icon: NSImage? {
        return iconField.image
    }


    var iconTint:NSColor {
        return iconColorField.color
    }

}


public struct MyCustomStandardStyle: Style {

    public var fontSize: CGFloat { return 16 }
    public var font: NSFont {
        return NSFont.systemFont(ofSize: fontSize, weight: .semibold)
    }

    public var horizontalMargin: CGFloat { return 15 }
    public var verticalMargin: CGFloat { return 6 }
    public var cornerRadius: CGFloat { return 100 }
    public var backgroundColor: NSColor { return .white }
    public var foregroundColor: NSColor { return .black }
    public var fadeInOutDelay: CGFloat { return 1.5 }
    public var position: MBToastPosition { return .bottomCenter() }
}
