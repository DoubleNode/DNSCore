//
//  UIButton+dnsApplyTheme.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIButton {
    func dnsApply(_ style: DNSThemeButtonStyle) {
        // UIViewStyle
        self.backgroundColor = style.backgroundColor.normal
        self.layer.borderColor = style.border.color.normal.cgColor
        self.layer.borderWidth = CGFloat(style.border.width)
        self.layer.cornerRadius = CGFloat(style.border.cornerRadius)
        self.layer.shadowColor = style.shadow.color.normal.cgColor
        self.layer.shadowOffset = style.shadow.offset
        self.layer.shadowOpacity = style.shadow.opacity
        self.layer.shadowRadius = style.shadow.radius
        self.tintColor = style.tintColor.normal
        // UIButtonStyle
        self.setTitleColor(style.titleColor.normal, for: UIControl.State.normal)
        self.setTitleColor(style.titleColor.disabled, for: UIControl.State.disabled)
        self.setTitleColor(style.titleColor.focused, for: UIControl.State.focused)
        self.setTitleColor(style.titleColor.highlighted, for: UIControl.State.highlighted)
        self.setTitleColor(style.titleColor.selected, for: UIControl.State.selected)
        self.titleLabel?.font = UIFont.dnsFrom(style.titleFont)
        self.setTitleShadowColor(style.titleShadowColor.normal, for: UIControl.State.normal)
        self.setTitleShadowColor(style.titleShadowColor.disabled, for: UIControl.State.disabled)
        self.setTitleShadowColor(style.titleShadowColor.focused, for: UIControl.State.focused)
        self.setTitleShadowColor(style.titleShadowColor.highlighted, for: UIControl.State.highlighted)
        self.setTitleShadowColor(style.titleShadowColor.selected, for: UIControl.State.selected)
    }
}
