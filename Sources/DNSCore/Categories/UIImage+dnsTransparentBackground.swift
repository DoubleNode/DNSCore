//
//  UIImage+dnsTransparentBackground.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIImage {
    public func dnsTransparentBackground() -> UIImage? {
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CIMaskToAlpha")
        filter?.setDefaults()
        filter?.setValue(self.ciImage, forKey: kCIInputImageKey)
        if let output = filter?.outputImage,
           let imageRef = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: imageRef)
        }
        return nil
    }
}
