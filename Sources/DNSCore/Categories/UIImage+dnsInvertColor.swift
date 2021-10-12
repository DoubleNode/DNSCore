//
//  UIImage+dnsInvertColor.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIImage {
    public func dnsInvertColor() -> UIImage? {
        let filter = CIFilter(name: "CIColorInvert")
        filter?.setDefaults()
        filter?.setValue(self.ciImage, forKey: kCIInputImageKey)
        if let output = filter?.outputImage {
            return UIImage(ciImage: output)
        }
        return nil
    }
}
