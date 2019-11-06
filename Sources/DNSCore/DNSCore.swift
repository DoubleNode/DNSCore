//
//  DNSCore.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
import UIKit

@objc
public protocol DNSCoreApplicationProtocol {
    // MARK: - Base methods

    func resetLogState()

    func buildString() -> String
    func bundleName() -> String
    func versionString() -> String

    func isReachable() -> Bool
    func networkActivity(display:Bool)
    func rootViewController() -> UIViewController

    // MARK: - CoreData methods

    func disableUrlCache()
}

public class DNSCore {
    private static let translator   = DNSDataTranslation()

    public class var appDelegate: DNSCoreApplicationProtocol {
        var retval: DNSCoreApplicationProtocol?

        DNSUIThread.run {
            retval = UIApplication.shared.delegate as? DNSCoreApplicationProtocol
        }

        return retval!
    }

    // MARK: - Base methods

    public class var buildString: String {
        return DNSCore.appDelegate.buildString()
    }
    public class var bundleName: String {
        return DNSCore.appDelegate.bundleName()
    }
    public class var versionString: String {
        return DNSCore.appDelegate.versionString()
    }

    // MARK: - NSUserDefaults Settings methods

    private class var appSettingsUserDefaults: UserDefaults {
        return UserDefaults.standard
    }

    class func appSetting(for key:String, withDefault defaultValue:Any = "") -> Any {
        let retval: Any?    = appSettingsUserDefaults.object(forKey: key)
        guard retval != nil else { return appSettingsUserDefaults.set(defaultValue, forKey: key) }

        return retval ?? defaultValue
    }
    class func appSetting(set key:String, with value:Any?) -> Any? {
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
        guard retval != nil else { return settingsUserDefaults.set(defaultValue, forKey: key) }
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
    public class func setting(set key:String, with value:Any?) -> Any? {
        return _setting(set: "Setting_\(key)", with: value)
    }
}