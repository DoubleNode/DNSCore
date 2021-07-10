//
//  UIColor+dnsString.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIImage {
    convenience init?(color: UIColor, width: CGFloat, height: CGFloat) {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: height / 2)
        color.setFill()
        bezierPath.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        guard let cgImage = image.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}
