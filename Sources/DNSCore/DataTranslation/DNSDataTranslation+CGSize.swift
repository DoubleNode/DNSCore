//
//  DNSDataTranslation+CGSize.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

#if !os(macOS)
import DNSCoreThreading
import UIKit

public extension DNSDataTranslation {
    // MARK: - cgsize...
    func cgsize(from any: Any?) -> CGSize? {
        guard let any else { return nil }
        if any is CGSize {
            return self.cgsize(from: any as? CGSize)
        } else if any is DNSDataDictionary {
            return self.cgsize(from: any as? DNSDataDictionary)
        }
        return self.cgsize(from: any as? String)
    }
    func cgsize(from cgsize: CGSize?) -> CGSize? {
        guard let cgsize else { return nil }
        return cgsize
    }
    func cgsize(from dictionary: DNSDataDictionary?) -> CGSize? {
        guard let dictionary else { return nil }
        return CGSize(from: dictionary)
    }
    func cgsize(from string: String?) -> CGSize? {
        guard let string else { return nil }
        return CGSize(with: string)
    }
}
#endif
