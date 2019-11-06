//
//  DNSAppConstants.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import Foundation
import UIKit

@objc
public protocol DNSAppConstantsRootProtocol: UITextFieldDelegate {
    @objc
    func checkBoxPressed(sender: UIButton)
}

open class DNSAppConstants: NSObject {
    static let shared       = DNSAppConstants()
    static let translator   = DNSDataTranslation()

    // MARK: - Constant plist to object functions
    public class func constant(from key: String, and filter: String = "") -> Bool {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.bool(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> CGFloat {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return CGFloat(translator.double(from: value)!)
    }
    public class func constant(from key: String, and filter: String = "") -> Date {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.date(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> Double {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.double(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> Int {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.int(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> String {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.string(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> UIColor {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.color(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> UInt {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.uint(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> URL {
        let value = self._constant(from: key, and: filter)
        assert(value != nil, "Constant '\(key)' \(filter.isEmpty ? "" : "with filter '\(filter)'") not found!")
        return translator.url(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") -> [Any] {
        guard let retval = self._constant(from: key, and: filter) else { return [] }
        guard (retval as? [Any]) != nil else { return [retval] }

        return retval as? [Any] ?? []
    }
    public class func constant(from key: String, and filter: String = "") -> [String: Any] {
        guard let retval = self._constant(from: key, and: filter) else { return [:] }
        guard (retval as? [String: Any]) != nil else { return ["key": retval] }

        return retval as? [String: Any] ?? [:]
    }

    // MARK: - Compound Constant plist to object functions

    // key + Name is the generated key for loading the font postscript name.
    // key + Scale is the appFontScaling override for @2x, @3x (ie: 1.0, 2.0, 3.0)
    // key + Size is the generated key for loading the font size in points. (divided by appFontScaling)
    public class func constant(from key: String, and filter: String = "") -> UIFont {
        let fontName: String    = self.constant(from: "\(key)Name", and: filter)
        let fontScale: Double   = self.constant(from: "\(key)Size", and: filter)
        let fontSize: Double    = self.constant(from: "\(key)Size", and: filter)

        return UIFont.dnsCustom(with: fontName, and: CGFloat(fontSize / fontScale))
    }

    // key + Height is the generated key for loading the height.
    // key + Width is the generated key for loading the width.
    public class func constant(from key: String, and filter: String = "") -> CGSize {
        let height: Double  = self.constant(from: "\(key)Height", and: filter)
        let width: Double   = self.constant(from: "\(key)Width", and: filter)

        return CGSize.init(width: width, height: height)
    }

    // MARK: - Internal Low-Level Methods
    private class func _constant(from key: String, and filter: String = "") -> Any? {
        var retval = plistConfigValue(for: key)

        if (retval as? [String: Any]) != nil {
            if !filter.isEmpty {
                retval = (retval as? [String: Any] ?? [:])[filter]!
            }
        }
        if (retval as? [String: Any]) != nil {
            retval = dictionarySelection(from: (retval as? [String: Any] ?? [:]), for: key)
        } else {
            // TODO(dme): Confirm this shouldn't be here!! retval = translator.string(from: retval)
        }
        if (retval as? String) != nil {
            var stringValue = retval as? String ?? ""
            while stringValue.contains("{{") {
                let stringValues = stringValue.components(separatedBy: "{{")
                if stringValues.count <= 1 {
                    break
                }

                let tokenFragment   = stringValues[1]
                let token: String   = tokenFragment.components(separatedBy: "}}").first!
                let tokenString     = "{{\(token)}}"

                var tokenValue: String?
                if token.contains(":") {
                    let selectionValues = token.components(separatedBy: ":")
                    let selectionToken  = selectionValues[0]
                    let selectionKey    = selectionValues[1]

                    tokenValue = dictionaryLookup(fromConstant: selectionToken, for: selectionKey)
                }
                if tokenValue == nil {
                    tokenValue = self.constant(from: token, and: filter)
                }
                if tokenValue == nil {
                    tokenValue = tokenString
                }

                retval = stringValue = stringValue.replacingOccurrences(of: tokenString, with: (tokenValue ?? ""))
            }
        }

        return retval
    }

    class func plistConfigValue(for key: String) -> Any? {
        return shared.plistDictionary()[key]
    }
    class func plistConfigValue(replace key: String, with value: Any) -> Any {
        var plistDict = shared.plistDictionary()
        plistDict.updateValue(value, forKey: key)
        return plistDict[key]!
    }

    private static var _plistDictionary: [String: Any] = [:]

    private func plistDictionary() -> [String: Any] {
        objc_sync_enter(DNSAppConstants._plistDictionary)
        defer { objc_sync_exit(DNSAppConstants._plistDictionary) }

        if !DNSAppConstants._plistDictionary.isEmpty {
            return DNSAppConstants._plistDictionary
        }

        let constantsName = DNSCore.appSetting(for: C.AppConstants.filenameOverride,
                                               withDefault: C.AppConstants.filenameDefault) as? String ?? ""
        guard let constantsPath = Bundle.main.path(forResource: constantsName, ofType: "plist") else {
            NSException.init(name: NSExceptionName(rawValue: "\(type(of: self)) Exception"),
                             reason: "Constants plist not found: \(constantsName)",
                             userInfo: nil).raise()
            return DNSAppConstants._plistDictionary
        }
        guard let constantsData = FileManager.default.contents(atPath: constantsPath) else {
            NSException.init(name: NSExceptionName(rawValue: "\(type(of: self)) Exception"),
                             reason: "Unable to read Constants plist: \(constantsName)",
                             userInfo: nil).raise()
            return DNSAppConstants._plistDictionary
        }

        var constantsFormat = PropertyListSerialization.PropertyListFormat.xml
        // swiftlint:disable:next force_try
        guard let retval = try!
            PropertyListSerialization.propertyList(from: constantsData,
                                                   options: .mutableContainersAndLeaves,
                                                   format: &constantsFormat) as? [String : Any] else {
            NSException.init(name: NSExceptionName(rawValue: "\(type(of: self)) Exception"),
                             reason: "Unable to initialize Constants Config Dictionary: \(constantsName)",
                             userInfo: nil).raise()
            return DNSAppConstants._plistDictionary
        }

        DNSAppConstants._plistDictionary = retval
        return retval
    }
}
