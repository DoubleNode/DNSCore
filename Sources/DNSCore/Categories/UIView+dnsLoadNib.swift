//
//  UIView+dnsNib.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import UIKit

public extension UIView {
    @discardableResult
    func dnsLoadNib<T: UIView>(from bundle: Bundle?) -> T? {
        let bundle = bundle ?? Bundle.module
        guard bundle.path(forResource: String(describing: type(of: self)),
                          ofType: "nib") != nil else {
            // file not exists
            return nil
        }
        guard let contentView = bundle.loadNibNamed(String(describing: type(of: self)),
                                                    owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fixConstraintsInView(self)
        return contentView
    }
    func fixConstraintsInView(_ container: UIView!) {
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                           toItem: container, attribute: .leading, multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                           toItem: container, attribute: .trailing, multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                           toItem: container, attribute: .top, multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                           toItem: container, attribute: .bottom, multiplier: 1.0,
                           constant: 0).isActive = true
    }
}
#endif
