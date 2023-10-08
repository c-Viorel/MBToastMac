//
//  Extensions.swift
//  MBToast
//
//  Created by Viorel P on 10/08/2023.
//  Copyright (c) 2023 Viorel P. All rights reserved.
//

import Foundation
import AppKit
import Cocoa

extension NSImage {
    func tinting(with tintColor: NSColor) -> NSImage {
        guard let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return self }

        return NSImage(size: size, flipped: false) { bounds in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }

            tintColor.set()
            context.clip(to: bounds, mask: cgImage)
            context.fill(bounds)

            return true
        }
    }
}


extension CGRect {
    static func center(of layer: CALayer) -> CGPoint {
        let parentSize = layer.frame.size
        return CGPoint(x: parentSize.width / 2, y: parentSize.height / 2)
    }

    static func positionText(of layer: CALayer, with imgRect:CGRect, andExtraspace space:CGFloat) -> CGPoint {
        let parentSize = layer.frame.size
        let com = imgRect.width / 2 
        return CGPoint(x: parentSize.width / 2 + com, y: parentSize.height / 2)
    }

    func positionImage(of layer: CALayer, with margin:CGFloat) -> CGPoint {
        let parentSize = layer.frame.size
        return CGPoint(x: margin + width / 2, y: parentSize.height / 2)
    }

    static func center(of parent: NSView) -> CGPoint {
        let parentSize = parent.frame.size
        return CGPoint(x: parentSize.width / 2, y: parentSize.height / 2)
    }

    func center(for position: MBToastPosition, of parent:NSView) -> CGPoint {
        let parentSize = parent.frame.size

        switch position {
        case .center:
            return CGPoint(x: parentSize.width / 2, y: parentSize.height / 2)
        case .topCenter(let marginY):
            return CGPoint(x: parentSize.width / 2, y: parentSize.height -  marginY - self.midY)
        case .bottomCenter(let marginY):
            return CGPoint(x: parentSize.width / 2, y:  marginY + self.midY)
        case .topLeft(let marginX, let marginY):
            return CGPoint(x:  marginX + self.midX, y:  parentSize.height -  marginY - midY)
        case .bottomLeft(let marginX, let marginY):
            return CGPoint(x: marginX + midX, y:  marginY + midY)
        case .topRight(let marginX, let marginY):
            return CGPoint(x: parentSize.width - marginX - self.midX, y:  parentSize.height -  marginY - midY)
        case .bottomRight(let marginX, let marginY):
            return CGPoint(x: parentSize.width - marginX - self.midX, y:  marginY + midY)
        }
        
    }
}

extension NSString {
    func toast_size(with attributes: [NSAttributedString.Key: Any]?) -> CGSize {
        return size(withAttributes: attributes)
    }
}

extension NSView {
    var _layer: CALayer {
        return layer!
    }
}

extension String {
    func size(with fontSize: CGFloat) -> CGSize {
        let attr: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: NSFont.systemFont(ofSize: fontSize)]
        let size = NSString(string: self).toast_size(with: attr)
        return size
    }
}
