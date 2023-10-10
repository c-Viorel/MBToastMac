//
//  Toast.swift
//  MBToast
//
//  Created by Viorel P on 10/08/2023.
//  Copyright (c) 2023 Viorel P. All rights reserved.
//

import AppKit
import Cocoa


public enum MBToastPosition {
    case center
    case topCenter(marginY: CGFloat = 20)
    case bottomCenter(marginY: CGFloat = 20)
    case topLeft(marginX:CGFloat = 20, marginY:CGFloat = 20)
    case bottomLeft(marginX:CGFloat = 20, marginY:CGFloat = 20)
    case topRight(marginX:CGFloat = 20, marginY:CGFloat = 20)
    case bottomRight(marginX:CGFloat = 20, marginY:CGFloat = 20)
}

public protocol Style {
    var fontSize: CGFloat { get }
    var horizontalMargin: CGFloat { get }
    var verticalMargin: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var font: NSFont { get }
    var backgroundColor: NSColor { get }
    var foregroundColor: NSColor { get }
    var fadeInOutDuration: CGFloat { get }
    var fadeInOutDelay: CGFloat { get }
    var labelOriginWithMargin: CGPoint { get }
    var activitySize: CGSize { get }
    var position:MBToastPosition { get }
    var icon: NSImage? { get }
    var iconTint: NSColor { get }
}

extension Style {
    public var labelOriginWithMargin: CGPoint {
        return CGPoint(x: horizontalMargin, y: verticalMargin)
    }
    public var fontSize: CGFloat { return 16 }
    public var font: NSFont {
        return NSFont.systemFont(ofSize: fontSize)
    }

    public var horizontalMargin: CGFloat { return 10 }
    public var verticalMargin: CGFloat { return 5 }
    public var cornerRadius: CGFloat { return 6 }
    public var backgroundColor: NSColor { return .black }
    public var foregroundColor: NSColor { return .white }
    public var activitySize: CGSize { return CGSize(width: 100, height: 100) }
    public var fadeInOutDuration: CGFloat { return 1.0 }
    public var fadeInOutDelay: CGFloat { return 1.0 }
    public var position: MBToastPosition { return .topRight() }
    public var icon: NSImage? { return nil }
    public var iconTint:NSColor { return foregroundColor }

}

public struct DefaultStyle: Style {
    public static let shared = DefaultStyle()
}

public struct MBToastStyleSuccess: Style {
    public init() {}
    public var backgroundColor: NSColor { return NSColor(red: 0.9098, green: 0.9608, blue: 0.9137, alpha: 1.0) } // #E8F5E9
    public var foregroundColor: NSColor { return NSColor(red: 0.4, green: 0.7333, blue: 0.4157, alpha: 1.0) } // #66BB6A
}

public struct MBToastStyleWarning: Style {
    public init() {}
    public var backgroundColor: NSColor { return NSColor(red: 1.0, green: 0.9529, blue: 0.8784, alpha: 1.0)} // #FFF3E0
    public var foregroundColor: NSColor { return NSColor(red: 1.0, green: 0.6549, blue: 0.1490, alpha: 1.0)} // #FFA726
}

public struct MBToastStyleInfo: Style {
    public init() {}
    public var backgroundColor: NSColor { return NSColor(red: 0.9098, green: 0.9569, blue: 1.0, alpha: 1.0)} // #E8F4FF
    public var foregroundColor: NSColor { return NSColor(red: 0.2588, green: 0.6471, blue: 0.9608, alpha: 1.0)} // #42A5F5
}

public struct MBToastStyleError: Style {
    public var backgroundColor: NSColor { return NSColor(red: 1.0, green: 0.9216, blue: 0.9333, alpha: 1.0) } // #FFEBEE
    public var foregroundColor: NSColor { return  NSColor(red: 0.9373, green: 0.3255, blue: 0.3137, alpha: 1.0)} // #EF5350
}

public struct IndicatorStyle: Style {
    public static let shared = IndicatorStyle()
    public var fadeInOutDuration: CGFloat = 0.1
    public var fadeInOutDelay: CGFloat = 0.0
    public var backgroundColor: NSColor

     init() {
        backgroundColor = NSColor.black.withAlphaComponent(0.8)
    }
}


