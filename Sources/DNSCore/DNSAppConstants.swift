//
//  DNSAppConstants.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import DNSError
import Foundation
#if !os(macOS)
import UIKit

@objc
public protocol DNSAppConstantsRootProtocol: UITextFieldDelegate {
    @objc
    func checkBoxPressed(sender: UIButton)
}
#endif

open class DNSAppConstants: NSObject {
    static public var shared = DNSAppConstants()
    static public var translator = DNSDataTranslation()

    static public var uniqueDeviceId: String = {
        return "iOS-" + DNSAppConstants.targetType + "-" +
            (UIDevice.current.identifierForVendor?.uuidString ?? "")
    }()
    static public var targetType: String = {
        return DNSCore.targetType
    }()
    public enum APIType: String {
        case unknown, dev, qa, alpha, beta, gamma, prod
    }
    public enum BuildType: String {
        case unknown, dev, qa, alpha, beta, gamma, prod
    }
    public enum EnvType: String {
        case unknown, dev, qa, prod
    }

    static public var appAPIType: APIType {
        DNSAppConstants.shared.appAPITypeRead()
    }
    static public var appBuildType: BuildType {
        DNSAppConstants.shared.appBuildTypeRead()
    }
    static public var appEnvType: EnvType {
        DNSAppConstants.shared.appEnvTypeRead()
    }

    open func appAPITypeRead() -> APIType {
        return .unknown
    }
    open func appBuildTypeRead() -> BuildType {
        return .unknown
    }
    open func appEnvTypeRead() -> EnvType {
        return .unknown
    }

    override public required init() {
        super.init()
        DNSAppConstants.resetPlistDictionary()
    }

    // class formatter functions
    public var asCurrency: NumberFormatter { Self.currencyFormatter() }
    public var asCurrencyInt: NumberFormatter { Self.currencyIntFormatter() }
    public var asDistance: MeasurementFormatter { Self.distanceFormatter() }
    public var asInt: NumberFormatter { Self.intFormatter() }
    public var asPercentage: NumberFormatter { Self.percentageFormatter() }

    open class func currencyFormatter() -> NumberFormatter {
        DNSAppConstants.defaultCurrencyFormatter
    }
    open class func currencyIntFormatter() -> NumberFormatter {
        DNSAppConstants.defaultCurrencyIntFormatter
    }
    open class func distanceFormatter() -> MeasurementFormatter {
        DNSAppConstants.defaultDistanceFormatter
    }
    open class func intFormatter() -> NumberFormatter {
        DNSAppConstants.defaultIntFormatter
    }
    open class func percentageFormatter() -> NumberFormatter {
        DNSAppConstants.defaultPercentageFormatter
    }

    // MARK: - Constant plist to object functions
    public class func constant(from key: String, and filter: String = "") throws -> Bool {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return translator.bool(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") throws -> CGFloat {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return CGFloat(translator.double(from: value)!)
    }
    public class func constant(from key: String, and filter: String = "") throws -> Date {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return translator.date(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") throws -> Double {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return translator.double(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") throws -> Int {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return translator.int(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") throws -> String {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return translator.string(from: value)!
    }
#if !os(macOS)
    public class func constant(from key: String, and filter: String = "") throws -> UIColor {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return translator.color(from: value)!
    }
#endif
    public class func constant(from key: String, and filter: String = "") throws -> UInt {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
        return translator.uint(from: value)!
    }
    public class func constant(from key: String, and filter: String = "") throws -> URL {
        let value = self._constant(from: key, and: filter)
        guard value != nil else { throw DNSError.Core
            .notFound(field: key, value: filter, .core(self)) }
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

#if !os(macOS)
    // key + Name is the generated key for loading the font postscript name.
    // key + Scale is the appFontScaling override for @2x, @3x (ie: 1.0, 2.0, 3.0)
    // key + Size is the generated key for loading the font size in points. (divided by appFontScaling)
    public class func constant(from key: String, and filter: String = "") throws -> UIFont {
        let fontName: String = try self.constant(from: "\(key)Name", and: filter)
        let fontScale: Double = try self.constant(from: "\(key)Size", and: filter)
        let fontSize: Double = try self.constant(from: "\(key)Size", and: filter)

        return UIFont.dnsCustom(with: fontName, and: CGFloat(fontSize / fontScale))
    }
#endif
    // key + Height is the generated key for loading the height.
    // key + Width is the generated key for loading the width.
    public class func constant(from key: String, and filter: String = "") throws -> CGSize {
        let height: Double = try self.constant(from: "\(key)Height", and: filter)
        let width: Double = try self.constant(from: "\(key)Width", and: filter)

        return CGSize.init(width: width, height: height)
    }

    // MARK: - Internal Low-Level Methods
    private class func _constant(from key: String, and filter: String = "") -> Any? {
        let plistDictionary = shared.plistDictionary()
        return _constant(in: plistDictionary, from: key, and: filter)
    }

    private class func _constant(in plistData: [String: Any], from key: String, and filter: String = "") -> Any? {
        // swiftlint:disable:next force_cast
        let stringKey = stringTokenReplacement(with: key, and: filter) as! String

        var retval = plistData[stringKey]
        if retval == nil {
            if stringKey.contains(".") {
                let stringKeys = stringKey.components(separatedBy: ".")
                if stringKeys.count > 1 {
                    let subPlistData: [String: Any]? = plistData[stringKeys[0]] as? [String: Any]
                    if subPlistData != nil {
                        var subKey = stringKeys[1]
                        for i in 2..<stringKeys.count {
                            subKey += "." + stringKeys[i]
                        }
                        retval = _constant(in: subPlistData!, from: subKey, and: filter)
                    }
                }
            }
        }

        if (retval as? [String: Any]) != nil {
            if !filter.isEmpty {
                retval = (retval as? [String: Any] ?? [:])[filter]!
            }
        }
        if (retval as? [String: Any]) != nil {
            retval = dictionarySelection(from: (retval as? [String: Any] ?? [:]), for: stringKey)
        } else {
            // TODO(dme): Confirm this shouldn't be here!! retval = translator.string(from: retval)
        }
        if (retval as? String) != nil {
            // swiftlint:disable:next force_cast
            retval = stringTokenReplacement(with: retval as! String, and: filter)
        }

        return retval
    }

    class func stringTokenReplacement(with string: String, and filter: String = "") -> Any? {
        var retval = string

        while retval.contains("{{") {
            let stringValues = retval.components(separatedBy: "{{")
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
                do {
                    tokenValue = try self.constant(from: token, and: filter)
                } catch {
                    tokenValue = nil
                }
            }
            if tokenValue == nil {
                tokenValue = tokenString
            }

            retval = retval.replacingOccurrences(of: tokenString, with: (tokenValue ?? ""))
        }

        return retval
    }

    class func plistConfigValue(for key: String) -> Any? {
        return shared.plistDictionary()[key]
    }
    class func plistConfigValue(replace key: String, with value: Any) -> Any {
        var plistDict = shared.plistDictionary()
        plistDict.updateValue(value, forKey: key)
        shared.merge(constants: plistDict)
        return plistDict[key]!
    }

    public class func resetPlistDictionary() {
        self._plistDictionary = [:]
    }
    private static var _plistDictionary: [String: Any] = [:]

    public func merge(constants: [String: Any]) {
        DNSAppConstants._plistDictionary.merge(constants) { (_, new) in new }
    }

    private let semaphoreLoadFuncards = DNSSemaphoreGate(count: 1)
    private func plistDictionary() -> [String: Any] {
        _ = self.semaphoreLoadFuncards.wait()
        defer { _ = self.semaphoreLoadFuncards.done() }

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
