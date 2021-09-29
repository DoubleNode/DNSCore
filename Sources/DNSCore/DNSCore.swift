//
//  DoubleNode Swift Framework (DNSFramework) - DNSCore.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import DNSError
import Foundation
import UIKit

public protocol DNSCoreApplicationProtocol {
    // MARK: - Base methods

    func resetLogState()

    func buildString() -> String
    func bundleName() -> String
    func versionString() -> String

    func isReachable() -> Bool
    func networkActivity(display:Bool)
    func rootViewController() -> UIViewController

    func reportError(_ error: Error)
    func reportException(_ nsException: NSException)
    func reportLog(_ string: String)
    func shortenErrorPath(_ filename: String) -> String

    // MARK: - CoreData methods

    func disableUrlCache()
}

public class DNSCore {
    private static let translator   = DNSDataTranslation()

    @available(iOSApplicationExtension, unavailable)
    public class var appDelegate: DNSCoreApplicationProtocol? {
        var retval: DNSCoreApplicationProtocol?

        DNSUIThread.run {
            retval = UIApplication.shared.delegate as? DNSCoreApplicationProtocol
        }

        return retval
    }

    public static var languageCode: String = {
        let currentLocale = NSLocale.current
        var languageCode = currentLocale.languageCode ?? "en"
        if languageCode == "es" {
            languageCode = "es-419"
        }
        return languageCode
    }()

    // MARK: - Base methods

    public class var buildString: String {
        return DNSCore.appDelegate?.buildString() ?? ""
    }
    public class var bundleName: String {
        return DNSCore.appDelegate?.bundleName() ?? ""
    }
    public class var versionString: String {
        return DNSCore.appDelegate?.versionString() ?? ""
    }
    public class var appBuildString: String {
        return "\(DNSCore.bundleName) v\(DNSCore.versionString).\(DNSCore.buildString)"
    }
    public class func reportError(_ error: Error) {
        DNSCore.appDelegate?.reportError(error)
    }
    public class func reportException(_ nsException: NSException) {
        DNSCore.appDelegate?.reportException(nsException)
    }
    public class func reportLog(_ string: String) {
        DNSCore.appDelegate?.reportLog(string)
    }
    public class func shortenErrorPath(_ filename: String) -> String {
        return DNSCore.appDelegate?.shortenErrorPath(filename) ?? filename
    }

    // MARK: - NSUserDefaults Settings methods

    private class var appSettingsUserDefaults: UserDefaults {
        return UserDefaults.standard
    }

    public class func appSetting(for key:String, withDefault defaultValue:Any = "") -> Any {
        let retval: Any? = appSettingsUserDefaults.object(forKey: key)
        guard retval != nil else {
            appSettingsUserDefaults.set(defaultValue, forKey: key)
            appSettingsUserDefaults.synchronize()
            return defaultValue
        }

        return retval!
    }
    public class func appSetting(set key:String, with value:Any?) -> Any? {
        defer {
            settingsUserDefaults.synchronize()
        }

        guard value != nil else {
            settingsUserDefaults.removeObject(forKey: key)
            return nil
        }
        settingsUserDefaults.set(value, forKey: key)
        return value
    }

    private class var settingsUserDefaults: UserDefaults {
        let suiteName: String = DNSAppConstants.appGroupPath
        guard !suiteName.isEmpty else { return UserDefaults.standard }

        let retval = UserDefaults.init(suiteName: suiteName)
        guard retval != nil else { return UserDefaults.standard }

        return retval!
    }

    private class func _setting(for key:String, withDefault defaultValue:Any = "") -> Any {
        let retval: Any?    = settingsUserDefaults.object(forKey: key)
        guard retval != nil else {
            settingsUserDefaults.set(defaultValue, forKey: key)
            settingsUserDefaults.synchronize()
            return defaultValue
        }
        return retval ?? defaultValue
    }
    private class func _setting(set key:String, with value:Any?) -> Any? {
        defer {
            settingsUserDefaults.synchronize()
        }

        guard value != nil else {
            settingsUserDefaults.removeObject(forKey: key)
            return nil
        }
        settingsUserDefaults.set(value, forKey: key)
        return value
    }
    public class func setting(for key:String, withDefault defaultValue:Any = "") -> Any {
        return _setting(for: "Setting_\(key)", withDefault: defaultValue)
    }
    @discardableResult
    public class func setting(set key:String, with value:Any?) -> Any? {
        return _setting(set: "Setting_\(key)", with: value)
    }
}