class ToastView: NSView {
    private let message: String
    private let labelSize: CGSize
    private let style: Style

    init(message: String, style: Style) {
        self.message = message
        self.style = style
        labelSize = message.size(with: style.fontSize)
        let size = CGSize(
            width: labelSize.width + style.horizontalMargin * 2,
            height: labelSize.height + style.verticalMargin * 2
        )
        let rect = CGRect(origin: .zero, size: size)
        super.init(frame: rect)

        wantsLayer = true
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }


        override func viewDidMoveToSuperview() {
            super.viewDidMoveToSuperview()
            if superview != nil {
                configure()
            }
        }


    private func configure() {
        frame = superview!.bounds
        var rect = CGRect(origin: style.labelOriginWithMargin, size: labelSize)
        var sizeWithMargin = CGSize(
            width: rect.width + style.horizontalMargin * 2,
            height: rect.height + style.verticalMargin * 2
        )

        let imageRect = CGRect.init(origin: CGPoint.zero, size: NSMakeSize(labelSize.height, labelSize.height))

        var rectWithMargin = CGRect(
            origin: .zero, // position is manipulated later anyways
            size: sizeWithMargin
        )
        let extraSpace = labelSize.height / 2.2
        if style.icon != nil {
            rect.origin = CGPoint(x: style.horizontalMargin + imageRect.width + extraSpace , y: style.verticalMargin)
            sizeWithMargin = CGSize(
                width: sizeWithMargin.width + extraSpace + imageRect.width,
                height: sizeWithMargin.height
            )
            rectWithMargin = CGRect(
                origin: .zero, // position is manipulated later anyways
                size: sizeWithMargin
            )
        }
        // outside Container
        let container = CALayer()
        container.frame = rectWithMargin
        container.position = rectWithMargin.center(for: style.position, of: superview!) // center(of: superview!)
        container.backgroundColor = style.backgroundColor.cgColor
        let maxRadius = container.frame.height / 2
        if  maxRadius > style.cornerRadius {
            container.cornerRadius = style.cornerRadius
        } else {
            container.cornerRadius = maxRadius

        }
        _layer.addSublayer(container)
        // inside TextLayer
        let text = CATextLayer()
        text.frame = rect
        if style.icon != nil {
            text.position = CGRect.positionText(of: container, with: imageRect, andExtraspace: extraSpace)
        } else {
            text.position = CGRect.center(of: container)
        }
        text.string = message
        text.font = NSFont.systemFont(ofSize: style.fontSize)
        text.fontSize = style.fontSize
        text.alignmentMode = .center
        text.foregroundColor = style.foregroundColor.cgColor
        text.backgroundColor = style.backgroundColor.cgColor
        text.contentsScale = _layer.contentsScale // For Retina Display
        container.addSublayer(text)

        // inside image layer
        if style.icon != nil {
            let img = CALayer()
            img.frame = imageRect
            img.position =  img.frame.positionImage(of: container, with: style.horizontalMargin)
            let originalImage = style.icon! // Replace with your NSImage instance

            let tintedResizedImage = originalImage.tinting(with: style.iconTint)

            img.contents = tintedResizedImage
            img.contentsGravity = .resizeAspectFill
            container.addSublayer(img)
        }
    }
}

class ActivityView: NSView {
    let _indicator = _Indicator.create()
    var style: Style
    init() {
        style = IndicatorStyle()
        let rect = CGRect(origin: .zero, size: .zero)
        super.init(frame: rect)
        wantsLayer = true
    }

    required init?(coder aDecoder: NSCoder) { fatalError() }

    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        if superview != nil {
            configure()
        }
    }

    private func configure() {
        frame = superview!.bounds
        let size = style.activitySize
        let origin = CGPoint(x: frame.width / 2 - size.width / 2, y: frame.height / 2 - size.height / 2)

        _indicator.frame = CGRect(origin: origin, size: size)
        _layer.backgroundColor = NSColor.gray.withAlphaComponent(0.6).cgColor

        addSubview(_indicator)
        _indicator._startAnimating()
    }
}


typealias _Indicator = NSProgressIndicator


extension _Indicator {
    static func create() -> _Indicator {
            return _Indicator()
    }

    func _startAnimating() {
        startAnimation(nil)
    }
}

