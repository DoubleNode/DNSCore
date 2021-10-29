//
//  DNSUIColor.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

open class DNSUIColor {
    public var disabled: UIColor
    public var focused: UIColor
    public var highlighted: UIColor
    public var normal: UIColor
    public var selected: UIColor
    
    required public init(_ normal: UIColor,
                         disabled: UIColor? = nil,
                         focused: UIColor? = nil,
                         highlighted: UIColor? = nil,
                         selected: UIColor? = nil) {
        self.normal = normal
        self.disabled = disabled ?? normal
        self.focused = focused ?? normal
        self.highlighted = highlighted ?? normal
        self.selected = selected ?? normal
    }
}
public extension DNSUIColor {
    enum Base {
        public static var border = DNSUIColor(UIColor.Base.border)
        public static var shadow = DNSUIColor(UIColor.Base.shadow)
        public enum Button {
            public static var background = DNSUIColor(UIColor.Base.Button.Background.normal,
                                                      disabled: UIColor.Base.Button.Background.disabled,
                                                      focused: UIColor.Base.Button.Background.focused,
                                                      highlighted: UIColor.Base.Button.Background.highlighted,
                                                      selected: UIColor.Base.Button.Background.selected)
            public static var border = DNSUIColor(UIColor.Base.Button.Border.normal,
                                                  disabled: UIColor.Base.Button.Border.disabled,
                                                  focused: UIColor.Base.Button.Border.focused,
                                                  highlighted: UIColor.Base.Button.Border.highlighted,
                                                  selected: UIColor.Base.Button.Border.selected)
            public static var shadow = DNSUIColor(UIColor.Base.Button.Shadow.normal,
                                                  disabled: UIColor.Base.Button.Shadow.disabled,
                                                  focused: UIColor.Base.Button.Shadow.focused,
                                                  highlighted: UIColor.Base.Button.Shadow.highlighted,
                                                  selected: UIColor.Base.Button.Shadow.selected)
            public static var subtitle = DNSUIColor(UIColor.Base.Button.Subtitle.normal,
                                                    disabled: UIColor.Base.Button.Subtitle.disabled,
                                                    focused: UIColor.Base.Button.Subtitle.focused,
                                                    highlighted: UIColor.Base.Button.Subtitle.highlighted,
                                                    selected: UIColor.Base.Button.Subtitle.selected)
            public static var subtitleShadow = DNSUIColor(UIColor.Base.Button.Subtitle.Shadow.normal,
                                                          disabled: UIColor.Base.Button.Subtitle.Shadow.disabled,
                                                          focused: UIColor.Base.Button.Subtitle.Shadow.focused,
                                                          highlighted: UIColor.Base.Button.Subtitle.Shadow.highlighted,
                                                          selected: UIColor.Base.Button.Subtitle.Shadow.selected)
            public static var tint = DNSUIColor(UIColor.Base.Button.Tint.normal,
                                                disabled: UIColor.Base.Button.Tint.disabled,
                                                focused: UIColor.Base.Button.Tint.focused,
                                                highlighted: UIColor.Base.Button.Tint.highlighted,
                                                selected: UIColor.Base.Button.Tint.selected)
            public static var title = DNSUIColor(UIColor.Base.Button.Title.normal,
                                                 disabled: UIColor.Base.Button.Title.disabled,
                                                 focused: UIColor.Base.Button.Title.focused,
                                                 highlighted: UIColor.Base.Button.Title.highlighted,
                                                 selected: UIColor.Base.Button.Title.selected)
            public static var titleShadow = DNSUIColor(UIColor.Base.Button.Title.Shadow.normal,
                                                       disabled: UIColor.Base.Button.Title.Shadow.disabled,
                                                       focused: UIColor.Base.Button.Title.Shadow.focused,
                                                       highlighted: UIColor.Base.Button.Title.Shadow.highlighted,
                                                       selected: UIColor.Base.Button.Title.Shadow.selected)
        }
    }
}
