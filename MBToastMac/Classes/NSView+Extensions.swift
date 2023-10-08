//
//  NSView+Extensions.swift
//  MBToast_Example
//
//  Created by Viorel Porumbescu on 08.10.2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Cocoa

private struct ToastKeys {
    static var ActiveToast = "MBToastActiveToastKey"
    static var ActivityView = "MBToastActivityViewKey"
}


public extension NSView {
    // MARK: Toast Message

     func makeToast(_ message: String, style: Style =  DefaultStyle.shared ) {
        let toast = ToastView(message: message, style: style)
        addSubview(toast)
        hideAnimation(view: toast, style: style)
    }

    // MARK: Indicator

     func makeToastActivity() {
        let activityView = ActivityView()
        objc_setAssociatedObject(self, &ToastKeys.ActivityView, activityView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        activityView._layer.opacity = 0.0
        addSubview(activityView)
        showAnimation(view: activityView, style: IndicatorStyle.shared)
    }

     func hideToastActivity() {
        if let activityView = objc_getAssociatedObject(self, &ToastKeys.ActivityView) as?NSView {
            hideAnimation(view: activityView, style: IndicatorStyle.shared)
        }
    }
}
