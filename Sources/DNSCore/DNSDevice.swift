//
//  DNSDevice.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
#if os(macOS)
import AppKit

public class DNSDevice {
    public class var osVersion: String {
        return ProcessInfo.processInfo.operatingSystemVersionString
    }
    public class var deviceType: String {
        return ProcessInfo.processInfo.hostName
    }
    public class var model: String {
        return getNativeDeviceIdentifier()
    }

    private class func getNativeDeviceIdentifier() -> String {
        var size = 0
        sysctlbyname("hw.model", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.model", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    public class var modelName: String {
        // Since Device.model requires @MainActor, use a fallback approach
        return "Mac"
    }
    public class var isIpad: Bool {
        return false
    }
    public class var isIphone: Bool {
        return false
    }
    public class var isTv: Bool {
        return false
    }
    public class var isCarPlay: Bool {
        return false
    }
    public class var isMac: Bool {
        return true
    }
    public class var landscape: Bool {
        return false
    }
    public class var portrait: Bool {
        return false
    }
    public class var biometricIdAvailable: Bool {
        return false
    }
    public class var faceIdAvailable: Bool {
        return false
    }
    public class var touchIdAvailable: Bool {
        return false
    }
    public class var applicationDocumentsDirectory: String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                   FileManager.SearchPathDomainMask.allDomainsMask, true).last!
    }
}
#else
#if canImport(UIKit)
import UIKit
#endif

public class DNSDevice {
    public class var osVersion: String {
#if canImport(UIKit)
        return UIDevice.current.systemVersion
#else
        return ProcessInfo.processInfo.operatingSystemVersionString
#endif
    }
    // deviceType - eg: "iPhone"
    public class var deviceType: String {
#if canImport(UIKit)
        return UIDevice.current.model
#else
        return ProcessInfo.processInfo.hostName // TODO: Might be right or wrong
#endif
    }
    // deviceType - eg: "iPhone12,5"
    public class var model: String {
        return getNativeDeviceIdentifier()
    }

    private class func getNativeDeviceIdentifier() -> String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    // deviceType - eg: "iPhone 11 Pro Max"
    public class var modelName: String {
        // Since Device.model requires @MainActor, use a fallback approach for now
        // TODO: Convert to async property when possible
        return "Unknown Device"
    }
#if canImport(UIKit)
    public class var safeAreaInsets: UIEdgeInsets {
        return (UIApplication.dnsCurrentScene() as? UIWindowScene)?.windows.first?.safeAreaInsets ?? UIEdgeInsets.zero
    }
    public class var screenHeight: CGFloat {
        return UIScreen.main.bounds.height * UIScreen.main.scale
    }
    public class var screenHeightUnits: CGFloat {
        return UIScreen.main.bounds.height
    }
    public class var screenSize: CGSize {
        return CGSize.init(width: self.screenWidth, height: self.screenHeight)
    }
    public class var screenSizeUnits: CGSize {
        return CGSize.init(width: self.screenWidthUnits, height: self.screenHeightUnits)
    }
    public class var screenWidth: CGFloat {
        return UIScreen.main.bounds.width * UIScreen.main.scale
    }
    public class var screenWidthUnits: CGFloat {
        return UIScreen.main.bounds.width
    }
#endif

    public class var isIpad: Bool {
#if canImport(UIKit)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
#else
        return false
#endif
    }
    public class var isIphone: Bool {
#if canImport(UIKit)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
#else
        return false
#endif
    }
    public class var isTv: Bool {
#if canImport(UIKit)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.tv
#else
        return false
#endif
    }
    public class var isCarPlay: Bool {
#if canImport(UIKit)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.carPlay
#else
        return false
#endif
    }
    public class var isMac: Bool {
#if canImport(UIKit)
        return false
#else
        return true
#endif
    }
#if canImport(UIKit)
    public class var tallPhone: Bool {
        return self.isIphone && self.screenHeight >= 1136
    }
#endif

#if canImport(UIKit)
    public class var activeWindowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
    public class var activeWindow: UIWindow? {
        return self.activeWindowScene?.windows.first
    }
#endif

    public class var landscape: Bool {
        #if os(tvOS)
            return true
        #elseif os(iOS)
            if self.activeWindowScene?.interfaceOrientation == .landscapeLeft ||
                self.activeWindowScene?.interfaceOrientation == .landscapeRight {
                return true
            }
        #endif
        return false
    }
    public class var portrait: Bool {
        #if os(tvOS)
            return false
        #elseif os(iOS)
            if self.activeWindowScene?.interfaceOrientation == .portrait ||
                self.activeWindowScene?.interfaceOrientation == .portraitUpsideDown {
                return true
            }
        #endif
        return false
    }
    public class var biometricIdAvailable: Bool {
        if #available(iOS 13, *) {
            guard NSClassFromString("LAContext") != nil else { return false }
            guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                return false
            }
            return true
        } else {
            return false
        }
    }
    public class var faceIdAvailable: Bool {
        #if os(tvOS)
            return false
        #elseif os(iOS)
            guard NSClassFromString("LAContext") != nil else { return false }
            guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                return false
            }
            guard #available(iOS 11, *) else { return false }
            guard LAContext.init().biometryType == LABiometryType.faceID else { return false }
            return true
        #else
            return false
        #endif
    }
    public class var touchIdAvailable: Bool {
        #if os(tvOS)
            return false
        #elseif os(iOS)
            guard NSClassFromString("LAContext") != nil else { return false }
            guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                return false
            }
            if #available(iOS 11, *) {
                guard LAContext.init().biometryType == LABiometryType.touchID else { return false }
            }

            return true
        #else
            return false
        #endif
    }
    public class var applicationDocumentsDirectory: String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                   FileManager.SearchPathDomainMask.allDomainsMask, true).last!
    }
}
#endif
