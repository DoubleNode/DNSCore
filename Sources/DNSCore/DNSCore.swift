//
//  DoubleNode Swift Framework (DNSFramework) - DNSCore.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import DNSError
import Foundation
import os.lock
#if !os(macOS)
import UIKit
#endif

public protocol DNSCoreApplicationProtocol {
    // MARK: - Base methods

    func resetLogState()

    func buildString() -> String
    func bundleName() -> String
    func targetType() -> String
    func userAgentString() -> String
    func versionString() -> String

    func isReachable() -> Bool
    func networkActivity(display:Bool)
#if !os(macOS)
    func rootViewController() -> UIViewController
#endif
    func reportError(_ error: Error)
    func reportException(_ nsException: NSException)
    func reportLog(_ string: String)
    func shortenErrorPath(_ filename: String) -> String

    // MARK: - CoreData methods
    func disableUrlCache()
}

public class DNSCore {
    private static let translator = DNSDataTranslation()

    // MARK: - Thread-safe language code management
    private struct LanguageState {
        var languageCode: String
        var languageCodeOverride: String = ""
    }

    private static let languageLock = OSAllocatedUnfairLock(initialState: LanguageState(
        languageCode: {
            let currentLocale = NSLocale.current
            var languageCode = currentLocale.language.languageCode?.identifier ?? "en"
            if languageCode == "es" {
                languageCode = "es-419"
            }
            return languageCode
        }()
    ))

    public static var languageCode: String {
        get {
            languageLock.withLock { state in
                state.languageCode
            }
        }
        set {
            languageLock.withLock { state in
                state.languageCode = newValue
            }
        }
    }

    public static var languageCodeOverride: String {
        get {
            languageLock.withLock { state in
                state.languageCodeOverride
            }
        }
        set {
            languageLock.withLock { state in
                state.languageCodeOverride = newValue

                if newValue.isEmpty {
                    let currentLocale = NSLocale.current
                    var retval = currentLocale.language.languageCode?.identifier ?? "en"
                    if retval == "es" {
                        retval = "es-419"
                    }
                    state.languageCode = retval
                } else {
                    state.languageCode = newValue
                }
            }
        }
    }

    @MainActor
    @available(iOSApplicationExtension, unavailable)
    public class var appDelegate: DNSCoreApplicationProtocol? {
#if !os(macOS)
        return UIApplication.shared.delegate as? DNSCoreApplicationProtocol
#else
        return nil
//        return NSApplication.shared.delegate as? DNSCoreApplicationProtocol
#endif
    }

    // MARK: - Base methods

    @MainActor
    public class var buildString: String {
        return DNSCore.appDelegate?.buildString() ?? ""
    }
    @MainActor
    public class var bundleName: String {
        return DNSCore.appDelegate?.bundleName() ?? ""
    }
    @MainActor
    public class var targetType: String {
        return DNSCore.appDelegate?.targetType() ?? ""
    }
    @MainActor
    public class var userAgentString: String {
        return DNSCore.appDelegate?.userAgentString() ?? ""
    }
    @MainActor
    public class var versionString: String {
        return DNSCore.appDelegate?.versionString() ?? ""
    }
    @MainActor
    public class var appBuildString: String {
        return "\(DNSCore.bundleName) v\(DNSCore.versionString).\(DNSCore.buildString)"
    }
    @MainActor
    public class func reportError(_ error: Error) {
        DNSCore.appDelegate?.reportError(error)
    }
    @MainActor
    public class func reportException(_ nsException: NSException) {
        DNSCore.appDelegate?.reportException(nsException)
    }
    @MainActor
    public class func reportLog(_ string: String) {
        DNSCore.appDelegate?.reportLog(string)
    }
    @MainActor
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
