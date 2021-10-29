//
//  DNSUIButton.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//
//  Derived from work done by Paulo Silva
//  https://github.com/paulosilva/CustomUIView
//

import UIKit

@IBDesignable open class DNSUIButton: UIButton {
    public var style: DNSThemeStyle? {
        didSet {
            guard let style = style else { return }
            self.utilityApply(style)
        }
    }
    // MARK: - Utility Methods -
    open func utilityApply(_ style: DNSThemeStyle) {
        if let style = style as? DNSThemeViewStyle {
            self.backgroundColor = style.backgroundColor.normal
            self.borderColor = style.border.color.normal
            self.borderWidth = CGFloat(style.border.width)
            self.cornerRadius = CGFloat(style.border.cornerRadius)
            self.cornerTopLeftRadius = CGFloat(style.border.cornerTopLeftRadius)
            self.cornerTopRightRadius = CGFloat(style.border.cornerTopRightRadius)
            self.cornerBottomLeftRadius = CGFloat(style.border.cornerBottomLeftRadius)
            self.cornerBottomRightRadius = CGFloat(style.border.cornerBottomRightRadius)
            self.cornerRadiusMulti = style.border.cornerRadiusMulti
            self.shadowColor = style.shadow.color.normal
            self.shadowOffset = style.shadow.offset
            self.shadowOpacity = Float(style.shadow.opacity)
            self.shadowRadius = style.shadow.radius
            self.tintColor = style.tintColor.normal
        }
        if let style = style as? DNSThemeButtonStyle {
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

    // MARK: - Private Variables -
    private let containerView = UIView()
    private var containerImageView = UIImageView()
    
// MARK: - Public Attributes -
//    @IBInspectable public var backgroundImage: UIImage? {
//        get {
//            return self.containerImageView.image
//        }
//        set {
////            addShadowColorFromBackgroundImage()
//            self.containerImageView.image = newValue
//        }
//    }
    override open var backgroundColor: UIColor? {
        didSet(newBackgroundColor) {
            if let newBackgroundColor = newBackgroundColor {
                containerView.backgroundColor = newBackgroundColor
            }
            if backgroundColor != UIColor.clear { backgroundColor = UIColor.clear }
        }
    }
    override open var clipsToBounds: Bool {
        didSet(new) {
            containerView.clipsToBounds = new
            containerImageView.clipsToBounds = new
        }
    }
    @IBInspectable open var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.containerView.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
            self.containerView.layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return self.containerView.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
            self.containerView.layer.borderWidth = newValue
        }
    }
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return self.containerView.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.containerView.layer.cornerRadius = newValue
        }
    }
    @IBInspectable open var cornerRadiusMulti: Bool = false
    @IBInspectable open var cornerTopLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    @IBInspectable open var cornerTopRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    @IBInspectable open var cornerBottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    @IBInspectable open var cornerBottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    @IBInspectable open var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
            self.containerView.layer.shadowOpacity = newValue
        }
    }
    @IBInspectable open var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.containerView.layer.shadowRadius = newValue
        }
    }
    @IBInspectable open var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
            self.containerView.layer.shadowOffset = newValue
        }
    }
    @IBInspectable open var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
            self.containerView.layer.shadowColor = newValue.cgColor
        }
    }
//    @IBInspectable var shadowColorFromImage: Bool = false {
//        didSet {
//            addShadowColorFromBackgroundImage()
//        }
//    }
    
    // MARK: - Life Cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewLayoutSubViews()
        refreshViewLayout()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViewLayoutSubViews()
        refreshViewLayout()
    }
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        refreshViewLayout()
//        addShadowColorFromBackgroundImage()
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        refreshViewLayout()
//        addShadowColorFromBackgroundImage()
        applyRadiusMaskFor()
    }
    
    // MARK: - Private Methods -
    private func refreshViewLayout() {
        // View
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        
        // Shadow
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
        // Container View
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = cornerRadius
        
        // Image View
        self.containerImageView.backgroundColor = UIColor.clear
        //self.containerImageView.image = backgroundImage
        self.containerImageView.layer.cornerRadius = cornerRadius
        self.containerImageView.layer.masksToBounds = true
        self.containerImageView.clipsToBounds = true
        self.containerImageView.contentMode = .redraw
    }
    
    private func addViewLayoutSubViews() {
        // add subViews
        self.insertSubview(self.containerView, at: 0)
        self.containerView.addSubview(self.containerImageView)
        
        // add image constraints
        self.containerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.containerImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.containerImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        self.containerImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.containerImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // add view constraints
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        self.containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
//    private func addShadowColorFromBackgroundImage() {
//        // Get the averageColor from the image for set the Shadow Color
//        if shadowColorFormImage {
//            let week = self
//            DispatchQueue.main.async {
//                week.shadowColor = (week.containerImageView.image?.averageColor)!
//            }
//        }
//    }
    
    private func applyRadiusMaskFor() {
        guard cornerRadiusMulti else { return }
        
        let path = UIBezierPath(shouldRoundRect: bounds,
                                topLeftRadius: cornerTopLeftRadius,
                                topRightRadius: cornerTopRightRadius,
                                bottomLeftRadius: cornerBottomLeftRadius,
                                bottomRightRadius: cornerBottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }
}
