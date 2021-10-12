//
//  UIImage+dnsBarcode.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension UIImage {
    static func barcode(from code: String,
                        scale: CGFloat = 3) -> UIImage? {
        guard !code.isEmpty else { return nil }
        let data = code.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
