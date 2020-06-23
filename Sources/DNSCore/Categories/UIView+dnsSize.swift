//
//  UIView+dnsSize.swift
//  DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIView {
    var visible: Bool! {
        return !(self.window == nil && self.superview == nil)
    }

    var origin: CGPoint! {
        get {
            return self.frame.origin
        }
        set(newOrigin) {
            self.frame = CGRect(x: newOrigin.x,
                                y: newOrigin.y,
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        }
    }
    var x: CGFloat! {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            self.frame = CGRect(x: newX,
                                y: self.frame.origin.y,
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        }
    }
    var y: CGFloat! {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            self.frame = CGRect(x: self.frame.origin.x,
                                y: newY,
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        }
    }
    var size: CGSize! {
        get {
            return self.frame.size
        }
        set(newSize) {
            self.frame = CGRect(x: self.frame.origin.x,
                                y: self.frame.origin.y,
                                width: newSize.width,
                                height: newSize.height)
        }
    }
    var width: CGFloat! {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            self.frame = CGRect(x: self.frame.origin.x,
                                y: self.frame.origin.y,
                                width: newWidth,
                                height: self.frame.size.height)
        }
    }
    var height: CGFloat! {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            self.frame = CGRect(x: self.frame.origin.x,
                                y: self.frame.origin.y,
                                width: self.frame.size.width,
                                height: newHeight)
        }
    }
}
