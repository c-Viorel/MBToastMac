//
//  SharedFunctionality.swift
//  MBToast
//
//  Created by Viorel P on 10/08/2023.
//  Copyright (c) 2023 Viorel P. All rights reserved.
//

import Foundation
import AppKit
import QuartzCore


fileprivate class HideAnimationDelegate: NSObject, CAAnimationDelegate {
    private weak var view: NSView?
    fileprivate init(view: NSView) {
        self.view = view
    }

    fileprivate static func delegate(forView view: NSView) -> CAAnimationDelegate {
        return HideAnimationDelegate(view: view)
    }

    fileprivate func animationDidStart(_ anim: CAAnimation) {
        view?._layer.opacity = 0.0
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        view?.removeFromSuperview()
        view = nil
    }
}

fileprivate class ShowAnimationDelegate: NSObject, CAAnimationDelegate {
    private weak var view: NSView?
    fileprivate init(view: NSView) {
        self.view = view
    }

    fileprivate static func delegate(forView view: NSView) -> CAAnimationDelegate {
        return ShowAnimationDelegate(view: view)
    }

    fileprivate func animationDidStart(_ anim: CAAnimation) {
        view?._layer.opacity = 1.0
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    }
}

func showAnimation(view: NSView, style: Style) {
    let anim = CABasicAnimation(keyPath: "opacity")
//    let timing = CAMediaTimingFunction(name: .linear)
//    anim.timingFunction = timing
    let currentLayerTime = view._layer.convertTime(CACurrentMediaTime(), from: nil)
    anim.beginTime = currentLayerTime + CFTimeInterval(style.fadeInOutDelay)
    anim.duration = CFTimeInterval(style.fadeInOutDuration)
    anim.fromValue = 0.0
    anim.toValue = 1.0
    anim.isRemovedOnCompletion = false
    anim.delegate = ShowAnimationDelegate.delegate(forView: view)

    view._layer.add(anim, forKey: "show animation")
}

func hideAnimation(view: NSView, style: Style) {
    let anim = CABasicAnimation(keyPath: "opacity")
//    let timing = CAMediaTimingFunction(name: .linear)
//    anim.timingFunction = timing
    let currentLayerTime = view._layer.convertTime(CACurrentMediaTime(), from: nil)
    anim.beginTime = currentLayerTime + CFTimeInterval(style.fadeInOutDelay)
    anim.duration = CFTimeInterval(style.fadeInOutDuration)
    anim.fromValue = 1.0
    anim.toValue = 0.0
    anim.isRemovedOnCompletion = false
    anim.delegate = HideAnimationDelegate.delegate(forView: view)

    view._layer.add(anim, forKey: "hide animation")
}
